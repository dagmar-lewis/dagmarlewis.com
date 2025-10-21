import '@/styles/globals.css'
import '@/styles/code.css'
import { Metadata } from 'next/types'
import { cn } from '@/lib/utils'
import localFont from 'next/font/local'
import { siteConfig } from '@/config/site.config'
import { ThemeProvider } from '@/components/theme/theme-provider'
import { GeistSans } from 'geist/font/sans'
import { GeistMono } from 'geist/font/mono'
import type { Viewport } from 'next'
import { UmamiAnalytics } from '@/components/umamiAnalytics'

import { GoogleAnalytics } from '@next/third-parties/google'


const fontHeading = localFont({
    src: '../../assets/fonts/CalSans-SemiBold.woff2',
    variable: '--font-heading',
})

export const metadata: Metadata = {
    metadataBase: new URL(siteConfig.siteUrl),
    title: siteConfig.title,
    description: siteConfig.description,
    authors: [
        {
            name: siteConfig.creator.name,
            url: siteConfig.creator.url,
        },
    ],
    creator: siteConfig.creator.name,
    alternates: {
        canonical: '/', // Set the canonical path relative to metadataBase
    },
    icons: {
        icon: '/favicon.png',
        shortcut: '/favicon-16x16.png',
        apple: '/apple-touch-icon.png',
    },
    // OpenGraph metadata
    openGraph: {
        title: siteConfig.title,
        description: siteConfig.description,
        url: siteConfig.siteUrl,
        siteName: siteConfig.name,
        images: [
            {
                url: siteConfig.ogImage,
                width: 1800,
                height: 1000,
                alt: siteConfig.name,
            },
        ],
        type: 'website',
        locale: 'en_US',
    },

    // Twitter metadata
    twitter: {
        card: 'summary_large_image',
        site: siteConfig.creator.url,
        title: siteConfig.title,
        description: siteConfig.description,
        images: {
            url: siteConfig.ogImage,
            width: 1800,
            height: 1000,
            alt: siteConfig.name,
        },
    },
}

export default function RootLayout({
    children,
}: {
    children: React.ReactNode
}) {
    return (
        <html lang="en" suppressHydrationWarning>
            <body
                className={cn(
                    fontHeading.variable,
                    GeistSans.variable,
                    GeistMono.variable
                )}
            >
                <ThemeProvider attribute="class" defaultTheme="dark">
                    {children}
                </ThemeProvider>
                <GoogleAnalytics gaId="G-B41C9H6QJ5" />
                <UmamiAnalytics />
            </body>
        </html>
    )
}
