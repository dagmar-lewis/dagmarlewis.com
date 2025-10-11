'use client'

import { type ComponentProps, type PropsWithChildren } from 'react'
import { ThemeProvider as NextThemesProvider } from 'next-themes'

type ThemeProviderProps = PropsWithChildren<
    ComponentProps<typeof NextThemesProvider>
>

export function ThemeProvider({ children, ...props }: ThemeProviderProps) {
    return <NextThemesProvider {...props}>{children}</NextThemesProvider>
}
