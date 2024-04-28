import { render } from '@testing-library/react';
import { describe, it, expect } from 'vitest';
import { InfoComponent } from '.';

describe('GitVersionPresentation', () => {
	it('displays the data provided', () => {
		const { asFragment } = render(
			<InfoComponent />,
		);
		const actual = asFragment().textContent;
		expect(actual).toBe(`Hello, Template`);
	});
});
