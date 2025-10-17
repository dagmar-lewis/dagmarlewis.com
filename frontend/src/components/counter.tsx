'use client'

import { useEffect, useState } from 'react'

export default function Counter() {
    const [visitCount, setVisitCount] = useState(0)
    const [loading, setLoading] = useState(true)
    const [loaded, setLoaded] = useState(false)
    
    const url = "https://eyhrme2rzd.execute-api.us-east-1.amazonaws.com/prod"
    
    useEffect(() => {
        const fetchVisitCount = async () => {
            try {
                const response = await fetch(
                    `${url}/`,
                    {
                        method: 'GET',
                    }
                )

                if (!response.ok) {
                    throw new Error('Failed to fetch visit count')
                }

                const data = await response.json()

                
                setVisitCount(data.count)
            } catch (error) {
                console.error('Error fetching visit count:', error)
            } finally {
                setLoading(false)
            }
        }
        if (loaded == false) {
            fetchVisitCount()
        }

        setLoaded(true)
    }, [loaded,url])

    return (
        <div className="flex text-lg gap-2">
            <p className="text-xl">👁️</p>
            {loading ? <p>...</p> : <p className="text-lg">{visitCount}</p>}
        </div>
    )
}
