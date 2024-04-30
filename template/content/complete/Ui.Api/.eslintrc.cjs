/** @type {import('eslint').Linter.Config} */
module.exports = {
	overrides: [
		{
			files: ['**/*.{cts,mts,ts,tsx}'],
			parserOptions: {
				ecmaVersion: 'latest',
				sourceType: 'module',
				project: './tsconfig.node.json',
				tsconfigRootDir: __dirname,
			},
		},
		{
			files: ['src/**/*.{cts,mts,ts,tsx}'],
			parserOptions: {
				project: './tsconfig.json',
				tsconfigRootDir: __dirname,
			},
		},
	],
};
