import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const projects = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/projects' }),
  schema: z.object({
    title: z.string(),
    sector: z.string(), // generic descriptor, never a real client name
    role: z.string(),
    period: z.string(),
    stack: z.array(z.string()),
    summary: z.string(),
    order: z.number().default(0),
  }),
});

export const collections = { projects };
