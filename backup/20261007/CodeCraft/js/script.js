    // Set current year in footer
    document.getElementById('year').textContent = new Date().getFullYear();

    // Copy functionality with language-aware toast
    (function(){
      const toastEl = document.getElementById('copyToast');
      const toast = new bootstrap.Toast(toastEl, { delay: 2000 });

      // Delegate click for copy buttons
      document.addEventListener('click', async (e) => {
        const btn = e.target.closest('.copy-btn');
        if (!btn) return;

        const targetSelector = btn.getAttribute('data-target');
        if (!targetSelector) return;

        const target = document.querySelector(targetSelector);
        if (!target) return;

        // Extract code text
        const pre = target.querySelector('pre');
        if (!pre) return;
        const codeText = pre.innerText.trim();

        try {
          // Use Clipboard API
          await navigator.clipboard.writeText(codeText);

          // Determine language label for toast message
          const header = btn.closest('.code-card').querySelector('.lang-badge');
          const lang = header ? header.textContent.trim() : 'Code';

          // Update and show toast
          document.getElementById('copyToastBody').textContent = `✅ ${lang} copied to clipboard`;
          toast.show();
        } catch (err) {
          console.error('Copy failed', err);
          document.getElementById('copyToastBody').textContent = '⚠️ Copy failed';
          toast.show();
        }
      });

      // Improve collapse toggle icon rotation
      document.querySelectorAll('.collapse-toggle').forEach(btn => {
        const icon = btn.querySelector('i');
        const target = document.querySelector(btn.getAttribute('data-bs-target'));
        if (!target) return;

        // Update icon on collapse events
        target.addEventListener('show.bs.collapse', () => { icon.classList.remove('bi-chevron-down'); icon.classList.add('bi-chevron-up'); btn.setAttribute('aria-expanded','true'); });
        target.addEventListener('hide.bs.collapse', () => { icon.classList.remove('bi-chevron-up'); icon.classList.add('bi-chevron-down'); btn.setAttribute('aria-expanded','false'); });
      });

    })();