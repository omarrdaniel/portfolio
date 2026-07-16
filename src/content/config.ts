import { defineCollection, z } from 'astro:content';

const projects = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    // Generic descriptor only — never a real client name (see content note in each .md file)
    sector: z.string(),
    role: z.string(),
    period: z.string(),
    stack: z.array(z.string()),
    summary: z.string(),
    order: z.number().default(0),
  }),
});

export const collections = { projects };
