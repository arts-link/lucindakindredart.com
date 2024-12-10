// document.documentElement.className = 'dark'; 
// document.documentElement.className = 'light'; 


document.addEventListener('DOMContentLoaded', () => {
  const hamburger = document.querySelector('.hamburger');
  const mainNav = document.querySelector('nav.main');

  hamburger.addEventListener('click', () => {
    mainNav.classList.toggle('menu-open');
    hamburger.setAttribute('aria-expanded', 
      hamburger.getAttribute('aria-expanded') === 'true' ? 'false' : 'true'
    );
  });
});