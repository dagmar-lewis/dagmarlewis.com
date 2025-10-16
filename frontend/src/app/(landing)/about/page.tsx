import { skillsConfig } from '@/config/skills.config'
import { profesHighlights } from '@/config/profesional.highlights'

export default function Hero() {
    return (
        <div className="flex flex-col text-sm space-y-2 rounded max-w-2xl text-foreground/70 my-7">
            <h1 className="text-lg text-foreground font-bold underline">
                Tools & Certifications
            </h1>
            <p>
                {skillsConfig.map((skill) => (
                    <p key={skill.category}>
                        <span className="font-semibold text-primary/90">
                            {skill.category}:
                        </span>{' '}
                        <a
                            href={skill.link}
                            target="_blank"
                            rel="noopener noreferrer"
                            className={skill.link ? 'underline' : ''}
                        >
                            {skill.technologies.join(', ')}
                        </a>
                    </p>
                ))}
            </p>
            <h2 className="text-lg text-foreground mt-6 font-bold underline">
                Professional Highlights
            </h2>
            {profesHighlights.map((prof) => (
                <p key={prof.highlight}>
                    <span className="font-semibold text-primary/90">
                        {prof.highlight}:
                    </span>{' '}
                    <span>{prof.task.join(', ')}</span>
                </p>
            ))}
        </div>
    )
}
