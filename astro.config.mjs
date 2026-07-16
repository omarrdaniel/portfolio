import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

// Static output — deployed as static assets to Cloudflare Pages.
export default defineConfig({
  site: 'https://omardaniel.dev', // update once domain is registered
  output: 'static',
  integrations: [tailwind({ applyBaseStyles: false })],
});
