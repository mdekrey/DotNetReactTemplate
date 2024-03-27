import { Suspense } from 'react';
import type { RouteObject } from 'react-router-dom';
import { HashRouter, Navigate, useRoutes } from 'react-router-dom';
import { InfoComponent } from './pages/info';

const mainRoute: RouteObject[] = [
	{ path: 'info/', Component: InfoComponent },
	{ path: '/', element: <Navigate to="/overview" replace={true} /> },
];

function App() {
	return <Suspense>{useRoutes(mainRoute)}</Suspense>;
}

function AppProviders() {
	return (
		<HashRouter future={{ v7_startTransition: true }}>
			<App />
		</HashRouter>
	);
}

export default AppProviders;
