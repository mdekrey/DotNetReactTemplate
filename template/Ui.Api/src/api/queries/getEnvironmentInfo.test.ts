import type { FetchQueryOptions } from '@tanstack/react-query';
import { describe, it, expectTypeOf } from 'vitest';
import type { EnvironmentInfo } from './getEnvironmentInfo';
import { getEnvironmentInfo } from './getEnvironmentInfo';

describe('getEnvironmentInfo', () => {
	it('matches tanstack-query signature', () => {
		getEnvironmentInfo satisfies FetchQueryOptions<EnvironmentInfo>;
		expectTypeOf(getEnvironmentInfo.queryFn).toBeFunction();
	});
});

// TODO: test actual request
// @principlestudios/openapi-codegen-typescript-msw only supports msw 1.x - needs to be updated
