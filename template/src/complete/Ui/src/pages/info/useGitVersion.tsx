import { useCallback } from 'react';
import { useSuspenseQuery } from '@tanstack/react-query';
import type { EnvironmentInfo } from '@ui/ui.api/queries/getEnvironmentInfo';
import { getEnvironmentInfo } from '@ui/ui.api/queries/getEnvironmentInfo';

export function useGitVersion() {
	const result = useSuspenseQuery(getEnvironmentInfo);
	return useCallback(
		() => <GitVersionPresentation data={result.data} />,
		[result.data],
	);
}

export function GitVersionPresentation({ data }: { data: EnvironmentInfo }) {
	return (
		<>
			Hash: {data.gitHash}, Tag: {data.tag}
		</>
	);
}
