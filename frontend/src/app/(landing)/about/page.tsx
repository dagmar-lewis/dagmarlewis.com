import { skillsConfig } from "@/config/skills.config";


export default function Hero() {
  return (
      <section>
          <div className="p-2 flex flex-col gap-2">
              <div>
                  <h1 className="text-lg text-foreground font-bold underline">
                      About
                  </h1>
                  <p>Hi im Dagmar Lewis</p>
              </div>
              <div>
                  <h2 className="text-md text-foreground font-bold underline">
                      Tools & Certifications
                  </h2>
                  <div className="md:flex flex-col text-sm space-y-2 rounded max-w-2xl text-foreground/70 my-2">
                      {skillsConfig.map((skill) => (
                          <p key={skill.category}>
                              <span className="font-semibold text-primary/90">
                                  {skill.category}:
                              </span>{' '}
                              <a
                                  href={skill.link}
                                  className={skill.link ? 'underline' : ''}
                              >
                                  {skill.technologies.join(', ')}
                              </a>
                          </p>
                      ))}
                  </div>
              </div>
          </div>
      </section>
  )
}
