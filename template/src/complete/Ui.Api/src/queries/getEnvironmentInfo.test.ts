import type { FetchQueryOptions } from '@tanstack/react-query';
import { describe, it, expectTypeOf } from 'vitest';
import type { EnvironmentInfo } from './getEnvironmentInfo.mjs';
import { getEnvironmentInfo } from './getEnvironmentInfo.mjs';

describe('getEnvironmentInfo', () => {
	it('matches tanstack-query signature', () => {
		getEnvironmentInfo satisfies FetchQueryOptions<EnvironmentInfo>;
		expectTypeOf(getEnvironmentInfo.queryFn).toBeFunction();
	});
});

// TODO: test actual request
// @principlestudios/openapi-codegen-typescript-msw only supports msw 1.x - needs to be updated
