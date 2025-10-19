import Script from 'next/script'

export const UmamiAnalytics = () => {
    
    return (
        <Script
            async
            src="https://cloud.umami.is/script.js"
            data-website-id="07cf0de2-670f-4002-96ec-c6dad5dda4c3"
        />
    )
}
