import { defineConfig } from '@vscode/test-cli';
import { fileURLToPath } from 'node:url';
import path from 'node:path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const addonRoot = path.resolve(__dirname);

export default defineConfig({
	cwd: addonRoot,
	files: './out/test/**/*.test.js',
	launchArgs: ['--disable-extensions'],
});
