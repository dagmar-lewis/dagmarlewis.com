"use client"

import { useEffect, useState } from 'react'

export default function Counter() {
  
  const [visitCount, setVisitCount] = useState(0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchVisitCount = async () => {
      try {
        // Replace with your actual API Gateway URL
        const response = await fetch('https://vvorq0nqj1.execute-api.us-east-1.amazonaws.com/', {
          method: 'GET',
        });

        if (!response.ok) {
          throw new Error('Failed to fetch visit count');
        }

        const data = await response.json();

        // Assuming Lambda returns: { "count": 25 }
        setVisitCount(data.count);
      } catch (error) {
        console.error('Error fetching visit count:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchVisitCount();
    
  }, []);

  return (
    <div className='flex text-lg gap-2'>
    <p className='text-xl'>👁️</p>
    {loading ? <p>...</p> : <p className='text-lg'>{visitCount}</p>}
    </div>
  )
}

