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
        <div class="header-content" style="display:flex;align-items:center;justify-content:space-between">
            <div class="user-menu-left" style="visibility:hidden">
                <!-- spacer to help center logo block -->
                <span style="display:inline-block;width:160px"></span>
            </div>

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
                    <?php if (current_user_can('manage_options')): ?>
                    <button id="open-logo-modal" class="btn btn-secondary" style="margin-left:8px"><i class="fas fa-image"></i> Logo</button>
                    <?php endif; ?>
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
    var modal = document.getElementById('logo-modal');
    if(openBtn && modal){ openBtn.addEventListener('click', function(){ modal.style.display='block'; }); }
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
