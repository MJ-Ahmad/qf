// js/section/script.js
// Reveal animations and mission background progressive clarity
(function () {
  // Reveal on scroll
  const reveals = Array.from(document.querySelectorAll('.reveal'));
  const prefersReduced = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (prefersReduced) {
    reveals.forEach(el => el.classList.add('in-view'));
  } else if ('IntersectionObserver' in window) {
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

  // Mission background progressive clarity
  const missionSection = document.getElementById('mission');
  const missionBg = document.getElementById('missionBg');
  if (missionSection && missionBg && !prefersReduced) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) missionSection.classList.add('in-view');
        else missionSection.classList.remove('in-view');
      });
    }, { threshold: [0.15, 0.45, 0.75] });
    observer.observe(missionSection);

    let ticking = false;
    window.addEventListener('scroll', () => {
      if (!missionSection.classList.contains('in-view')) return;
      if (ticking) return;
      ticking = true;
      requestAnimationFrame(() => {
        const rect = missionSection.getBoundingClientRect();
        const vh = window.innerHeight || document.documentElement.clientHeight;
        const progress = Math.min(1, Math.max(0, (vh - rect.top) / (vh + rect.height)));
        const blurStart = 18;
        const blurEnd = 4;
        const opacityStart = 0.28;
        const opacityEnd = 0.72;
        const blur = blurStart + (blurEnd - blurStart) * progress;
        const opacity = opacityStart + (opacityEnd - opacityStart) * progress;
        missionBg.style.filter = `blur(${blur}px) saturate(${0.9 + 0.15 * progress}) contrast(${0.9 + 0.12 * progress})`;
        missionBg.style.opacity = `${opacity}`;
        ticking = false;
      });
    }, { passive: true });
  }
})();
