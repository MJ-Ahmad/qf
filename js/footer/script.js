// js/footer/script.js
// (Placeholder) Footer interactions: nothing required now but keep file for future enhancements
(function () {
  // Example: track clicks on sponsor links (no analytics included)
  const sponsorLinks = document.querySelectorAll('footer a[href*="sponsors"], footer a[href*="ko-fi"]');
  sponsorLinks.forEach(a => {
    a.addEventListener('click', () => {
      // Placeholder: custom event or analytics hook could go here
      // console.log('Sponsor link clicked:', a.href);
    });
  });
})();
