import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

// static output for Cloudflare Pages
export default defineConfig({
  site: 'https://omardaniel.dev', // update once domain is live
  output: 'static',
  integrations: [tailwind({ applyBaseStyles: false })],
  devToolbar: { enabled: false },
});
