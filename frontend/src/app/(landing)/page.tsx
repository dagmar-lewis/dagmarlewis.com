import React, { useMemo, } from 'react'
import ProjectCard from '@/components/project/project-card'
import { projects } from '#site/content'


export default function Home() {
    const sortedFeaturedProjects = useMemo(() => {
        return [...projects].sort(
            (a, b) => new Date(b.date).getTime() - new Date(a.date).getTime()
        )
    }, [])

    return sortedFeaturedProjects.map((project, index) => (
        
            <ProjectCard key={index} project={project}/>
        
    ))
}
