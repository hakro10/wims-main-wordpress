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
            <div class="logo">
                <i class="fas fa-warehouse"></i>
                Warehouse Management System
            </div>
            
            <div class="user-menu">
                <span id="theme-toggle-slot" aria-hidden="true"></span>
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
