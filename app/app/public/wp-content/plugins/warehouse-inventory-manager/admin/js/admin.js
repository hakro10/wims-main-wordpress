/* global ajaxurl */
(function(){
  function setTheme(mode){
    document.documentElement.setAttribute('data-theme', mode);
    try { localStorage.setItem('wh-theme', mode); } catch(e) {}
  }
  function getTheme(){
    try { return localStorage.getItem('wh-theme') || 'light'; } catch(e) { return 'light'; }
  }
  function mountToolbar(){
    if (document.getElementById('wh-toolbar')) return;
    const bar = document.createElement('div');
    bar.id = 'wh-toolbar';
    bar.className = 'wh-toolbar';
    const toggle = document.createElement('button');
    toggle.className = 'wh-toggle';
    toggle.type = 'button';
    const updateLabel = ()=> toggle.textContent = (document.documentElement.getAttribute('data-theme')==='dark'?'Light':'Dark') + ' mode';
    toggle.addEventListener('click', function(){
      const current = document.documentElement.getAttribute('data-theme') || 'light';
      setTheme(current === 'dark' ? 'light' : 'dark');
      updateLabel();
    });
    updateLabel();
    bar.appendChild(toggle);
    document.body.appendChild(bar);
  }
  document.addEventListener('DOMContentLoaded', function(){
    setTheme(getTheme());
    mountToolbar();
  });
})();

