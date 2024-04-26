import { type StructuredResponses } from '@/generated/api/operations/getEnvironmentInfo';
import { api } from '../fetch-api';

export type EnvironmentInfo = StructuredResponses[200]['application/json'];

export const getEnvironmentInfo = {
	queryKey: ['env'],
	queryFn: async (): Promise<EnvironmentInfo> => {
		const response = await api.getEnvironmentInfo();
		if (response.statusCode !== 200) return Promise.reject(response);
		return response.data;
	},
};
