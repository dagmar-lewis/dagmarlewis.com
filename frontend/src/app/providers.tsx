'use client' 

    import { PostHogProvider } from 'posthog-js/react';
    import posthog from 'posthog-js';

    
    if (typeof window !== 'undefined') {
        posthog.init('phc_KQNV8w6qKbrE5qfwyLV9lCQR2bbMB921WQPqB5WXsx9', {
            api_host: 'https://us.i.posthog.com',
            defaults: '2025-05-24'
        })
    }


export function PHProvider({ children }: { children: React.ReactNode }) {
    return <PostHogProvider client={posthog}>{children}</PostHogProvider>
}
