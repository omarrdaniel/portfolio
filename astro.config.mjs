import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

// static output for Cloudflare Pages
export default defineConfig({
  site: 'https://omardaniel.dev', // update once domain is live
  output: 'static',
  vite: {
    plugins: [tailwindcss()],
  },
  devToolbar: { enabled: false },
});
