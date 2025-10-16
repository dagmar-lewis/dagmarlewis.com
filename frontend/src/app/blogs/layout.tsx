import type { Metadata } from "next/types";
import { siteConfig } from "@/config/site.config";

export const metadata: Metadata = {
    title: `Blogs | ${siteConfig.name}`,
    description:
        'Blogs | Hey! I’m Dagmar Lewis, a Cloud & DevOps Professional. My blog is a mix of hands on tutorials on AWS, Terraform, Docker, observability, and my home lab experiments',

    // Open Graph metadata
    openGraph: {
        title: `Blogs | ${siteConfig.name}`,
        description:
            'Blogs | Hey! I’m Dagmar Lewis, a Cloud & DevOps Professional. My blog is a mix of hands on tutorials on AWS, Terraform, Docker, observability, and my home lab experiments.Happy reading!',
        url: `${siteConfig.siteUrl}/blogs`,
        siteName: siteConfig.name,
        images: [
            {
                url: `${siteConfig.siteUrl}/blog-og.png`,
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
        title: `Blogs | ${siteConfig.name}`,
        description:
            'Blogs | Hey! I’m Dagmar Lewis, a Cloud & DevOps Professional. My blog is a mix of hands on tutorials on AWS, Terraform, Docker, observability, and my home lab experiments.Happy reading!',
        images: {
            url: `${siteConfig.siteUrl}/blog-og.png`,
            width: 1800,
            height: 1000,
            alt: `Blogs | ${siteConfig.name}`,
        },
    },
}

export default function BlogLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <main className="w-full">
      <section>{children}</section>
    </main>
  );
}
