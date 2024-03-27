import { render } from '@testing-library/react';
import { describe, it, expect } from 'vitest';
import { GitVersionPresentation } from './useGitVersion';

describe('GitVersionPresentation', () => {
	it('displays the data provided', () => {
		const gitHash = 'HEAD';
		const tag = '2024.03.27';
		const { asFragment } = render(
			<GitVersionPresentation data={{ gitHash, tag }} />,
		);
		const actual = asFragment().textContent;
		expect(actual).toBe(`Hash: ${gitHash}, Tag: ${tag}`);
	});
});
