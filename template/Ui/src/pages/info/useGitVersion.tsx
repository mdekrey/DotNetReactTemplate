import { useCallback } from 'react';
import { useSuspenseQuery } from '@tanstack/react-query';
import { getInfo } from '@/utils/api/queries/getInfo';

export function useGitVersion() {
	const result = useSuspenseQuery(getInfo);
	return useCallback(
		() => <GitVersionPresentation data={result.data} />,
		[result.data],
	);
}

export function GitVersionPresentation({
	data,
}: {
	data: { gitHash: string; tag: string };
}) {
	return (
		<>
			Hash: {data.gitHash}, Tag: {data.tag}
		</>
	);
}
