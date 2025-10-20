// Burger menu responsive
const burger = document.querySelector('.burger');
const nav = document.querySelector('nav ul');

burger.addEventListener('click', () => {
    nav.classList.toggle('active');
});

// Smooth scroll
document.querySelectorAll('nav ul li a').forEach(link => {
    link.addEventListener('click', function(e){
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        target.scrollIntoView({behavior: 'smooth', block: 'start'});
        if(nav.classList.contains('active')) nav.classList.remove('active');
    });
});

// Apparition progressive sections
const sections = document.querySelectorAll('.section-card, .hero-section');

const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
        if(entry.isIntersecting){
            entry.target.classList.add('show');
        }
    });
},{ threshold: 0.2 });

sections.forEach(section => observer.observe(section));

// Animation texte "Qui suis-je"
const qsCard = document.querySelector('.qui-suis-card');
qsCard.style.opacity = 0;
qsCard.style.transform = 'translateX(-50px)';
window.addEventListener('load', () => {
    qsCard.style.transition = 'all 1s ease-out';
    qsCard.style.opacity = 1;
    qsCard.style.transform = 'translateX(0)';
});

// Animation des barres de langue au clic
document.querySelectorAll(".langue-item").forEach(item => {
    item.addEventListener("click", () => {
        const fill = item.querySelector(".langue-fill");
        const level = item.getAttribute("data-level");
        fill.style.width = level + "%";
    });
});

navLinks.forEach(link => {
    link.addEventListener('click', function(e){
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        const navHeight = document.querySelector('nav').offsetHeight;
        const targetPosition = target.getBoundingClientRect().top + window.scrollY - navHeight;
        window.scrollTo({
            top: targetPosition,
            behavior: 'smooth'
        });
    });
});





