'use client'

import React, { useState, ReactElement } from 'react'

export const CopyButton = ({ children }: { children: React.ReactNode }) => {
    const [isCopied, setIsCopied] = useState(false)

    const copy = async () => {
        const sourceCode = extractSourceCode(children)
        await navigator.clipboard.writeText(sourceCode)
        setIsCopied(true)

        setTimeout(() => {
            setIsCopied(false)
        }, 10000)
    }

    const extractSourceCode = (
        node: React.ReactNode | ReactElement
    ): string => {
        if (typeof node === 'string') {
            return node
        }
        if (Array.isArray(node)) {
            return node.map(extractSourceCode).join('')
        }
        if (React.isValidElement(node)) {
            // Explicitly type props as React.PropsWithChildren<any> to indicate it has children
            const props: React.PropsWithChildren<any> = node.props
            if (props.children) return extractSourceCode(props.children)
        }
        return ''
    }

    return (
        <button disabled={isCopied} onClick={copy}>
            {isCopied ? 'Copied!' : 'Copy'}
        </button>
    )
}
