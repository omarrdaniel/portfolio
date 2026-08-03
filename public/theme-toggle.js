document.getElementById('theme-toggle').addEventListener('click', function () {
  var root = document.documentElement;
  var isDark = root.classList.toggle('dark');
  document.cookie = 'theme=' + (isDark ? 'dark' : 'light') + '; max-age=3600; path=/; SameSite=Lax';
});
