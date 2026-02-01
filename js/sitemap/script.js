// js/script.js
// Search, counts, accessibility helpers, and footer year

document.addEventListener("DOMContentLoaded", () => {
  const searchInput = document.getElementById("searchInput");
  const pageItems = Array.from(document.querySelectorAll(".page-item"));
  const totalPagesEl = document.getElementById("totalPages");
  const mainSectionsEl = document.getElementById("mainSections");
  const currentYearEl = document.getElementById("current-year");

  // Set footer year
  if (currentYearEl) currentYearEl.textContent = new Date().getFullYear();

  // Compute and display counts
  function updateCounts() {
    const visibleItems = pageItems.filter(item => item.style.display !== "none");
    totalPagesEl.textContent = visibleItems.length;
    const sections = document.querySelectorAll(".section");
    mainSectionsEl.textContent = sections.length;
    // Update per-section counts (optional)
    sections.forEach(section => {
      const countEl = section.querySelector(".section-count");
      if (countEl) {
        const items = section.querySelectorAll(".page-item");
        countEl.textContent = items.length + (items.length === 1 ? " page" : " pages");
      }
    });
  }

  // Initial counts
  updateCounts();

  // Search filter
  if (searchInput) {
    searchInput.addEventListener("input", () => {
      const q = searchInput.value.trim().toLowerCase();
      pageItems.forEach(item => {
        const title = (item.getAttribute("data-title") || item.querySelector(".page-link")?.textContent || "").toLowerCase();
        const desc = (item.querySelector(".page-desc")?.textContent || "").toLowerCase();
        const matches = q === "" || title.includes(q) || desc.includes(q);
        item.style.display = matches ? "" : "none";
      });
      updateCounts();
    });

    // keyboard: press "/" to focus search
    document.addEventListener("keydown", (e) => {
      if (e.key === "/" && document.activeElement !== searchInput) {
        const tag = document.activeElement.tagName.toLowerCase();
        if (tag !== "input" && tag !== "textarea") {
          e.preventDefault();
          searchInput.focus();
        }
      }
    });
  }

  // Improve link focus visibility for keyboard users
  document.querySelectorAll("a").forEach(a => {
    a.addEventListener("focus", () => a.classList.add("focused"));
    a.addEventListener("blur", () => a.classList.remove("focused"));
  });

  // Ensure external links open safely
  document.querySelectorAll('a[target="_blank"]').forEach(a => {
    if (!a.getAttribute("rel")) a.setAttribute("rel", "noopener noreferrer");
  });
});
