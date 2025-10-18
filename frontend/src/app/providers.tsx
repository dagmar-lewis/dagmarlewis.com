'use client' // This directive is crucial for client-side rendering

    import { PostHogProvider } from 'posthog-js/react';
    import posthog from 'posthog-js';

    // Initialize PostHog
    if (typeof window !== 'undefined') {
        posthog.init('phc_KQNV8w6qKbrE5qfwyLV9lCQR2bbMB921WQPqB5WXsx9', {
            api_host: 'https://us.i.posthog.com',
            capture_pageview: false, // Disable automatic pageview capture, as we capture manually
        })
    }


export function PHProvider({ children }: { children: React.ReactNode }) {
    return <PostHogProvider client={posthog}>{children}</PostHogProvider>
}
