<?php
/**
 * Tasks Management Template Part - Kanban Board with History
 */

// Everyone can see all user boards
$is_admin = current_user_can('manage_options');
$current_user_id = get_current_user_id();

$tasks = get_all_tasks();
$task_history = get_task_history();

// Normalize legacy/mixed status values to canonical keys used by UI
if (!function_exists('wh_normalize_status')) {
    function wh_normalize_status($status) {
        $s = strtolower(trim((string)$status));
        // common variants
        $map = array(
            'in progress' => 'in_progress',
            'in-progress' => 'in_progress',
            'doing' => 'in_progress',
            'work_in_progress' => 'in_progress',
            'wip' => 'in_progress',
            'done' => 'completed',
            'complete' => 'completed',
            'completed' => 'completed',
            'todo' => 'pending',
            'to_do' => 'pending',
            'pending' => 'pending',
            'archived' => 'archived',
        );
        return $map[$s] ?? $s;
    }
}

// Group tasks by status
$grouped_tasks = array(
    'pending' => array(),
    'in_progress' => array(),
    'completed' => array()
);

if ($tasks) {
    foreach ($tasks as $task) {
        $normalized = wh_normalize_status($task->status);
        if ($normalized !== 'archived') {
            $task->status = $normalized;
            if (!isset($grouped_tasks[$normalized])) { $grouped_tasks[$normalized] = array(); }
            $grouped_tasks[$normalized][] = $task;
        }
    }
}
?>

<div class="tasks-content">
    <div class="page-header">
        <h1>📋 Tasks Management</h1>
        <div class="header-actions">
            <button class="btn btn-outline" onclick="toggleTopPanels(); showHistoryPanel();">
                <i class="fas fa-history"></i> History
            </button>
            <button class="btn btn-outline" id="team-chat-button" onclick="toggleTopPanels(); showChatPanel();" style="position:relative;">
                <i class="fas fa-comments"></i> Team Chat
                <span id="chat-unread-badge" class="chat-unread-badge" style="display:none;">0</span>
            </button>
            <button class="btn btn-outline" id="refresh-board-btn" title="Refresh tasks" onclick="refreshTasksBoard()">
                <i class="fas fa-sync"></i> Refresh
            </button>
            <button class="btn btn-outline" onclick="showGlobalBoard()">
                <i class="fas fa-columns"></i> Global Board
            </button>
            <button class="btn btn-outline" onclick="showUserBoards()">
                <i class="fas fa-users"></i> User Boards
            </button>
            <button class="btn btn-primary" onclick="document.getElementById('add-task-modal').classList.remove('hidden'); console.log('Button clicked!');">
                <i class="fas fa-plus"></i> Add Task
            </button>
            <span id="board-refreshed-at" style="margin-left:.75rem;font-size:.85rem;opacity:.8;"></span>
        </div>
    </div>

    <!-- Top Panels: History (left) and Chat (right) -->
    <div class="top-panels" id="top-panels" style="display:none;grid-template-columns: repeat(2, minmax(280px, 1fr)); gap: 1rem; margin-bottom: 1.25rem;">
        <div class="top-panel" id="history-panel">
            <div class="sidebar-content">
                <div style="text-align:center;padding:2rem;opacity:.8;"><i class="fas fa-spinner fa-spin"></i> Loading history…</div>
            </div>
        </div>
        <div class="top-panel" id="team-chat-panel">
            <div class="chat-messages" id="chat-messages"></div>
            <div class="chat-input-container">
                <div class="chat-input-wrapper">
                    <input type="text" id="chat-message-input" placeholder="Type your message..." class="chat-input">
                    <button onclick="sendChatMessage()" class="btn btn-primary chat-send-btn">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="tasks-main-container">
        <!-- Tasks Section (Admin: global board; Non-admin: personal board) -->
        <div class="tasks-section" id="tasks-section" data-loading="0">
            <div class="loading-overlay hidden" id="tasks-loading-overlay" aria-hidden="true" style="position:relative;">
                <div style="position:absolute;inset:0;display:flex;align-items:center;justify-content:center;backdrop-filter:blur(2px);">
                    <div style="display:flex;align-items:center;gap:.5rem;background:rgba(15,23,42,.6);color:#e5e7eb;padding:.75rem 1rem;border-radius:10px;">
                        <i class="fas fa-sync fa-spin"></i>
                        <span>Loading latest tasks…</span>
                    </div>
                </div>
            </div>
            <!-- Kanban Board -->
            <div class="kanban-board" id="kanban-board">
                <!-- Pending Column -->
                <div class="kanban-column" data-status="pending">
                    <div class="column-header">
                        <div class="column-title">
                            <i class="fas fa-clock"></i>
                            <span>Pending</span>
                            <span class="task-count"><?php echo count($grouped_tasks['pending']); ?></span>
                        </div>
                    </div>
                    <div class="column-content" ondrop="drop(event)" ondragover="allowDrop(event)">
                        <?php foreach ($grouped_tasks['pending'] as $task): ?>
                            <?php include get_template_directory() . '/template-parts/task-card-template.php'; ?>
                        <?php endforeach; ?>
                        
                        <?php if (empty($grouped_tasks['pending'])): ?>
                            <div class="empty-column">
                                <i class="fas fa-plus-circle"></i>
                                <p>No pending tasks</p>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>

                <!-- In Progress Column -->
                <div class="kanban-column" data-status="in_progress">
                    <div class="column-header">
                        <div class="column-title">
                            <i class="fas fa-spinner"></i>
                            <span>In Progress</span>
                            <span class="task-count"><?php echo count($grouped_tasks['in_progress']); ?></span>
                        </div>
                    </div>
                    <div class="column-content" ondrop="drop(event)" ondragover="allowDrop(event)">
                        <?php foreach ($grouped_tasks['in_progress'] as $task): ?>
                            <?php include get_template_directory() . '/template-parts/task-card-template.php'; ?>
                        <?php endforeach; ?>
                        
                        <?php if (empty($grouped_tasks['in_progress'])): ?>
                            <div class="empty-column">
                                <i class="fas fa-play-circle"></i>
                                <p>No tasks in progress</p>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>

                <!-- Completed Column -->
                <div class="kanban-column" data-status="completed">
                    <div class="column-header">
                        <div class="column-title">
                            <i class="fas fa-check-circle"></i>
                            <span>Completed</span>
                            <span class="task-count"><?php echo count($grouped_tasks['completed']); ?></span>
                        </div>
                    </div>
                    <div class="column-content" ondrop="drop(event)" ondragover="allowDrop(event)">
                        <?php foreach ($grouped_tasks['completed'] as $task): ?>
                            <?php include get_template_directory() . '/template-parts/task-card-template.php'; ?>
                        <?php endforeach; ?>
                        
                        <?php if (empty($grouped_tasks['completed'])): ?>
                            <div class="empty-column">
                                <i class="fas fa-check-circle"></i>
                                <p>No completed tasks</p>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar Section legacy (hidden) -->
        <div class="sidebar-section" style="display:none;">

            <!-- History Panel -->
            <div id="history-panel-legacy" class="sidebar-panel hidden">
                <div class="sidebar-content">
                    <?php if ($task_history): ?>
                        <?php foreach ($task_history as $history_item): ?>
                            <div class="history-item">
                                <div class="history-date">
                                    <i class="fas fa-calendar-check"></i>
                                    <?php echo date('M j, Y - g:i A', strtotime($history_item->completed_at)); ?>
                                </div>
                                
                                <div class="history-task">
                                    <h4><?php echo esc_html($history_item->title); ?></h4>
                                    <p><?php echo esc_html($history_item->description); ?></p>
                                    
                                    <div class="history-meta">
                                        <span class="priority priority-<?php echo esc_attr($history_item->priority); ?>">
                                            <?php echo esc_html(ucfirst($history_item->priority)); ?>
                                        </span>
                                        
                                        <span class="assignee">
                                            <i class="fas fa-user"></i>
                                            <?php echo esc_html(isset($history_item->assigned_to_name) ? $history_item->assigned_to_name : 'Unassigned'); ?>
                                        </span>
                                        
                                        <?php if ($history_item->created_at && $history_item->completed_at): ?>
                                        <span class="duration">
                                            <i class="fas fa-clock"></i>
                                            <?php 
                                            $created = new DateTime($history_item->created_at);
                                            $completed = new DateTime($history_item->completed_at);
                                            $interval = $created->diff($completed);
                                            echo $interval->format('%a days %h hours');
                                            ?>
                                        </span>
                                        <?php endif; ?>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <div class="empty-history">
                            <i class="fas fa-archive"></i>
                            <h4>No completed tasks yet</h4>
                            <p>Completed tasks will appear here with timestamps.</p>
                            <p class="retention-notice"><i class="fas fa-clock"></i> Task history is kept for 6 months</p>
                        </div>
                    <?php endif; ?>
        </div>
    </div>

    <!-- User Boards Section (visible to all) -->
    <section id="user-boards-section" style="margin-top:2rem;">
        <h2 style="display:flex;align-items:center;gap:.5rem;margin:0 0 1rem 0;">
            <i class="fas fa-users"></i>
            User Task Boards
        </h2>
        <div id="user-boards-container" style="display:flex;flex-direction:column;gap:1rem;">
            <?php 
            // Server-side initial render of user boards (ensures visibility even if JS fails)
            $users = get_users(array('role__in' => array('administrator','warehouse_manager','warehouse_employee')));
            $tasks_by_user = array();
            foreach (($tasks ?: array()) as $t) {
                $uid = intval($t->assigned_to);
                if (!$uid) { continue; }
                $status = function_exists('wh_normalize_status') ? wh_normalize_status($t->status) : $t->status;
                if (!isset($tasks_by_user[$uid])) { $tasks_by_user[$uid] = array('pending'=>array(),'in_progress'=>array(),'completed'=>array()); }
                if (isset($tasks_by_user[$uid][$status])) { $tasks_by_user[$uid][$status][] = $t; }
            }
            foreach ($users as $u): 
                $uid = intval($u->ID);
                $b = isset($tasks_by_user[$uid]) ? $tasks_by_user[$uid] : array('pending'=>array(),'in_progress'=>array(),'completed'=>array());
            ?>
            <div class="user-board" data-user-id="<?php echo $uid; ?>" style="border:1px solid rgba(148,163,184,.2);border-radius:10px;">
                <div class="user-board-header" style="display:flex;align-items:center;justify-content:space-between;padding:.5rem 1rem;">
                    <div style="display:flex;align-items:center;gap:.5rem;">
                        <i class="fas fa-user"></i>
                        <strong><?php echo esc_html($u->display_name); ?></strong>
                    </div>
                    <div class="user-board-counts" id="<?php echo 'user-board-' . $uid . '-counts'; ?>" style="opacity:.8;font-size:.9rem;">
                        Pending <?php echo count($b['pending']); ?> • In Progress <?php echo count($b['in_progress']); ?> • Completed <?php echo count($b['completed']); ?>
                    </div>
                </div>
                <div class="user-board-body" id="<?php echo 'user-board-' . $uid; ?>" style="padding: .5rem 1rem 1rem 1rem;">
                    <div class="kanban-board" style="display:grid;grid-template-columns:repeat(3, minmax(260px, 1fr));gap:1rem;">
                        <?php foreach (array('pending'=>'fa-clock','in_progress'=>'fa-spinner','completed'=>'fa-check-circle') as $st => $icon): ?>
                        <div class="kanban-column" data-status="<?php echo $st; ?>">
                            <div class="column-header"><div class="column-title"><i class="fas <?php echo $icon; ?>"></i> <span><?php echo ucwords(str_replace('_',' ', $st)); ?></span> <span class="task-count"><?php echo count($b[$st]); ?></span></div></div>
                            <div class="column-content" ondrop="drop(event)" ondragover="allowDrop(event)">
                                <?php foreach ($b[$st] as $task): $task->status = $st; include get_template_directory() . '/template-parts/task-card-template.php'; endforeach; ?>
                                <?php if (empty($b[$st])): ?>
                                    <div class="empty-column">
                                        <i class="fas <?php echo $st==='pending'?'fa-plus-circle':($st==='in_progress'?'fa-play-circle':'fa-check-circle'); ?>"></i>
                                        <p>No <?php echo esc_html(str_replace('_',' ', $st)); ?> tasks</p>
                                    </div>
                                <?php endif; ?>
                            </div>
                        </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
    </section>

            
        </div>
    </div>
</div>

<!-- Add Task Modal -->
<div id="add-task-modal" class="task-modal-overlay hidden">
    <div class="task-modal">
        <div class="task-modal-header">
            <h3>Add New Task</h3>
            <button type="button" id="modal-close-x" style="background:none;border:none;font-size:20px;cursor:pointer;">&times;</button>
        </div>
        <div class="task-modal-body">
            <form id="add-task-form">
                <table style="width:100%;border-spacing:0;">
                    <tr>
                        <td style="padding:10px 0;">
                            <label style="display:block;margin-bottom:5px;font-weight:bold;">Task Title *</label>
                            <input type="text" name="title" required placeholder="Enter task title" 
                                   style="width:100%;padding:10px;border:1px solid #ccc;border-radius:4px;box-sizing:border-box;">
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:10px 0;">
                            <label style="display:block;margin-bottom:5px;font-weight:bold;">Description</label>
                            <textarea name="description" rows="3" placeholder="Enter task description (optional)"
                                      style="width:100%;padding:10px;border:1px solid #ccc;border-radius:4px;box-sizing:border-box;resize:vertical;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:10px 0;">
                            <label style="display:block;margin-bottom:5px;font-weight:bold;">Assign To</label>
                            <select name="assigned_to" style="width:100%;padding:10px;border:1px solid #ccc;border-radius:4px;box-sizing:border-box;">
                                <option value="<?php echo get_current_user_id(); ?>">Assign to Me</option>
                                <?php 
                                $users = get_users(array('role__in' => array('administrator', 'warehouse_manager', 'warehouse_employee')));
                                foreach ($users as $user): 
                                    if ($user->ID != get_current_user_id()): ?>
                                        <option value="<?php echo $user->ID; ?>"><?php echo esc_html($user->display_name); ?></option>
                                    <?php endif;
                                endforeach; ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:10px 0;">
                            <label style="display:block;margin-bottom:5px;font-weight:bold;">Priority</label>
                            <select name="priority" style="width:100%;padding:10px;border:1px solid #ccc;border-radius:4px;box-sizing:border-box;">
                                <option value="low">Low</option>
                                <option value="medium" selected>Medium</option>
                                <option value="high">High</option>
                                <option value="urgent">Urgent</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:10px 0;">
                            <label style="display:block;margin-bottom:5px;font-weight:bold;">Due Date (Optional)</label>
                            <input type="date" name="due_date" 
                                   style="width:100%;padding:10px;border:1px solid #ccc;border-radius:4px;box-sizing:border-box;">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="task-modal-footer">
            <button type="button" id="modal-cancel-btn"
                    style="padding:10px 20px;margin-right:10px;background:#f5f5f5;border:1px solid #ccc;border-radius:4px;cursor:pointer;">Cancel</button>
            <button type="button" id="modal-submit-btn"
                    style="padding:10px 20px;background:#007cba;color:white;border:none;border-radius:4px;cursor:pointer;">Add Task</button>
        </div>
    </div>
</div>

<style>
.tasks-content {
    max-width: 100%;
    margin: 0 auto;
    padding: 2rem 1rem;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.page-header h1 {
    margin: 0;
    color: #1f2937;
    font-size: 2rem;
    font-weight: 600;
}

.header-actions {
    display: flex;
    gap: 1rem;
}

/* Main Layout Styles */
.tasks-main-container {
    display: grid;
    grid-template-columns: minmax(0, 1fr) clamp(240px, 22vw, 340px);
    min-height: calc(100vh - 120px);
    background: #f8fafc;
    gap: 1rem;
}

.tasks-section {
    flex: 1;
    padding: 1.5rem;
    overflow: hidden;
    min-width: 0;
}

.sidebar-section {
    background: white;
    border-left: 1px solid #e5e7eb;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}



/* Sidebar Panels */
.sidebar-panel {
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.sidebar-panel.hidden {
    display: none;
}

.sidebar-content {
    flex: 1;
    overflow-y: auto;
    padding: 1rem;
}

.kanban-board {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1rem;
    height: 100%;
    min-width: 0; /* allow grid to shrink within container */
}

/* Ensure 3 readable columns on common laptops (13–17") */
/* Always keep 3 columns; no breakpoint overrides */

/* Keep layout consistent on mobile as well (3 columns remain visible) */

.kanban-column {
    background: transparent;
    border: none;
    border-radius: 0;
    padding: 0;
    min-height: 600px;
    display: flex;
    flex-direction: column;
    min-width: 0; /* prevent overflow inside columns */
}

.column-header {
    margin-bottom: 0.75rem;
    position: sticky;
    top: 0;
    z-index: 1;
}

.column-title {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-weight: 600;
    font-size: 1.1rem;
    color: #374151;
}

.task-count {
    background: #e5e7eb;
    color: #6b7280;
    padding: 0.25rem 0.5rem;
    border-radius: 12px;
    font-size: 0.75rem;
    font-weight: 500;
    margin-left: auto;
}

.column-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
    min-height: 400px;
    padding: 0 0.25rem 0.5rem 0.25rem;
    border-radius: 8px;
    transition: background-color 0.2s;
}

.column-content.drag-over {
    background: #e0f2fe;
    border: 2px dashed #0284c7;
}

.task-card {
    background: white;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
    padding: 1rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    cursor: grab;
    transition: all 0.2s;
    position: relative;
}

.task-card:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    transform: translateY(-2px);
}

.task-card:active {
    cursor: grabbing;
}

.task-card.dragging {
    opacity: 0.5;
    transform: rotate(5deg);
}

.task-priority {
    position: absolute;
    left: 0;
    top: 0;
    width: 4px;
    height: 100%;
    border-radius: 4px 0 0 4px;
}

.priority-low { background: #10b981; }
.priority-medium { background: #f59e0b; }
.priority-high { background: #ef4444; }
.priority-urgent { background: #dc2626; }

.task-content {
    margin-left: 1rem;
}

.task-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 0.5rem;
}

.task-header h4 {
    margin: 0;
    font-size: 0.95rem;
    font-weight: 600;
    color: #111827;
    line-height: 1.3;
}

.task-actions {
    opacity: 0;
    transition: opacity 0.2s;
}

.task-card:hover .task-actions {
    opacity: 1;
}

.task-description {
    color: #6b7280;
    font-size: 0.875rem;
    margin-bottom: 1rem;
    line-height: 1.4;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.task-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    font-size: 0.75rem;
    color: #6b7280;
    margin-bottom: 0.5rem;
}

.task-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 0.75rem;
    color: #9ca3af;
    border-top: 1px solid #f3f4f6;
    padding-top: 0.5rem;
}

.task-id {
    font-weight: 600;
    color: #6b7280;
}

.empty-column {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 2rem;
    color: #9ca3af;
    text-align: center;
    border: 2px dashed #d1d5db;
    border-radius: 8px;
    margin-top: 2rem;
}

.empty-column i {
    font-size: 2rem;
    margin-bottom: 0.5rem;
}



.history-item {
    padding: 1rem;
    border-bottom: 1px solid #f3f4f6;
    transition: background 0.2s;
}

.history-item:hover {
    background: #f8fafc;
}

.history-item:last-child {
    border-bottom: none;
}

.history-date {
    color: #059669;
    font-size: 0.75rem;
    font-weight: 600;
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.history-task h4 {
    margin: 0 0 0.25rem 0;
    font-size: 0.95rem;
    color: #111827;
}

.history-task p {
    color: #6b7280;
    font-size: 0.875rem;
    margin: 0 0 0.75rem 0;
    line-height: 1.4;
}

.history-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
    font-size: 0.75rem;
}

.history-meta .priority {
    padding: 0.25rem 0.5rem;
    border-radius: 12px;
    font-weight: 600;
    text-transform: uppercase;
}

.history-meta .priority-low { background: #d1fae5; color: #065f46; }
.history-meta .priority-medium { background: #fef3c7; color: #92400e; }
.history-meta .priority-high { background: #fee2e2; color: #991b1b; }
.history-meta .priority-urgent { background: #fecaca; color: #7f1d1d; }

.history-meta span {
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    font-size: 0.75rem;
    margin-right: 1rem;
}

.priority {
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    font-weight: 600;
    text-transform: uppercase;
}

.priority-low {
    background: #d1fae5;
    color: #065f46;
}

.priority-medium {
    background: #fef3c7;
    color: #92400e;
}

.priority-high {
    background: #fee2e2;
    color: #991b1b;
}

.empty-history {
    text-align: center;
    padding: 3rem 2rem;
    color: #6b7280;
}

.empty-history i {
    font-size: 3rem;
    color: #d1d5db;
    margin-bottom: 1rem;
    display: block;
}

.empty-history h4 {
    margin: 0 0 0.5rem 0;
    color: #374151;
}

.empty-history p {
    margin: 0;
    font-size: 0.9rem;
}

/* Modal Styles */
.modal-overlay {
    position: fixed !important;
    top: 0 !important;
    left: 0 !important;
    right: 0 !important;
    bottom: 0 !important;
    width: 100vw !important;
    height: 100vh !important;
    background: rgba(0, 0, 0, 0.5) !important;
    z-index: 999999 !important;
}

.modal-overlay.hidden {
    display: none !important;
}

.modal {
    position: absolute !important;
    top: 50% !important;
    left: 50% !important;
    transform: translate(-50%, -50%) !important;
    background: white !important;
    border-radius: 8px !important;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3) !important;
    width: 500px !important;
    max-width: 90vw !important;
    max-height: 90vh !important;
    overflow: hidden !important;
}

.modal-header {
    padding: 20px !important;
    border-bottom: 1px solid #eee !important;
    background: #f9f9f9 !important;
    display: flex !important;
    justify-content: space-between !important;
    align-items: center !important;
}

.modal-title {
    margin: 0 !important;
    font-size: 18px !important;
    font-weight: 600 !important;
    color: #333 !important;
}

.modal-close {
    background: none !important;
    border: none !important;
    font-size: 24px !important;
    color: #666 !important;
    cursor: pointer !important;
    padding: 5px !important;
    line-height: 1 !important;
}

.modal-close:hover {
    color: #333 !important;
}

.modal-body {
    padding: 20px !important;
    max-height: 60vh !important;
    overflow-y: auto !important;
}

.modal-footer {
    padding: 20px !important;
    border-top: 1px solid #eee !important;
    background: #f9f9f9 !important;
    display: flex !important;
    gap: 10px !important;
    justify-content: flex-end !important;
}

#add-task-form {
    width: 100% !important;
    display: block !important;
}

.form-group {
    margin-bottom: 20px !important;
    display: block !important;
    width: 100% !important;
    clear: both !important;
}

.form-group:last-child {
    margin-bottom: 0 !important;
}

.form-label {
    display: block !important;
    width: 100% !important;
    margin-bottom: 8px !important;
    font-weight: 500 !important;
    color: #333 !important;
    font-size: 14px !important;
    line-height: 1.4 !important;
}

.form-input, .form-select {
    display: block !important;
    width: 100% !important;
    padding: 12px !important;
    border: 1px solid #ddd !important;
    border-radius: 6px !important;
    font-size: 14px !important;
    background: white !important;
    box-sizing: border-box !important;
    font-family: inherit !important;
    line-height: 1.4 !important;
    margin: 0 !important;
}

.form-input:focus, .form-select:focus {
    outline: none !important;
    border-color: #007cba !important;
    box-shadow: 0 0 5px rgba(0, 124, 186, 0.3) !important;
}

.form-input::placeholder {
    color: #999 !important;
}

.form-select {
    cursor: pointer !important;
    appearance: none !important;
    -webkit-appearance: none !important;
    -moz-appearance: none !important;
}

textarea.form-input {
    min-height: 80px !important;
    resize: vertical !important;
}

.tasks-content .btn {
    padding: 12px 20px !important;
    border-radius: 6px !important;
    font-weight: 500 !important;
    font-size: 14px !important;
    cursor: pointer !important;
    border: none !important;
    display: inline-flex !important;
    align-items: center !important;
    gap: 8px !important;
    text-decoration: none !important;
}

.tasks-content .btn-primary {
    background: #007cba !important;
    color: white !important;
}

.tasks-content .btn-primary:hover {
    background: #005a8b !important;
}

.tasks-content .btn-secondary {
    background: #f1f1f1 !important;
    color: #333 !important;
    border: 1px solid #ddd !important;
}

.tasks-content .btn-secondary:hover {
    background: #e6e6e6 !important;
}

.tasks-content .btn:disabled {
    opacity: 0.6 !important;
    cursor: not-allowed !important;
}

/* Responsive */
@media (max-width: 1024px) {
    .tasks-main-container {
        flex-direction: column;
        min-height: auto;
    }
    
    .tasks-section {
        height: auto;
        padding: 1rem;
    }
    
    .sidebar-section {
        width: 100%;
        height: 300px; /* Reduced height without sidebar header */
        border-left: none;
        border-top: 1px solid #e5e7eb;
        max-height: 300px;
    }
    
    .chat-messages {
        height: 220px; /* More space for chat on mobile */
        max-height: 220px;
    }
    
    .kanban-board {
        grid-template-columns: 1fr;
        gap: 1rem;
        height: auto;
    }
    
    .kanban-column {
        min-height: 300px;
    }
    
    .modal-overlay {
        padding: 10px;
    }
    
    .modal {
        width: 100%;
        max-width: 95vw;
        margin: 0;
    }
    
    .form-row {
        grid-template-columns: 1fr;
    }
    
    .modal-header,
    .modal-body,
    .modal-footer {
        padding-left: 1.5rem;
        padding-right: 1.5rem;
    }
}

/* Team Chat Panel Styles */
.chat-messages {
    overflow-y: auto;
    padding: 1rem;
    height: 440px; /* Same height as before */
    max-height: 440px;
}

.chat-message {
    margin-bottom: 1rem;
    padding: 0.75rem;
    border-radius: 8px;
    position: relative;
}

.chat-message.own {
    background: #e0f2fe;
    margin-left: 2rem;
    text-align: right;
}

.chat-message.other {
    background: #f8fafc;
    margin-right: 2rem;
}

.chat-message-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
    font-size: 0.75rem;
    color: #6b7280;
}

.chat-message.own .chat-message-header {
    flex-direction: row-reverse;
}

.chat-message-author {
    font-weight: 600;
    color: #374151;
}

.chat-message-time {
    font-size: 0.7rem;
}

.chat-message-content {
    color: #111827;
    line-height: 1.4;
}

.chat-input-container {
    padding: 1rem;
    border-top: 1px solid #e5e7eb;
    background: #f9fafb;
    height: 80px; /* Fixed height for input area */
    flex-shrink: 0;
    display: flex;
    align-items: center;
}

.chat-input-wrapper {
    display: flex;
    gap: 0.5rem;
}

.chat-input {
    flex: 1;
    padding: 0.75rem;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    font-size: 0.9rem;
}

.chat-input:focus {
    outline: none;
    border-color: #007cba;
    box-shadow: 0 0 0 3px rgba(0, 124, 186, 0.1);
}

.chat-send-btn {
    padding: 0.75rem 1rem !important;
    border-radius: 6px !important;
}

.empty-chat {
    text-align: center;
    padding: 3rem 2rem;
    color: #6b7280;
}

.empty-chat i {
    font-size: 3rem;
    color: #d1d5db;
    margin-bottom: 1rem;
    display: block;
}

.empty-chat h4 {
    margin: 0 0 0.5rem 0;
    color: #374151;
}

.empty-chat p {
    margin: 0;
    font-size: 0.9rem;
}

.retention-notice {
    color: #9ca3af !important;
    font-size: 0.8rem !important;
    margin-top: 1rem !important;
    padding-top: 1rem !important;
    border-top: 1px solid #e5e7eb !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    gap: 0.5rem !important;
}
/* Constrain layout to viewport and avoid horizontal overflow */
html, body { max-width: 100%; overflow-x: hidden; }
.tasks-content, .tasks-main-container, .kanban-board { max-width: 100%; box-sizing: border-box; }
.sidebar-section { max-width: 100%; }

/* Always show all columns side-by-side (3 kanban + history) */
.tasks-main-container { min-height: calc(100vh - 150px); }
.tasks-section { overflow: hidden; }
.kanban-board { display: grid; grid-template-columns: repeat(3, minmax(260px, 1fr)); gap: 1rem; height: 100%; align-items: stretch; }
.kanban-column { height: 100%; min-height: 0 !important; min-width: 0; padding: 0; background: transparent; border: none; box-shadow: none; }
.column-content { min-height: 0; overflow-y: auto; background: transparent; padding: 0.25rem; }
/* Remove visible panel backgrounds/borders; use subtle colored headers */
.kanban-column .column-header{ background: transparent; padding: 0 0 0.5rem 0; border: 0; }
.kanban-column[data-status="pending"] .column-title{ background: rgba(59,130,246,.15); color:#93c5fd; border-radius: 10px; padding:.5rem .75rem; }
.kanban-column[data-status="in_progress"] .column-title{ background: rgba(99,102,241,.16); color:#c7d2fe; border-radius: 10px; padding:.5rem .75rem; }
.kanban-column[data-status="completed"] .column-title{ background: rgba(34,197,94,.14); color:#86efac; border-radius: 10px; padding:.5rem .75rem; }
/* Hide placeholder panel borders */
.empty-column{ border-color: transparent; background: transparent; }
.sidebar-section { height: 100%; max-height: none; display: flex; flex-direction: column; width: clamp(260px, 24vw, 340px); }
.sidebar-panel { height: 100%; }
.chat-messages { flex: 1; height: auto; max-height: none; }
.chat-input-container { flex-shrink: 0; }

/* Tighter sidebar on medium screens to prevent stretch */
@media (max-width: 1360px) {
    .sidebar-section { width: clamp(240px, 28vw, 320px); }
}
</style>
<style>
/* Layout for fixed top panels (History + Chat) */
.top-panels { height: calc(100vh - 150px); overflow: hidden; }
.top-panel { display: flex; flex-direction: column; min-height: 260px; height: 100%; background: transparent; border: none; }
.top-panel .sidebar-content { flex: 1; overflow: auto; }
.top-panel .chat-messages { flex: 1; overflow: auto; }
.top-panel .chat-input-container { flex-shrink: 0; }
@media (max-width: 1000px) {
  .top-panels { grid-template-columns: 1fr; height: auto; }
}
</style>
<style>
  /* Prevent stale board flicker by hiding until live refresh completes */
  #tasks-section[data-loading="1"] #kanban-board { visibility: hidden; }
  #tasks-section[data-loading="1"] #tasks-loading-overlay { display: block; }
  #tasks-loading-overlay.hidden { display: none; }
  /* View toggling: default shows global; when .view-user-boards is on the root, show users */
  .tasks-content.view-user-boards .tasks-main-container { display: none !important; }
  .tasks-content.view-user-boards #user-boards-section { display: block !important; }
.tasks-content:not(.view-user-boards) #user-boards-section { display: none !important; }
/* Chat unread badge */
.chat-unread-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin-left: .5rem;
    min-width: 18px;
    height: 18px;
    padding: 0 6px;
    border-radius: 9999px;
    background: #ef4444; /* red */
    color: #fff;
    font-size: .72rem;
    font-weight: 700;
    line-height: 1;
}
</style>

<script>
// Drag and Drop Functions
let draggedElement = null;

function allowDrop(ev) {
    ev.preventDefault();
    ev.currentTarget.classList.add('drag-over');
}

function drag(ev) {
    draggedElement = ev.target;
    ev.target.classList.add('dragging');
    ev.dataTransfer.setData("text", ev.target.dataset.taskId);
}

function drop(ev) {
    ev.preventDefault();
    ev.currentTarget.classList.remove('drag-over');
    
    const taskId = ev.dataTransfer.getData("text");
    const newStatus = ev.currentTarget.closest('.kanban-column').dataset.status;
    const oldStatus = draggedElement?.dataset?.status;
    const targetColumnContent = ev.currentTarget; // store target

    if (draggedElement) {
        draggedElement.classList.remove('dragging');
    }

    if (!draggedElement || newStatus === oldStatus) return;

    // Defer DOM move until server confirms
    updateTaskStatus(taskId, newStatus, function onSuccess() {
        // Move the task card to new column
        targetColumnContent.appendChild(draggedElement);
        draggedElement.dataset.status = newStatus;
        
        // Update task counts
        // Update counts only within the affected target board
        const container = targetColumnContent.closest('#kanban-board') || document;
        updateTaskCounts(container);
        
        // If completed, move to history after delay
        if (newStatus === 'completed') {
            showNotification('Task will be archived in 3 seconds...', 'info');
            setTimeout(() => {
                console.log('Auto-archiving completed task:', taskId);
                moveTaskToHistory(taskId);
            }, 3000);
        }
        // Also refresh from server to reflect any concurrent changes
        setTimeout(() => refreshTasksBoard(true), 200);
    });
}

function updateTaskStatus(taskId, newStatus, onSuccess) {
    console.log('Updating task', taskId, 'to status', newStatus);
    console.log('Nonce available:', warehouse_ajax.nonce);
    
    const formData = new FormData();
    formData.append('action', 'update_task_status');
    formData.append('task_id', taskId);
    formData.append('status', newStatus);
    formData.append('nonce', warehouse_ajax.nonce);
    
    fetch(warehouse_ajax.ajax_url, {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        console.log('Response:', data);
        if (data.success) {
            showNotification('Task status updated successfully', 'success');
            if (typeof onSuccess === 'function') onSuccess();
        } else {
            showNotification(data.data || 'Failed to update task status', 'error');
            console.error('Error updating task:', data);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('Error updating task status', 'error');
    });
}

function moveTaskToHistory(taskId) {
    console.log('Moving task to history:', taskId);
    
    const formData = new FormData();
    formData.append('action', 'move_task_to_history');
    formData.append('task_id', taskId);
    formData.append('nonce', warehouse_ajax.nonce);
    
    fetch(warehouse_ajax.ajax_url, {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        console.log('Move to history response:', data);
        if (data.success) {
            // Remove task from board
            const taskCard = document.querySelector(`[data-task-id="${taskId}"]`);
            if (taskCard) {
                taskCard.style.transition = 'all 0.5s ease';
                taskCard.style.opacity = '0';
                taskCard.style.transform = 'translateX(100%)';
                
                setTimeout(() => {
                    taskCard.remove();
                    const board = document.getElementById('kanban-board');
                    updateTaskCounts(board);
                    showNotification('Task moved to history', 'success');
                    
                    // Always refresh history panel (even if hidden)
                    refreshHistoryPanel();
                }, 500);
            }
        } else {
            console.error('Failed to move task to history:', data);
            showNotification(data.data || 'Failed to move task to history', 'error');
        }
    })
    .catch(error => {
        console.error('Error moving task to history:', error);
        showNotification('Error moving task to history', 'error');
    });
}

function updateTaskCounts(container) {
    const scope = container || document;
    scope.querySelectorAll('.kanban-column').forEach(column => {
        const taskCards = column.querySelectorAll('.task-card');
        const count = taskCards.length;
        const countElement = column.querySelector('.task-count');
        const emptyState = column.querySelector('.empty-column');
        
        // Update count
        if (countElement) {
            countElement.textContent = count;
        }
        
        // Show/hide empty state
        if (emptyState) {
            emptyState.style.display = count > 0 ? 'none' : 'flex';
        }
    });
}

function taskCardHtml(t) {
    const created = t.created_at ? new Date(t.created_at) : new Date();
    const createdStr = created.toLocaleString(undefined, { month: 'short', day: 'numeric' });
    const due = t.due_date ? new Date(t.due_date) : null;
    const dueStr = due ? due.toLocaleString(undefined, { month: 'short', day: 'numeric' }) : '';
    const overdue = due ? (due.getTime() < Date.now()) : false;
    const priority = (t.priority || 'medium').toLowerCase();
    const safeTitle = t.title ? String(t.title).replace(/</g, '&lt;') : 'Task';
    return `
    <div class="task-card" draggable="true" ondragstart="drag(event)" data-task-id="${t.id}" data-status="${t.status}">
      <div class="task-priority priority-${priority}"></div>
      <div class="task-content">
        <div class="task-header">
          <h4>${safeTitle}</h4>
          <div class="task-actions">
            <button onclick="editTask(${t.id})" class="btn-icon" title="Edit"><i class="fas fa-edit"></i></button>
            <button onclick="deleteTask(${t.id})" class="btn-icon" title="Delete"><i class="fas fa-trash"></i></button>
          </div>
        </div>
        <div class="task-meta">
          <span class="assignee"><i class="fas fa-user"></i> ${t.assigned_to_name || ''}</span>
          ${dueStr ? `<span class="due-date ${overdue ? 'overdue' : ''}"><i class="fas fa-calendar"></i> ${dueStr} ${overdue ? '<i class=\"fas fa-exclamation-triangle\" title=\"Overdue\"></i>' : ''}</span>` : ''}
        </div>
        <div class="task-footer">
          <span class="task-id">#${t.id}</span>
          <span class="task-created">${createdStr}</span>
        </div>
      </div>
    </div>`;
}

function refreshTasksBoard(silent = false) {
    const btn = document.getElementById('refresh-board-btn');
    if (btn) { btn.disabled = true; btn.innerHTML = '<i class="fas fa-sync fa-spin"></i> Refreshing'; }

    const fd = new FormData();
    fd.append('action', 'get_tasks');
    fd.append('nonce', warehouse_ajax.nonce);

    return fetch(warehouse_ajax.ajax_url, { method: 'POST', body: fd })
      .then(r => r.json())
      .then(data => {
        if (!data.success) { throw new Error(data.data || 'Failed to load tasks'); }
        const buckets = data.data || {};
        const board = document.getElementById('kanban-board');
        const columns = board ? {
          pending: board.querySelector('.kanban-column[data-status="pending"] .column-content'),
          in_progress: board.querySelector('.kanban-column[data-status="in_progress"] .column-content'),
          completed: board.querySelector('.kanban-column[data-status="completed"] .column-content'),
        } : {};

        // Clear existing cards but keep the empty state element
        Object.keys(columns).forEach(k => {
          const el = columns[k];
          if (!el) return;
          [...el.querySelectorAll('.task-card')].forEach(node => node.remove());
        });

        // Render tasks
        ['pending','in_progress','completed'].forEach(status => {
          const el = columns[status];
          const list = Array.isArray(buckets[status]) ? buckets[status] : [];
          list.forEach(t => {
            t.status = status; // ensure data-status matches column for DnD
            if (el) { el.insertAdjacentHTML('beforeend', taskCardHtml(t)); }
          });
        });

        updateTaskCounts(board);
        if (!silent) { showNotification('Board refreshed', 'success'); }
        // Update last refreshed label
        const ts = new Date();
        const label = document.getElementById('board-refreshed-at');
        if (label) {
          label.textContent = `Updated ${ts.toLocaleTimeString([], {hour:'2-digit', minute:'2-digit'})}`;
        }
      })
      .catch(err => {
        console.error('Refresh failed:', err);
        showNotification('Failed to refresh board', 'error');
      })
      .finally(() => {
        if (btn) { btn.disabled = false; btn.innerHTML = '<i class="fas fa-sync"></i> Refresh'; }
      });
}

// Build per-user boards (admin only)
function buildUserBoards() {
    const container = document.getElementById('user-boards-container');
    if (!container) return; // non-admin or section hidden

    // Fetch distinct assignees
    const fd = new FormData();
    fd.append('action', 'get_task_assignees');
    fd.append('nonce', warehouse_ajax.nonce);

    container.innerHTML = '<div style="text-align:center;padding:1rem;opacity:.8;"><i class="fas fa-spinner fa-spin"></i> Loading users…</div>';

    fetch(warehouse_ajax.ajax_url, { method: 'POST', body: fd })
      .then(r => r.json())
      .then(data => {
        if (!data.success) throw new Error(data.data || 'Failed to load assignees');
        const users = data.data || [];
        if (!users.length) { container.innerHTML = '<div style="opacity:.8;">No users with tasks yet.</div>'; return; }

        // Render a collapsible board for each user
        container.innerHTML = '';
        users.forEach(u => {
          const boardId = `user-board-${u.id}`;
          const html = `
            <div class="user-board" data-user-id="${u.id}" style="border:1px solid rgba(148,163,184,.2);border-radius:10px;">
              <div class="user-board-header" style="display:flex;align-items:center;justify-content:space-between;padding:.5rem 1rem;cursor:pointer;" onclick="toggleUserBoard('${boardId}')">
                <div style="display:flex;align-items:center;gap:.5rem;">
                    <i class="fas fa-user"></i>
                    <strong>${u.name}</strong>
                </div>
                <div class="user-board-counts" id="${boardId}-counts" style="opacity:.8;font-size:.9rem;"></div>
              </div>
              <div class="user-board-body" id="${boardId}" style="padding: .5rem 1rem 1rem 1rem;">
                <div class="kanban-board" style="display:grid;grid-template-columns:repeat(3, minmax(260px, 1fr));gap:1rem;">
                  <div class="kanban-column" data-status="pending">
                    <div class="column-header"><div class="column-title"><i class="fas fa-clock"></i> <span>Pending</span> <span class="task-count">0</span></div></div>
                    <div class="column-content" ondrop="drop(event)" ondragover="allowDrop(event)"></div>
                  </div>
                  <div class="kanban-column" data-status="in_progress">
                    <div class="column-header"><div class="column-title"><i class="fas fa-spinner"></i> <span>In Progress</span> <span class="task-count">0</span></div></div>
                    <div class="column-content" ondrop="drop(event)" ondragover="allowDrop(event)"></div>
                  </div>
                  <div class="kanban-column" data-status="completed">
                    <div class="column-header"><div class="column-title"><i class="fas fa-check-circle"></i> <span>Completed</span> <span class="task-count">0</span></div></div>
                    <div class="column-content" ondrop="drop(event)" ondragover="allowDrop(event)"></div>
                  </div>
                </div>
              </div>
            </div>`;
          container.insertAdjacentHTML('beforeend', html);
          refreshUserBoard(u.id);
        });
      })
      .catch(err => {
        console.error('Assignees load failed:', err);
        container.innerHTML = '<div style="color:#ef4444;">Failed to load user boards</div>';
      });
}

function toggleUserBoard(boardId) {
    const body = document.getElementById(boardId);
    if (!body) return;
    const isHidden = body.style.display === 'none';
    body.style.display = isHidden ? '' : 'none';
}

function refreshUserBoard(userId) {
    const board = document.querySelector(`.user-board[data-user-id="${userId}"]`);
    if (!board) return;
    const countsEl = document.getElementById(`user-board-${userId}-counts`);
    const fd = new FormData();
    fd.append('action', 'get_tasks');
    fd.append('nonce', warehouse_ajax.nonce);
    fd.append('assigned_to', String(userId));

    fetch(warehouse_ajax.ajax_url, { method: 'POST', body: fd })
      .then(r => r.json())
      .then(data => {
        if (!data.success) throw new Error(data.data || 'Failed to load tasks');
        const buckets = data.data || {};
        const columns = {
          pending: board.querySelector('.kanban-column[data-status="pending"] .column-content'),
          in_progress: board.querySelector('.kanban-column[data-status="in_progress"] .column-content'),
          completed: board.querySelector('.kanban-column[data-status="completed"] .column-content'),
        };

        Object.keys(columns).forEach(k => {
          const el = columns[k];
          if (!el) return;
          [...el.querySelectorAll('.task-card')].forEach(node => node.remove());
        });

        ['pending','in_progress','completed'].forEach(status => {
          const el = columns[status];
          const list = Array.isArray(buckets[status]) ? buckets[status] : [];
          list.forEach(t => { t.status = status; el.insertAdjacentHTML('beforeend', taskCardHtml(t)); });
        });

        // Update counts header
        const p = (buckets.pending || []).length;
        const ip = (buckets.in_progress || []).length;
        const c = (buckets.completed || []).length;
        if (countsEl) countsEl.textContent = `Pending ${p} • In Progress ${ip} • Completed ${c}`;
      })
      .catch(err => console.error('User board refresh failed:', err));
}

function showHistoryPanel() {
    ensureTopPanelsVisible();
    refreshHistoryPanel();
    const el = document.getElementById('history-panel');
    if (el && el.scrollIntoView) el.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}

function showChatPanel() {
    ensureTopPanelsVisible();
    // Set flag to mark chat as read after loading
    window.chatMarkReadOnOpen = true;
    loadChatMessages();
    const el = document.getElementById('team-chat-panel');
    if (el && el.scrollIntoView) el.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}

// Keep backward compatibility for header buttons
function toggleHistoryPanel() {
    showHistoryPanel();
}

function toggleTeamChatPanel() {
    showChatPanel();
}

// Chat unread helpers
function getChatLastRead() {
    const v = localStorage.getItem('wh_chat_last_read_ts');
    const n = v ? parseInt(v, 10) : 0;
    return Number.isFinite(n) ? n : 0;
}

function setChatLastRead(ts) {
    if (!ts || !Number.isFinite(ts)) return;
    localStorage.setItem('wh_chat_last_read_ts', String(ts));
    updateChatUnreadIndicator(0);
}

function updateChatUnreadIndicator(count) {
    const badge = document.getElementById('chat-unread-badge');
    if (!badge) return;
    if (count && count > 0) {
        badge.style.display = 'inline-flex';
        badge.textContent = count > 9 ? '9+' : String(count);
    } else {
        badge.style.display = 'none';
    }
}

function latestMessageTs(messages) {
    let max = 0;
    for (const m of (messages || [])) {
        const ts = m && m.created_at ? (new Date(m.created_at)).getTime() : 0;
        if (ts && ts > max) max = ts;
    }
    return max;
}

function countUnread(messages) {
    const lastRead = getChatLastRead();
    let c = 0;
    for (const m of (messages || [])) {
        const ts = m && m.created_at ? (new Date(m.created_at)).getTime() : 0;
        if (ts && ts > lastRead) c++;
    }
    return c;
}

function loadChatMessages() {
    const chatMessages = document.getElementById('chat-messages');
    if (!chatMessages) return;
    
    chatMessages.innerHTML = '<div style="text-align: center; padding: 2rem;"><i class="fas fa-spinner fa-spin"></i> Loading...</div>';
    
    const formData = new FormData();
    formData.append('action', 'get_chat_messages');
    formData.append('nonce', warehouse_ajax.nonce);
    
    fetch(warehouse_ajax.ajax_url, {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success && data.data) {
            const messages = data.data;
            displayChatMessages(messages);
            // Update unread indicator and possibly mark read if opened
            try {
                updateChatUnreadIndicator(countUnread(messages));
                if (window.chatMarkReadOnOpen) {
                    const ts = latestMessageTs(messages);
                    if (ts) setChatLastRead(ts);
                    window.chatMarkReadOnOpen = false;
                }
            } catch(e) { /* noop */ }
        } else {
            chatMessages.innerHTML = `
                <div class="empty-chat">
                    <i class="fas fa-comments"></i>
                    <h4>No messages yet</h4>
                    <p>Start a conversation with your team!</p>
                    <p class="retention-notice"><i class="fas fa-clock"></i> Chat messages are kept for 6 months</p>
                </div>
            `;
        }
    })
    .catch(error => {
        console.error('Error loading chat messages:', error);
        chatMessages.innerHTML = `
            <div class="empty-chat">
                <i class="fas fa-exclamation-triangle"></i>
                <h4>Failed to load messages</h4>
                <p>Please try again later.</p>
            </div>
        `;
    });
}

function displayChatMessages(messages) {
    const chatMessages = document.getElementById('chat-messages');
    const currentUserId = warehouse_ajax.current_user_id;
    
    if (!messages || messages.length === 0) {
        chatMessages.innerHTML = `
            <div class="empty-chat">
                <i class="fas fa-comments"></i>
                <h4>No messages yet</h4>
                <p>Start a conversation with your team!</p>
                <p class="retention-notice"><i class="fas fa-clock"></i> Chat messages are kept for 6 months</p>
            </div>
        `;
        return;
    }
    
    let messagesHtml = '';
    messages.forEach(message => {
        const isOwn = message.user_id == currentUserId;
        const messageClass = isOwn ? 'own' : 'other';
        
        messagesHtml += `
            <div class="chat-message ${messageClass}">
                <div class="chat-message-header">
                    <span class="chat-message-author">${message.user_name || 'Unknown User'}</span>
                    <span class="chat-message-time">${formatMessageTime(message.created_at)}</span>
                </div>
                <div class="chat-message-content">${escapeHtml(message.message)}</div>
            </div>
        `;
    });
    
    chatMessages.innerHTML = messagesHtml;
    
    // Scroll to bottom
    chatMessages.scrollTop = chatMessages.scrollHeight;
}

// Background polling to update chat unread indicator without opening panel
function checkChatUnread() {
    try {
        const fd = new FormData();
        fd.append('action', 'get_chat_messages');
        fd.append('nonce', warehouse_ajax.nonce);
        fetch(warehouse_ajax.ajax_url, { method: 'POST', body: fd })
          .then(r => r.json())
          .then(data => {
              if (!data || !data.success) return;
              const messages = data.data || [];
              updateChatUnreadIndicator(countUnread(messages));
          })
          .catch(() => {});
    } catch (e) { /* noop */ }
}

function sendChatMessage() {
    const messageInput = document.getElementById('chat-message-input');
    const message = messageInput.value.trim();
    
    if (!message) return;
    
    const formData = new FormData();
    formData.append('action', 'send_chat_message');
    formData.append('message', message);
    formData.append('nonce', warehouse_ajax.nonce);
    
    // Disable input while sending
    messageInput.disabled = true;
    
    fetch(warehouse_ajax.ajax_url, {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            messageInput.value = '';
            loadChatMessages(); // Reload messages
            try { setChatLastRead(Date.now()); } catch(e){}
        } else {
            showNotification('Failed to send message', 'error');
        }
    })
    .catch(error => {
        console.error('Error sending message:', error);
        showNotification('Error sending message', 'error');
    })
    .finally(() => {
        messageInput.disabled = false;
        messageInput.focus();
    });
}

function formatMessageTime(timestamp) {
    try {
        const date = new Date(timestamp);
        const now = new Date();
        const diffMs = now - date;
        const diffMins = Math.floor(diffMs / 60000);
        const diffHours = Math.floor(diffMs / 3600000);
        const diffDays = Math.floor(diffMs / 86400000);
        
        if (diffMins < 1) return 'Just now';
        if (diffMins < 60) return `${diffMins}m ago`;
        if (diffHours < 24) return `${diffHours}h ago`;
        if (diffDays < 7) return `${diffDays}d ago`;
        
        return date.toLocaleDateString();
    } catch (e) {
        return timestamp;
    }
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function refreshHistoryPanel() {
    const formData = new FormData();
    formData.append('action', 'get_task_history');
    formData.append('nonce', warehouse_ajax.nonce);
    
    // Find the history content within the history panel
    const historyPanel = document.getElementById('history-panel');
    const historyContent = historyPanel ? historyPanel.querySelector('.sidebar-content') : null;
    
    if (historyContent) {
        historyContent.innerHTML = '<div style="text-align: center; padding: 2rem;"><i class="fas fa-spinner fa-spin"></i> Loading...</div>';
    }
    
    fetch(warehouse_ajax.ajax_url, {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        console.log('History response:', data);
        
        if (data.success && historyContent) {
            let historyHtml = '';
            
            if (data.data && data.data.length > 0) {
                data.data.forEach(item => {
                    try {
                        // Handle date formatting safely
                        let completedDateStr = 'Unknown date';
                        let daysDiff = 0;
                        
                        if (item.completed_at) {
                            const completedDate = new Date(item.completed_at);
                            if (!isNaN(completedDate.getTime())) {
                                completedDateStr = completedDate.toLocaleDateString('en-US', {
                                    year: 'numeric',
                                    month: 'short',
                                    day: 'numeric',
                                    hour: '2-digit',
                                    minute: '2-digit'
                                });
                                
                                if (item.created_at) {
                                    const createdDate = new Date(item.created_at);
                                    if (!isNaN(createdDate.getTime())) {
                                        const timeDiff = Math.abs(completedDate - createdDate);
                                        daysDiff = Math.ceil(timeDiff / (1000 * 60 * 60 * 24));
                                    }
                                }
                            }
                        }
                        
                        historyHtml += `
                            <div class="history-item">
                                <div class="history-date">
                                    <i class="fas fa-calendar-check"></i>
                                    ${completedDateStr}
                                </div>
                                <div class="history-task">
                                    <h4>${item.title || 'Unknown Task'}</h4>
                                    <p>${item.description || ''}</p>
                                    <div class="history-meta">
                                        <span class="priority priority-${item.priority || 'medium'}">
                                            ${(item.priority || 'medium').toUpperCase()}
                                        </span>
                                        <span class="assignee">
                                            <i class="fas fa-user"></i>
                                            ${item.assigned_to_name || 'System'}
                                        </span>
                                        <span class="duration">
                                            <i class="fas fa-clock"></i>
                                            ${daysDiff > 0 ? daysDiff + ' days' : 'Same day'}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        `;
                    } catch (itemError) {
                        console.error('Error processing history item:', itemError, item);
                    }
                });
            } else {
                historyHtml = `
                    <div class="empty-history" style="text-align: center; padding: 2rem; color: #6b7280;">
                        <i class="fas fa-archive" style="font-size: 3rem; color: #d1d5db; margin-bottom: 1rem;"></i>
                        <h4>No completed tasks yet</h4>
                        <p>Completed tasks will appear here with timestamps.</p>
                        <p class="retention-notice"><i class="fas fa-clock"></i> Task history is kept for 6 months</p>
                    </div>
                `;
            }
            
            historyContent.innerHTML = historyHtml;
        } else {
            console.error('History request failed:', data);
            if (historyContent) {
                historyContent.innerHTML = `
                    <div style="text-align: center; padding: 2rem; color: #ef4444;">
                        <i class="fas fa-exclamation-triangle"></i><br>
                        Failed to load history: ${data.data || 'Unknown error'}
                    </div>
                `;
            }
        }
    })
    .catch(error => {
        console.error('Error refreshing history:', error);
        if (historyContent) {
            historyContent.innerHTML = `
                <div style="text-align: center; padding: 2rem; color: #ef4444;">
                    <i class="fas fa-exclamation-triangle"></i><br>
                    Failed to load history
                </div>
            `;
        }
    });
}

window.submitAddTask = function() {
    console.log('submitAddTask called');
    const form = document.getElementById('add-task-form');
    if (!form) {
        console.error('Form not found');
        return;
    }
    
    const title = form.querySelector('[name="title"]').value.trim();
    
    if (!title) {
        showNotification('Please enter a task title', 'error');
        return;
    }
    
    const formData = new FormData(form);
    formData.append('action', 'add_task');
    formData.append('nonce', warehouse_ajax.nonce);
    
    // Disable button to prevent double submission
    const submitBtn = document.querySelector('#add-task-modal button[onclick*="submitAddTask"]');
    if (submitBtn) {
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = 'Adding...';
        submitBtn.disabled = true;
        
        fetch(warehouse_ajax.ajax_url, {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification('Task added successfully', 'success');
                closeModal('add-task-modal');
                // Inject new task card into Pending column without reload
                try {
                    const t = data.task || (data.data && data.data.task) || null;
                    if (t) {
                        const board = document.getElementById('kanban-board');
                        const col = board ? board.querySelector('.kanban-column[data-status="pending"] .column-content') : null;
                        if (col) {
                            const el = document.createElement('div');
                            el.className = 'task-card';
                            el.setAttribute('draggable','true');
                            el.setAttribute('data-task-id', t.id);
                            el.setAttribute('data-status','pending');
                            el.ondragstart = function(e){ drag(e); };
                            const created = t.created_at ? new Date(t.created_at) : new Date();
                            const createdStr = created.toLocaleString(undefined,{month:'short', day:'numeric'});
                            const due = t.due_date ? new Date(t.due_date) : null;
                            const dueStr = due ? due.toLocaleString(undefined,{month:'short', day:'numeric'}) : '';
                            const overdue = due ? (due.getTime() < Date.now()) : false;
                            el.innerHTML = `
                                <div class="task-priority priority-${t.priority || 'medium'}"></div>
                                <div class="task-content">
                                  <div class="task-header">
                                    <h4>${t.title ? String(t.title).replace(/</g,'&lt;') : 'New Task'}</h4>
                                    <div class="task-actions">
                                      <button onclick="editTask(${t.id})" class="btn-icon" title="Edit"><i class="fas fa-edit"></i></button>
                                      <button onclick="deleteTask(${t.id})" class="btn-icon" title="Delete"><i class="fas fa-trash"></i></button>
                                    </div>
                                  </div>
                                  <div class="task-meta">
                                    <span class="assignee"><i class="fas fa-user"></i> ${t.assigned_to_name || ''}</span>
                                    ${dueStr ? `<span class="due-date ${overdue ? 'overdue' : ''}"><i class="fas fa-calendar"></i> ${dueStr} ${overdue ? '<i class=\"fas fa-exclamation-triangle\" title=\"Overdue\"></i>' : ''}</span>` : ''}
                                  </div>
                                  <div class="task-footer">
                                    <span class="task-id">#${t.id}</span>
                                    <span class="task-created">${createdStr}</span>
                                  </div>
                                </div>`;
                            if (col) col.prepend(el);
                            const board = document.getElementById('kanban-board');
                            updateTaskCounts(board);
                        }
                    }
                } catch(e) { console.warn('Could not inject new task:', e); }
                // Ensure board reflects DB state
                setTimeout(refreshTasksBoard, 200);
            } else {
                showNotification(data.data?.message || 'Failed to add task', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Error adding task', 'error');
        })
        .finally(() => {
            // Re-enable button
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
        });
    }
}

function editTask(taskId) {
    showNotification('Edit task functionality coming soon', 'info');
}

function deleteTask(taskId) {
    if (!confirm('Are you sure you want to delete this task?')) {
        return;
    }
    
    const formData = new FormData();
    formData.append('action', 'delete_task');
    formData.append('task_id', taskId);
    formData.append('nonce', warehouse_ajax.nonce);
    
    fetch(warehouse_ajax.ajax_url, {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Remove task from board
            const taskCard = document.querySelector(`[data-task-id="${taskId}"]`);
            if (taskCard) {
                taskCard.style.transition = 'all 0.3s ease';
                taskCard.style.opacity = '0';
                taskCard.style.transform = 'scale(0.8)';
                
                setTimeout(() => {
                    taskCard.remove();
                    const board = document.getElementById('kanban-board');
                    updateTaskCounts(board);
                    showNotification('Task deleted successfully', 'success');
                    // Keep list in sync with server
                    setTimeout(refreshTasksBoard, 200);
                }, 300);
            }
        } else {
            showNotification('Failed to delete task', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('Error deleting task', 'error');
    });
}

function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
        <span>${message}</span>
        <button onclick="this.parentElement.remove()" style="background:none;border:none;color:inherit;font-size:1.2rem;cursor:pointer;margin-left:1rem;">&times;</button>
    `;
    
    // Add notification styles
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${type === 'success' ? '#10b981' : type === 'error' ? '#ef4444' : '#3b82f6'};
        color: white;
        padding: 1rem 1.5rem;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        z-index: 1000;
        display: flex;
        align-items: center;
        gap: 1rem;
        animation: slideInRight 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    // Auto remove after 3 seconds
    setTimeout(() => {
        if (notification.parentElement) {
            notification.remove();
        }
    }, 3000);
}

// Modal functions - Make them explicitly global
window.openModal = function(modalId) {
    console.log('Opening modal:', modalId);
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.remove('hidden');
        console.log('Modal opened successfully');
    } else {
        console.error('Modal not found:', modalId);
    }
}

window.closeModal = function(modalId) {
    console.log('closeModal function called with modalId:', modalId);
    const modal = document.getElementById(modalId);
    console.log('Modal element found:', modal);
    
    if (modal) {
        console.log('Current modal classes before:', modal.className);
        modal.classList.add('hidden');
        console.log('Current modal classes after:', modal.className);
        
        // Also try setting display none as backup
        modal.style.display = 'none';
        
        if (modalId === 'add-task-modal') {
            const form = document.getElementById('add-task-form');
            if (form) {
                form.reset();
                console.log('Form reset');
            }
        }
        console.log('Modal closed successfully');
    } else {
        console.error('Modal not found:', modalId);
    }
}

// Close modal when clicking outside
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('task-modal-overlay') && !e.target.classList.contains('hidden')) {
        e.target.classList.add('hidden');
    }
});

// Initialize drag and drop event listeners
document.addEventListener('DOMContentLoaded', function() {
    // Ensure the main tasks container is visible (fix for hidden board)
    try {
        const mainContainer = document.querySelector('.tasks-main-container');
        if (mainContainer && (mainContainer.style.display === 'none' || getComputedStyle(mainContainer).display === 'none')) {
            mainContainer.style.display = '';
        }
    } catch (e) { /* noop */ }
    // Dynamically fit tasks layout to viewport so page doesn't require scrolling
    function resizeTasksLayout(){
        try {
            const container = document.querySelector('.tasks-main-container');
            if (!container) return;
            const rect = container.getBoundingClientRect();
            const available = window.innerHeight - rect.top - 16; // small bottom gap
            if (available > 240) {
                container.style.height = available + 'px';
            }
        } catch (e) { /* noop */ }
    }
    resizeTasksLayout();
    window.addEventListener('resize', resizeTasksLayout);

    document.querySelectorAll('.column-content').forEach(column => {
        column.addEventListener('dragleave', function(e) {
            if (!this.contains(e.relatedTarget)) {
                this.classList.remove('drag-over');
            }
        });
    });
    
    // Add backup event listener for Add Task button
    const addTaskBtn = document.querySelector('button[onclick*="add-task-modal"]');
    if (addTaskBtn) {
        addTaskBtn.addEventListener('click', function(e) {
            e.preventDefault();
            console.log('Add Task button clicked via event listener');
            openModal('add-task-modal');
        });
    }
    
    // Add event listeners for modal buttons
    const xButton = document.getElementById('modal-close-x');
    if (xButton) {
        xButton.addEventListener('click', function(e) {
            e.preventDefault();
            console.log('X button clicked');
            // Close modal directly
            const modal = document.getElementById('add-task-modal');
            if (modal) {
                modal.classList.add('hidden');
                modal.style.display = 'none';
                const form = document.getElementById('add-task-form');
                if (form) form.reset();
                console.log('Modal closed via X button');
            }
        });
    }
    
    const cancelButton = document.getElementById('modal-cancel-btn');
    if (cancelButton) {
        cancelButton.addEventListener('click', function(e) {
            e.preventDefault();
            console.log('Cancel button clicked');
            // Close modal directly
            const modal = document.getElementById('add-task-modal');
            if (modal) {
                modal.classList.add('hidden');
                modal.style.display = 'none';
                const form = document.getElementById('add-task-form');
                if (form) form.reset();
                console.log('Modal closed via Cancel button');
            }
        });
    }
    
    const submitButton = document.getElementById('modal-submit-btn');
    if (submitButton) {
        submitButton.addEventListener('click', function(e) {
            e.preventDefault();
            console.log('Submit button clicked');
            // Call submit function directly
            const form = document.getElementById('add-task-form');
            if (!form) {
                console.error('Form not found');
                return;
            }
            
            const title = form.querySelector('[name="title"]').value.trim();
            
            if (!title) {
                alert('Please enter a task title');
                return;
            }
            
            const formData = new FormData(form);
            formData.append('action', 'add_task');
            formData.append('nonce', warehouse_ajax.nonce);
            
            // Disable button
            submitButton.innerHTML = 'Adding...';
            submitButton.disabled = true;
            
            fetch(warehouse_ajax.ajax_url, {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Task added successfully');
                    // Close modal
                    const modal = document.getElementById('add-task-modal');
                    if (modal) {
                        modal.classList.add('hidden');
                        modal.style.display = 'none';
                        form.reset();
                    }
                    // Inject into Pending column without reload
                    try {
                        const t = data.task || (data.data && data.data.task) || null;
                        if (t) {
                            const board = document.getElementById('kanban-board');
                            const col = board ? board.querySelector('.kanban-column[data-status="pending"] .column-content') : null;
                            if (col) {
                                const el = document.createElement('div');
                                el.className = 'task-card';
                                el.setAttribute('draggable','true');
                                el.setAttribute('data-task-id', t.id);
                                el.setAttribute('data-status','pending');
                                el.ondragstart = function(e){ drag(e); };
                                const created = t.created_at ? new Date(t.created_at) : new Date();
                                const createdStr = created.toLocaleString(undefined,{month:'short', day:'numeric'});
                                const due = t.due_date ? new Date(t.due_date) : null;
                                const dueStr = due ? due.toLocaleString(undefined,{month:'short', day:'numeric'}) : '';
                                const overdue = due ? (due.getTime() < Date.now()) : false;
                                el.innerHTML = `
                                    <div class="task-priority priority-${t.priority || 'medium'}"></div>
                                    <div class="task-content">
                                      <div class="task-header">
                                        <h4>${t.title ? String(t.title).replace(/</g,'&lt;') : 'New Task'}</h4>
                                        <div class="task-actions">
                                          <button onclick="editTask(${t.id})" class="btn-icon" title="Edit"><i class="fas fa-edit"></i></button>
                                          <button onclick="deleteTask(${t.id})" class="btn-icon" title="Delete"><i class="fas fa-trash"></i></button>
                                        </div>
                                      </div>
                                      <div class="task-meta">
                                        <span class="assignee"><i class="fas fa-user"></i> ${t.assigned_to_name || ''}</span>
                                        ${dueStr ? `<span class="due-date ${overdue ? 'overdue' : ''}"><i class="fas fa-calendar"></i> ${dueStr} ${overdue ? '<i class=\"fas fa-exclamation-triangle\" title=\"Overdue\"></i>' : ''}</span>` : ''}
                                      </div>
                                      <div class="task-footer">
                                        <span class="task-id">#${t.id}</span>
                                        <span class="task-created">${createdStr}</span>
                                      </div>
                                    </div>`;
                                if (col) col.prepend(el);
                                const board = document.getElementById('kanban-board');
                                updateTaskCounts(board);
                            }
                        }
                    } catch(e) { console.warn('Could not inject new task:', e); }
                } else {
                    alert('Failed to add task: ' + (data.data?.message || 'Unknown error'));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error adding task');
            })
            .finally(() => {
                // Re-enable button
                submitButton.innerHTML = 'Add Task';
                submitButton.disabled = false;
            });
        });
    }

    // Initial count update scoped to global board
    try { updateTaskCounts(document.getElementById('kanban-board')); } catch(e){}
    
    // Top panels: load both history and chat
    try { refreshHistoryPanel(); } catch(e) { console.warn('History refresh skipped:', e); }
    try { loadChatMessages(); } catch(e) { console.warn('Chat load skipped:', e); }
    // Start background polling for chat unread updates
    try {
        if (!window.__chat_poll_started) {
            window.__chat_poll_started = true;
            setTimeout(checkChatUnread, 1000);
            setInterval(checkChatUnread, 15000);
        }
    } catch (e) { /* noop */ }

    // Pull latest tasks from server to avoid any cached HTML; hide board while loading
    const section = document.getElementById('tasks-section');
    const overlay = document.getElementById('tasks-loading-overlay');
    if (section && overlay) {
        section.setAttribute('data-loading', '1');
        overlay.classList.remove('hidden');
        refreshTasksBoard(true).finally(() => {
            section.setAttribute('data-loading', '0');
            overlay.classList.add('hidden');
        });
    } else {
        refreshTasksBoard(true);
    }
    
    // Build per-user boards (visible to all roles)
    try { buildUserBoards(); } catch (e) { console.warn('User boards skipped:', e); }

    // Add Enter key listener for chat input
    const chatInput = document.getElementById('chat-message-input');
    if (chatInput) {
        chatInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                sendChatMessage();
            }
        });
    }
});

function scrollToSection(id) {
    try {
        const el = document.getElementById(id);
        if (el && el.scrollIntoView) {
            el.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    } catch(e) { console.warn('Scroll failed:', e); }
}

// Explicit view toggles for Global vs User boards
function showGlobalBoard() {
    try {
        const root = document.querySelector('.tasks-content');
        if (root) root.classList.remove('view-user-boards');
        // Also toggle inline styles to be extra explicit
        const tasksSection = document.getElementById('tasks-section');
        const usersSection = document.getElementById('user-boards-section');
        if (tasksSection) tasksSection.style.display = '';
        if (usersSection) usersSection.style.display = 'none';
        // Refresh global board to ensure up-to-date view
        try { refreshTasksBoard(true); } catch(e){}
        scrollToSection('kanban-board');
    } catch(e) { console.warn('showGlobalBoard failed', e); }
}

function showUserBoards() {
    try {
        const root = document.querySelector('.tasks-content');
        if (root) root.classList.add('view-user-boards');
        // Also toggle inline styles to be extra explicit
        const tasksSection = document.getElementById('tasks-section');
        const usersSection = document.getElementById('user-boards-section');
        if (tasksSection) tasksSection.style.display = 'none';
        if (usersSection) usersSection.style.display = '';
        // Build or refresh user boards when switching to this view
        try { buildUserBoards(); } catch(e){}
        scrollToSection('user-boards-section');
    } catch(e) { console.warn('showUserBoards failed', e); }
}

function toggleTopPanels() {
    const panels = document.getElementById('top-panels');
    if (!panels) return;
    const isHidden = panels.style.display === 'none' || panels.classList.contains('hidden');
    if (isHidden) {
        panels.style.display = 'grid';
        panels.classList.remove('hidden');
        // Load content on open
        try { refreshHistoryPanel(); } catch(e){}
        try { loadChatMessages(); } catch(e){}
    } else {
        panels.style.display = 'none';
        panels.classList.add('hidden');
    }
}

function ensureTopPanelsVisible() {
    const panels = document.getElementById('top-panels');
    if (panels && (panels.style.display === 'none' || panels.classList.contains('hidden'))) {
        panels.style.display = 'grid';
        panels.classList.remove('hidden');
    }
}

// Add CSS for notification animation
const style = document.createElement('style');
style.textContent = `
    @keyframes slideInRight {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    
    /* Modal Styles */
    .task-modal-overlay {
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100% !important;
        height: 100% !important;
        background: rgba(0,0,0,0.5) !important;
        z-index: 999999 !important;
        display: block !important;
    }

    .task-modal-overlay.hidden {
        display: none !important;
        visibility: hidden !important;
        opacity: 0 !important;
    }

    .task-modal {
        position: absolute !important;
        top: 50% !important;
        left: 50% !important;
        transform: translate(-50%, -50%) !important;
        background: white !important;
        border-radius: 8px !important;
        width: 500px !important;
        max-width: 90% !important;
        box-shadow: 0 4px 20px rgba(0,0,0,0.3) !important;
    }

    .task-modal-header {
        padding: 20px !important;
        border-bottom: 1px solid #eee !important;
        display: flex !important;
        justify-content: space-between !important;
        align-items: center !important;
    }

    .task-modal-header h3 {
        margin: 0 !important;
        font-size: 18px !important;
        color: #333 !important;
    }

    .task-modal-body {
        padding: 20px !important;
        max-height: 60vh !important;
        overflow-y: auto !important;
    }

    .task-modal-footer {
        padding: 20px !important;
        border-top: 1px solid #eee !important;
        text-align: right !important;
    }
`;
document.head.appendChild(style);
</script> 
