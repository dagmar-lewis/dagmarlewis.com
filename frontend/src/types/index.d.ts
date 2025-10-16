export type Site = {
  name: string;
  title: string;
  description: string;
  siteUrl: string;
  theme: string
  creator: {
    name: string;
    url: string;
  }
  ogImage: string;
  links: {
    x: string;
    github: string;
  }
}

export type Portfolio = {
  name: string;
  tagline: string;
  links: {
    twitter: string;
    github: string;
    linkedin: string;
    mail: string;
    credly: string
  }
}

type defaultProfile = {
  name: string;
  url?: string;
  image?: string;
};

export type Experience = {
  title: string;
  employmentType: string;
  company: defaultProfile;
  location: defaultProfile;
  start: string;
  end: string;
  description: string[];
};

export type NavItem = {
  title: string;
  url: string;
}