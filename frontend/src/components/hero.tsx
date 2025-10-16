import { siteConfig } from '@/config/site.config'
import { portfolioConfig } from '@/config/portfolio.config'
import { Socials } from '@/components/socials'
import Counter from './counter'
import Link from 'next/link'
import ThemeToggler from '@/components/theme/theme-toggler'
import { Button } from '@/components/ui/button'
import { Rss } from 'lucide-react'
import { skillsConfig } from '@/config/skills.config'
import { profesHighlights } from '@/config/profesional.highlights'

export default function Hero() {
    return (
        <section className="w-full flex flex-col lg:min-h-[calc(100vh-7rem)]">
            <Link href="/">
                <span className="font-mono text-sm underline">
                    {siteConfig.name}
                </span>
            </Link>
            <div className="flex justify-between items-center mt-6">
                <h1 className="head-text-sm">{portfolioConfig.name}</h1>
                <div className="flex items-center gap-2">
                    <Counter />
                    <Button
                        size="icon"
                        variant="ghost"
                        className="rounded-full"
                        asChild
                    >
                        <Link href="/feed">
                            <Rss size={18} />
                            <span className="sr-only">rss feed</span>
                        </Link>
                    </Button>

                    {/* <ThemeToggler /> */}
                </div>
            </div>
            <h2 className="mt-2 text-lg font-semibold ">
                {portfolioConfig.tagline}{' '}
                <span className="sr-only">tagline</span>
            </h2>
            <p className="my-2 max-w-2xl text-foreground/80">
                I build and operate highly available, cost efficient systems on
                AWS, turning complex infrastructure into repeatable, automated
                workflows that accelerate delivery and lower risk.
            </p>
            <Socials />
            <div className="hidden lg:flex flex-col text-sm space-y-2 rounded max-w-2xl text-foreground/70 my-7">
                <h2 className="text-lg text-foreground font-bold underline">
                    Tools & Certifications
                </h2>
                
                    {skillsConfig.map((skill) => (
                        <span key={skill.category}>
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
                        </span>
                    ))}
                
                <h2 className="text-lg text-foreground font-bold underline">
                    Professional Highlights
                </h2>
                {profesHighlights.map((prof) => (
                    <span key={prof.highlight}>
                        <span className="font-semibold text-primary/90">
                            {prof.highlight}:
                        </span>{' '}
                        <span>{prof.task.join(', ')}</span>
                    </span>
                ))}
            </div>
        </section>
    )
}
