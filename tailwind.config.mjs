import typography from '@tailwindcss/typography';

/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,ts,tsx,md,mdx}'],
  theme: {
    extend: {
      colors: {
        ink: {
          DEFAULT: '#0B1220', // base background
          elevated: '#101B2D', // card/section background
          border: '#23324A', // hairline dividers
        },
        paper: {
          DEFAULT: '#E8EDF4', // primary text
          muted: '#8B9AB3', // secondary text
        },
        signal: '#E8A33D', // amber — CTAs, alerts, active states
        trace: '#3D8FA8', // cool teal — diagram lines, links
      },
      fontFamily: {
        display: ['"Space Grotesk"', 'sans-serif'],
        body: ['"IBM Plex Sans"', 'sans-serif'],
        mono: ['"IBM Plex Mono"', 'monospace'],
      },
      maxWidth: {
        content: '72rem',
      },
    },
  },
  plugins: [typography],
};
