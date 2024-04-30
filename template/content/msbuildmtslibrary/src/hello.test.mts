import { describe, it, expect } from 'vitest';
import { hello } from './hello.mjs';

describe('hello', () => {
	it('is a basic hello-word test', () => {
		expect(hello('world')).toBe('Hello, world');
	});
});

// TODO: test actual request
// @principlestudios/openapi-codegen-typescript-msw only supports msw 1.x - needs to be updated
