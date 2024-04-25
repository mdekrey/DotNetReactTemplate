import { useGitVersion } from './useGitVersion';

export function InfoComponent() {
	const GitVersion = useGitVersion();
	return <GitVersion />;
}
