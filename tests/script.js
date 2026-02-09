// Set current year in footer
document.addEventListener('DOMContentLoaded', function () {
  const yearEl = document.getElementById('year');
  if (yearEl) yearEl.textContent = new Date().getFullYear();

  // Smooth scroll for internal links
  document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
    anchor.addEventListener('click', function (e) {
      const href = this.getAttribute('href');
      if (href === '#' || href === '#top') {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: 'smooth' });
        return;
      }
      const target = document.querySelector(href);
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });

  // Lazy load images using IntersectionObserver
  const images = document.querySelectorAll('img');
  if ('IntersectionObserver' in window) {
    const io = new IntersectionObserver((entries, obs) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const img = entry.target;
          // If you want to use data-src for lazy loading, swap src here
          // img.src = img.dataset.src;
          obs.unobserve(img);
        }
      });
    }, { rootMargin: '100px' });

    images.forEach(img => io.observe(img));
  }

  // Simple keyboard accessibility for video iframe
  const iframe = document.querySelector('.video-wrapper iframe');
  if (iframe) {
    iframe.setAttribute('tabindex', '0');
  }
});
