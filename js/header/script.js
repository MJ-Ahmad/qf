    (function(){
      const toggle=document.getElementById('mobileToggle');
      const nav=document.getElementById('headerNav');
      if(!toggle||!nav) return;
      toggle.addEventListener('click',()=>{
        const isOpen=nav.classList.toggle('open');
        toggle.setAttribute('aria-expanded',String(isOpen));
      });
    })();