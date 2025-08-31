<?php
// Require authentication for the warehouse app
if (!is_user_logged_in()) {
    get_header();
    $redirect = home_url(add_query_arg(null, null));
    ?>
    <style>
      .auth-wrap{min-height:calc(100vh - 120px);display:flex;align-items:center;justify-content:center;padding:24px;background:linear-gradient(135deg,#eef2ff 0%,#f8fafc 100%);}/* subtle bg */
      .auth-card{width:100%;max-width:460px;background:#fff;border:1px solid #e5e7eb;border-radius:16px;box-shadow:0 10px 30px rgba(2,6,23,.08);overflow:hidden}
      .auth-head{padding:24px 24px 8px 24px;text-align:center}
      .auth-logo{width:56px;height:56px;border-radius:12px;margin:0 auto 12px;background:linear-gradient(135deg,#6366f1,#22c55e);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700}
      .auth-title{margin:0;font-size:22px;color:#111827}
      .auth-sub{margin:6px 0 0 0;color:#6b7280;font-size:14px}
      .auth-body{padding:16px 24px 24px 24px}
      .auth-label{display:block;font-weight:600;color:#374151;margin:10px 0 6px}
      .auth-input{width:100%;border:1px solid #d1d5db;border-radius:10px;padding:12px 14px;font-size:14px;background:#fff}
      .auth-input:focus{outline:none;border-color:#6366f1;box-shadow:0 0 0 4px rgba(99,102,241,.15)}
      .auth-row{display:flex;align-items:center;justify-content:space-between;margin-top:10px}
      .auth-remember{color:#374151;font-size:14px}
      .auth-actions{margin-top:18px}
      .auth-btn{width:100%;display:inline-flex;align-items:center;justify-content:center;background:#6366f1;color:#fff;border:0;border-radius:10px;padding:12px 14px;font-weight:600;cursor:pointer}
      .auth-btn:hover{background:#5458ea}
      .auth-muted{color:#6b7280;font-size:12px;margin-top:12px;text-align:center}
      .auth-password{position:relative}
      .auth-toggle{position:absolute;right:10px;top:50%;transform:translateY(-50%);border:0;background:transparent;color:#6b7280;cursor:pointer}
      /* Dark mode driven by theme toggle (data-theme attribute) */
      [data-theme="dark"] .auth-wrap{background:linear-gradient(135deg,#0b1220,#0f172a)}
      [data-theme="dark"] .auth-card{background:#0f172a;border-color:#1f2937}
      [data-theme="dark"] .auth-title{color:#e5e7eb}
      [data-theme="dark"] .auth-sub,[data-theme="dark"] .auth-remember,[data-theme="dark"] .auth-muted{color:#94a3b8}
      [data-theme="dark"] .auth-input{background:#0b1220;border-color:#1f2937;color:#e5e7eb}
    </style>
    <div class="auth-wrap" id="sign-in" tabindex="-1">
      <div class="auth-card" role="dialog" aria-labelledby="auth-title">
        <div class="auth-head">
          <div class="auth-logo">W</div>
          <h1 id="auth-title" class="auth-title">Sign in</h1>
          <p class="auth-sub">Access the Warehouse Management System</p>
        </div>
        <div class="auth-body">
          <form method="post" action="<?php echo esc_url( wp_login_url($redirect) ); ?>" novalidate>
            <label class="auth-label" for="user_login">Email or Username</label>
            <input class="auth-input" type="text" name="log" id="user_login" autocomplete="username" required>

            <label class="auth-label" for="user_pass" style="margin-top:12px">Password</label>
            <div class="auth-password">
              <input class="auth-input" type="password" name="pwd" id="user_pass" autocomplete="current-password" required>
              <button type="button" class="auth-toggle" aria-label="Show password" onclick="(function(btn){var i=document.getElementById('user_pass');if(i.type==='password'){i.type='text';btn.textContent='Hide';}else{i.type='password';btn.textContent='Show';}})(this)">Show</button>
            </div>

            <div class="auth-row">
              <label class="auth-remember"><input type="checkbox" name="rememberme" value="forever"> Remember me</label>
              <a href="<?php echo esc_url( wp_lostpassword_url() ); ?>">Forgot password?</a>
            </div>

            <input type="hidden" name="redirect_to" value="<?php echo esc_attr( $redirect ); ?>">
            <div class="auth-actions"><button class="auth-btn" type="submit">Sign in</button></div>
            <div class="auth-muted">Protected area — authorized users only</div>
          </form>
        </div>
      </div>
    </div>
    <?php
    get_footer();
    exit;
}

// Get active tab first
$active_tab = isset($_GET['tab']) ? sanitize_text_field($_GET['tab']) : 'dashboard';

get_header(); ?>

<div class="warehouse-app">
    <!-- Navigation Tabs -->
    <nav class="nav-tabs">
        <div class="container">
            <div class="nav-list">
                <a href="?tab=dashboard" class="nav-tab <?php echo ($active_tab === 'dashboard') ? 'active' : ''; ?>">
                    <i class="fas fa-chart-line"></i> Dashboard
                </a>
                <a href="?tab=inventory" class="nav-tab <?php echo ($active_tab === 'inventory') ? 'active' : ''; ?>">
                    <i class="fas fa-boxes"></i> Inventory
                </a>
                <a href="?tab=categories" class="nav-tab <?php echo ($active_tab === 'categories') ? 'active' : ''; ?>">
                    <i class="fas fa-tags"></i> Categories
                </a>
                <a href="?tab=locations" class="nav-tab <?php echo ($active_tab === 'locations') ? 'active' : ''; ?>">
                    <i class="fas fa-map-marker-alt"></i> Locations
                </a>
                <a href="?tab=sales" class="nav-tab <?php echo ($active_tab === 'sales') ? 'active' : ''; ?>">
                    <i class="fas fa-dollar-sign"></i> Sales
                </a>
                <a href="?tab=tasks" class="nav-tab <?php echo ($active_tab === 'tasks') ? 'active' : ''; ?>">
                    <i class="fas fa-tasks"></i> Tasks
                </a>
                <a href="?tab=team" class="nav-tab <?php echo ($active_tab === 'team') ? 'active' : ''; ?>">
                    <i class="fas fa-users"></i> Team
                </a>
                <a href="?tab=qr-codes" class="nav-tab <?php echo ($active_tab === 'qr-codes') ? 'active' : ''; ?>">
                    <i class="fas fa-qrcode"></i> QR Codes
                </a>
            </div>
        </div>
    </nav>

    <!-- Content Area -->
    <main class="main-content">
        <div class="container">
            <?php
            // Load appropriate template part based on active tab
            switch ($active_tab) {
                case 'dashboard':
                    get_template_part('template-parts/modern-dashboard');
                    break;
                case 'inventory':
                    get_template_part('template-parts/inventory');
                    break;
                case 'categories':
                    get_template_part('template-parts/categories');
                    break;
                case 'locations':
                    get_template_part('template-parts/locations');
                    break;
                case 'sales':
                    get_template_part('template-parts/sales');
                    break;
                case 'tasks':
                    get_template_part('template-parts/tasks');
                    break;
                case 'team':
                    get_template_part('template-parts/team');
                    break;
                case 'qr-codes':
                    get_template_part('template-parts/qr-codes');
                    break;
                default:
                    get_template_part('template-parts/dashboard');
                    break;
            }
            ?>
        </div>
    </main>
</div>

<?php get_footer(); ?>
