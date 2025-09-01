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
        <div class="header-content">
            <div class="logo" style="display:flex;align-items:center;gap:10px">
                <div class="company-logo" id="company-logo" style="width:36px;height:36px;border-radius:8px;background:linear-gradient(135deg,#64748b,#334155);display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;overflow:hidden">
                    <span style="font-size:16px;letter-spacing:.5px">LOGO</span>
                </div>
                <span>Warehouse Management System</span>
            </div>
            
            <div class="user-menu">
                <span id="theme-toggle-slot" aria-hidden="true"></span>
                <div id="language-switcher" class="lang-switcher" style="position:relative;margin-left:8px;">
                  <button class="btn btn-secondary" id="lang-toggle" aria-haspopup="true" aria-expanded="false">
                    <i class="fas fa-globe"></i> <span id="lang-label">EN</span>
                  </button>
                  <div id="lang-menu" class="lang-menu" style="position:absolute;right:0;top:110%;display:none;background:var(--menu-bg,#fff);border:1px solid #e5e7eb;border-radius:8px;min-width:160px;z-index:1000;overflow:hidden;">
                    <button class="lang-item" data-lang="en_US" style="display:block;width:100%;text-align:left;padding:8px 12px;background:none;border:0;cursor:pointer">English</button>
                    <button class="lang-item" data-lang="lt_LT" style="display:block;width:100%;text-align:left;padding:8px 12px;background:none;border:0;cursor:pointer">Lietuvių</button>
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
                    <a href="<?php echo wp_logout_url(home_url()); ?>" class="btn btn-secondary">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                <?php else : ?>
                    <span id="theme-toggle-slot-guest" aria-hidden="true"></span>
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
    var storedLang = localStorage.getItem('warehouse-lang') || 'en_US';
    var label = document.getElementById('lang-label');
    if(label){ label.textContent = storedLang.startsWith('lt') ? 'LT' : 'EN'; }
    var btn = document.getElementById('lang-toggle');
    var menu = document.getElementById('lang-menu');
    if(btn && menu){
      btn.addEventListener('click', function(){
        var open = menu.style.display === 'block';
        menu.style.display = open ? 'none' : 'block';
        btn.setAttribute('aria-expanded', open ? 'false' : 'true');
      });
      document.addEventListener('click', function(e){
        if(!menu.contains(e.target) && !btn.contains(e.target)) menu.style.display = 'none';
      });
      Array.prototype.forEach.call(menu.querySelectorAll('.lang-item'), function(item){
        item.addEventListener('click', function(){
          var lang = this.getAttribute('data-lang') || 'en_US';
          try{ localStorage.setItem('warehouse-lang', lang); }catch(_){}
          // Optionally inform backend via cookie to adjust get_locale()
          document.cookie = 'warehouse_lang='+lang+'; path=/';
          window.location.reload();
        });
      });
    }
  }catch(e){}
})();
</script>
