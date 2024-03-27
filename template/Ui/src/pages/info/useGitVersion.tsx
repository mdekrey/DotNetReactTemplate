import { useCallback } from 'react';
import { useSuspenseQuery } from '@tanstack/react-query';
import { getInfo } from '@/utils/api/queries/getInfo';

export function useGitVersion() {
	const result = useSuspenseQuery(getInfo);
	return useCallback(
		() => (
			<>
				Hash: {result.data.gitHash}, Tag: {result.data.tag}
			</>
		),
		[result],
	);
}
