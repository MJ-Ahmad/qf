    (function () {
      // Reveal on scroll
      const reveals = Array.from(document.querySelectorAll('.reveal'));
      if (!reveals.length) return;

      const prefersReduced = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
      if (prefersReduced) {
        reveals.forEach(el => el.classList.add('in-view'));
        return;
      }

      if ('IntersectionObserver' in window) {
        const obs = new IntersectionObserver((entries, observer) => {
          entries.forEach(entry => {
            if (entry.isIntersecting) {
              entry.target.classList.add('in-view');
              observer.unobserve(entry.target);
            }
          });
        }, { threshold: 0.12 });
        reveals.forEach(el => obs.observe(el));
      } else {
        reveals.forEach(el => el.classList.add('in-view'));
      }

      // Subtle parallax for background image (pointer + scroll)
      const bg = document.querySelector('.mission-hero__bg');
      if (!bg) return;
      let px = 0, py = 0, tx = 0, ty = 0;
      const damp = 0.06;

      function rafLoop() {
        tx += (px - tx) * damp;
        ty += (py - ty) * damp;
        bg.style.transform = `translate3d(${tx}px, ${ty}px, 0) scale(1.03)`;
        requestAnimationFrame(rafLoop);
      }
      requestAnimationFrame(rafLoop);

      window.addEventListener('pointermove', (e) => {
        const w = window.innerWidth, h = window.innerHeight;
        px = (e.clientX / w - 0.5) * 28; // range +/-14px
        py = (e.clientY / h - 0.5) * 18; // range +/-9px
      }, { passive: true });

      window.addEventListener('scroll', () => {
        const s = window.scrollY || window.pageYOffset;
        py = Math.max(-18, Math.min(18, (s / 200) * -6));
      }, { passive: true });

      // Respect reduced motion: disable transforms
      if (prefersReduced) {
        bg.style.transform = 'none';
      }
    })();