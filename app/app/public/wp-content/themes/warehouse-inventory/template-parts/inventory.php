<?php if (!defined('ABSPATH')) { exit; } ?>
<div class="wh-card">
  <div style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
    <label for="wh-location-select">Location</label>
    <select id="wh-location-select">
      <option value="">All locations</option>
    </select>
    <input type="search" id="wh-search" placeholder="Search inventory…" />
  </div>
  <div id="wh-inventory-list" class="wh-grid" style="margin-top:12px;"></div>
</div>

<script>
(function(){
  const $list = document.getElementById('wh-inventory-list');
  const $search = document.getElementById('wh-search');
  const $loc = document.getElementById('wh-location-select');
  function render(items){
    $list.innerHTML = (items||[]).map(item => (
      `<div class="wh-card"><strong>${item.name || ''}</strong><br/><small>${item.category_name||''} • ${item.location_name||''}</small></div>`
    )).join('');
  }
  function fetchLocations(){
    if (!window.whInventory) return;
    const data = new FormData();
    data.append('action','get_locations');
    data.append('nonce', whInventory.nonce);
    fetch(whInventory.ajax_url,{method:'POST',credentials:'same-origin',body:data}).then(r=>r.json()).then(json=>{
      if (json && json.success && json.data && Array.isArray(json.data.locations)){
        json.data.locations.forEach(l=>{
          const opt=document.createElement('option');
          opt.value=l.id; opt.textContent=l.name; $loc.appendChild(opt);
        });
      }
    }).catch(()=>{});
  }
  function fetchItems(){
    if (!window.whInventory) return;
    const data = new FormData();
    data.append('action','get_inventory_items');
    data.append('nonce', whInventory.nonce);
    if ($search.value) data.append('search',$search.value);
    if ($loc.value) data.append('location', parseInt($loc.value,10));
    fetch(whInventory.ajax_url,{method:'POST',credentials:'same-origin',body:data}).then(r=>r.json()).then(json=>{
      render((json&&json.data&&json.data.items)||[]);
    }).catch(()=>{});
  }
  document.addEventListener('DOMContentLoaded', function(){
    fetchLocations();
    fetchItems();
    $search.addEventListener('input',()=>{ fetchItems(); });
    $loc.addEventListener('change',()=>{ fetchItems(); });
  });
})();
</script>
