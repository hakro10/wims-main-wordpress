<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="profile" href="https://gmpg.org/xfn/11">
    
    <script>
      (function(){
        try{
          var th = localStorage.getItem('warehouse-theme');
          if(!th){ th = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'; }
          document.documentElement.setAttribute('data-theme', th);
          // Sync language cookie with stored preference for consistent server-rendered labels
          var lang = localStorage.getItem('warehouse-lang') || 'en_US';
          // If cookie missing or different, set a long-lived cookie
          var needsSet = true;
          try { needsSet = document.cookie.indexOf('warehouse_lang='+lang) === -1; } catch(_) {}
          if (needsSet) { document.cookie = 'warehouse_lang='+lang+'; path=/; max-age='+(60*60*24*365); }
        }catch(e){}
      })();
    </script>
    <?php wp_head(); ?>
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Shadcn UI Components -->
    <link rel="stylesheet" href="<?php echo get_template_directory_uri(); ?>/assets/css/shadcn-components.css">
</head>

<body <?php body_class(); ?>>

<header class="warehouse-header">
    <div class="container">
        <div class="header-content" style="display:grid;grid-template-columns:1fr auto 1fr;align-items:center;">
            <!-- Left: App title -->
            <div class="app-title" style="display:flex;align-items:center;gap:10px;justify-content:flex-start;">
                <span class="warehouse-title">Warehouse Management System</span>
            </div>

            <!-- Center: Company logo (upload/custom/fallback) -->
            <div class="logo" style="display:flex;align-items:center;gap:10px;justify-content:center;text-align:center;">
                <?php 
                  $custom = function_exists('the_custom_logo') && has_custom_logo();
                  $opt_logo = get_option('wh_company_logo_url');
                  if ($opt_logo) {
                    echo '<img src="'.esc_url($opt_logo).'" alt="Company Logo" class="custom-logo" />';
                  } elseif ($custom) { the_custom_logo(); } else { ?>
                <div class="company-logo" id="company-logo" style="width:36px;height:36px;border-radius:8px;background:linear-gradient(135deg,#64748b,#334155);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;overflow:hidden">
                    <span style="font-size:16px;letter-spacing:.5px">LOGO</span>
                </div>
                <?php } ?>
            </div>

            <!-- Right: User/menu controls -->
            <div class="user-menu" style="justify-self:end;">
                <!-- Unified Settings dropdown -->
                <div class="settings-wrap" style="position:relative">
                  <button id="settings-toggle" class="btn btn-secondary" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-gear"></i> <span>Settings</span>
                  </button>
                  <div id="settings-menu" class="settings-menu" style="position:absolute;right:0;top:110%;display:none;background:var(--menu-bg,#fff);border:1px solid #e5e7eb;border-radius:10px;min-width:260px;z-index:1000;overflow:hidden;box-shadow:0 10px 20px rgba(0,0,0,0.08)">
                    <!-- Animated reveal container -->
                    <div style="padding:10px 10px 6px 10px;border-bottom:1px solid #e5e7eb;display:flex;align-items:center;gap:10px">
                      <i class="fas fa-user-circle" style="font-size:18px;color:#64748b"></i>
                      <strong style="font-size:14px">User</strong>
                    </div>
                    <div style="padding:8px 10px;display:grid;gap:6px">
                      <button id="toggle-theme" class="menu-row" style="display:flex;align-items:center;justify-content:space-between;padding:8px 10px;border-radius:8px;border:1px solid #e5e7eb;background:transparent;cursor:pointer">
                        <span style="display:flex;align-items:center;gap:8px"><i class="fas fa-moon"></i><span>Appearance</span></span>
                        <span id="theme-state" style="font-size:12px;color:#6b7280">Light</span>
                      </button>
                      <div class="menu-row" style="padding:8px 10px;border-radius:8px;border:1px solid #e5e7eb;display:flex;align-items:center;justify-content:space-between;gap:8px">
                        <span style="display:flex;align-items:center;gap:8px"><i class="fas fa-globe"></i><span>Language</span></span>
                        <div>
                          <button class="lang-choice" data-lang="en_US" style="margin-right:4px" aria-label="Switch to English">EN</button>
                          <button class="lang-choice" data-lang="lt_LT" aria-label="Switch to Lithuanian">LT</button>
                        </div>
                      </div>
                      <?php if (is_user_logged_in()): ?>
                      <a href="<?php echo esc_url( admin_url('profile.php') ); ?>" class="menu-row" style="display:flex;align-items:center;gap:8px;padding:8px 10px;border-radius:8px;border:1px solid #e5e7eb;text-decoration:none"><i class="fas fa-id-badge"></i><span>Profile</span></a>
                      <?php if (current_user_can('manage_options')): ?>
                      <button id="menu-logo" class="menu-row" style="display:flex;align-items:center;gap:8px;padding:8px 10px;border-radius:8px;border:1px solid #e5e7eb;background:transparent;cursor:pointer"><i class="fas fa-image"></i><span>Company Logo</span></button>
                      <?php endif; ?>
                      <a href="<?php echo esc_url( wp_logout_url(home_url()) ); ?>" class="menu-row" style="display:flex;align-items:center;gap:8px;padding:8px 10px;border-radius:8px;border:1px solid #e5e7eb;text-decoration:none"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
                      <?php endif; ?>
                    </div>
                    <?php if (current_user_can('manage_options') || current_user_can('manage_warehouse_users')): ?>
                    <div style="padding:10px;border-top:1px solid #e5e7eb"></div>
                    <div style="padding:10px 10px 6px 10px;border-bottom:1px solid #e5e7eb;display:flex;align-items:center;gap:10px">
                      <i class="fas fa-shield-alt" style="font-size:18px;color:#64748b"></i>
                      <strong style="font-size:14px">Admin</strong>
                    </div>
                    <div style="padding:8px 10px 12px 10px;display:grid;gap:6px">
                      <a href="<?php echo esc_url( admin_url('options-general.php?page=wh-security') ); ?>" class="menu-row" style="display:flex;align-items:center;gap:8px;padding:8px 10px;border-radius:8px;border:1px solid #e5e7eb;text-decoration:none"><i class="fas fa-lock"></i><span>Security</span></a>
                      <a href="<?php echo esc_url( admin_url('users.php') ); ?>" class="menu-row" style="display:flex;align-items:center;gap:8px;padding:8px 10px;border-radius:8px;border:1px solid #e5e7eb;text-decoration:none"><i class="fas fa-users-cog"></i><span>User Management</span></a>
                    </div>
                    <?php endif; ?>
                  </div>
                </div>
                <?php if (is_user_logged_in()) : ?>
                    <?php $current_user = wp_get_current_user(); ?>
                    <span class="user-greeting">
                        Welcome, <?php echo esc_html($current_user->display_name); ?>
                    </span>
                    <div class="online-status">
                        <span class="status-indicator online" title="Online"></span>
                    </div>
                <?php else : ?>
                    <a href="#sign-in" class="btn btn-primary" onclick="(function(e){e.preventDefault();var t=document.getElementById('sign-in'); if(t){ t.scrollIntoView({behavior:'smooth', block:'start'}); } else { window.location.href = '<?php echo esc_js( home_url('/') ); ?>#sign-in'; }})(event)">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                <?php endif; ?>
            </div>
        </div>
    </div>
</header> 

<script>
(function(){
  try{
    // Settings dropdown behavior
    var sBtn = document.getElementById('settings-toggle');
    var sMenu = document.getElementById('settings-menu');
    if (sBtn && sMenu) {
      sBtn.addEventListener('click', function(){
        var open = sMenu.style.display === 'block';
        sMenu.style.display = open ? 'none' : 'block';
        sBtn.setAttribute('aria-expanded', open ? 'false' : 'true');
      });
      document.addEventListener('click', function(e){
        if(!sMenu.contains(e.target) && !sBtn.contains(e.target)) sMenu.style.display = 'none';
      });
    }
    // Theme toggle in dropdown
    var themeBtn = document.getElementById('toggle-theme');
    var themeState = document.getElementById('theme-state');
    function currentTheme(){ return document.documentElement.getAttribute('data-theme') || 'light'; }
    function setTheme(t){ try{ localStorage.setItem('warehouse-theme', t); }catch(_){} document.documentElement.setAttribute('data-theme', t); if(themeState){ themeState.textContent = t==='dark' ? 'Dark' : 'Light'; } }
    if(themeState){ themeState.textContent = currentTheme()==='dark' ? 'Dark' : 'Light'; }
    if(themeBtn){ themeBtn.addEventListener('click', function(){ var next = currentTheme()==='dark' ? 'light' : 'dark'; setTheme(next); }); }
    // Language selection in dropdown
    var storedLang = localStorage.getItem('warehouse-lang') || 'en_US';
    Array.prototype.forEach.call(document.querySelectorAll('.lang-choice'), function(btn){
      btn.addEventListener('click', function(){
        var lang = this.getAttribute('data-lang') || 'en_US';
        try{ localStorage.setItem('warehouse-lang', lang); }catch(_){}
        document.cookie = 'warehouse_lang='+lang+'; path=/';
        window.location.reload();
      });
      // simple selected state styling
      if (btn.getAttribute('data-lang') === storedLang) { btn.style.fontWeight = '700'; }
    });
  }catch(e){}
})();
</script>

<!-- Logo Upload Modal -->
<div id="logo-modal" class="modal-overlay" style="display:none;">
  <div class="modal" style="max-width:480px">
    <div class="modal-header"><h3 class="modal-title">Update Company Logo</h3><button class="modal-close" onclick="document.getElementById('logo-modal').style.display='none'">&times;</button></div>
    <div class="modal-body">
      <div id="logo-dropzone" class="logo-dropzone" style="border:2px dashed #e5e7eb;border-radius:10px;padding:20px;text-align:center;cursor:pointer">
        <div id="logo-preview-wrap" style="display:none;margin-bottom:10px"><img id="logo-preview" alt="Preview" style="max-height:80px;max-width:100%;border-radius:8px"/></div>
        <div id="logo-droptext">Drop image here or click to browse</div>
      </div>
      <input type="file" id="logo-file" accept="image/*" style="display:none" />
      <p class="form-hint" style="margin-top:8px">Recommended: transparent PNG/SVG, height ~36px.</p>
    </div>
    <div class="modal-footer">
      <button class="btn btn-secondary" onclick="document.getElementById('logo-modal').style.display='none'">Cancel</button>
      <button class="btn btn-danger" id="delete-logo-btn">Remove</button>
      <button class="btn btn-primary" id="upload-logo-btn">Save</button>
    </div>
  </div>
  <script>
  (function(){
    var openBtn = document.getElementById('open-logo-modal');
    var openFromMenu = document.getElementById('menu-logo');
    var modal = document.getElementById('logo-modal');
    if(openBtn && modal){ openBtn.addEventListener('click', function(){ modal.style.display='block'; }); }
    if(openFromMenu && modal){ openFromMenu.addEventListener('click', function(){ modal.style.display='block'; sMenu.style.display='none'; }); }
    var up = document.getElementById('upload-logo-btn');
    var del = document.getElementById('delete-logo-btn');
    var dz = document.getElementById('logo-dropzone');
    var input = document.getElementById('logo-file');
    var pv = document.getElementById('logo-preview');
    var pvwrap = document.getElementById('logo-preview-wrap');
    if(dz && input){
      ['click'].forEach(function(ev){ dz.addEventListener(ev, function(){ input.click(); }); });
      function handleFiles(files){
        if(!files || !files[0]) return;
        var f = files[0];
        var reader = new FileReader();
        reader.onload = function(e){ pv.src = e.target.result; pvwrap.style.display='block'; };
        reader.readAsDataURL(f);
      }
      input.addEventListener('change', function(){ handleFiles(this.files); });
      ;['dragover','dragenter'].forEach(function(ev){ dz.addEventListener(ev,function(e){ e.preventDefault(); dz.style.borderColor='#60a5fa'; }); });
      ;['dragleave','drop'].forEach(function(ev){ dz.addEventListener(ev,function(e){ e.preventDefault(); dz.style.borderColor=''; if(ev==='drop'){ handleFiles(e.dataTransfer.files); } }); });
    }
    function ajax(action, body){
      return fetch(warehouse_ajax.ajax_url, { method:'POST', body: body }).then(r=>r.json());
    }
    if(up){ up.addEventListener('click', function(){
      var f = document.getElementById('logo-file').files[0];
      if(!f){ alert('Choose a file'); return; }
      var fd = new FormData();
      fd.append('action','wh_upload_logo');
      fd.append('nonce', warehouse_ajax.nonce);
      fd.append('file', f);
      ajax('wh_upload_logo', fd).then(function(res){
        if(res && res.success){ location.reload(); } else { alert(res && res.data ? res.data : 'Upload failed'); }
      }).catch(function(){ alert('Upload failed'); });
    }); }
    if(del){ del.addEventListener('click', function(){
      if(!confirm('Remove company logo?')) return;
      var fd = new FormData();
      fd.append('action','wh_delete_logo');
      fd.append('nonce', warehouse_ajax.nonce);
      ajax('wh_delete_logo', fd).then(function(res){
        if(res && res.success){ location.reload(); } else { alert('Delete failed'); }
      }).catch(function(){ alert('Delete failed'); });
    }); }
  })();
  </script>
</div>
