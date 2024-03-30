import { fileURLToPath } from 'node:url';
import { defineConfig } from 'vitest/config';

// https://vitejs.dev/config/
export default defineConfig({
	plugins: [],
	build: {
		outDir: '../dev-dist/vite-output',
		emptyOutDir: true,
		assetsInlineLimit: 0,
	},
	resolve: {
		alias: {
			'@': fileURLToPath(await import.meta.resolve('./src')),
		},
	},
	server: {
		hmr: {
			path: '/.vite/hmr',
		},
	},
	test: {
		globals: true,
		environment: 'jsdom',
		setupFiles: ['./vitest.setup.mts'],
	},
});
