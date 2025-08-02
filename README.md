# dagmarlewis.com

This is the repository for my personal portfolio website, [dagmarlewis.com](https://dagmarlewis.com). It's built with Next.js and deployed on AWS.

## Tech Stack

- **Framework:** [Next.js](https://nextjs.org/)
- **Styling:** [Tailwind CSS](https://tailwindcss.com/)
- **Content:** [MDX](https://mdxjs.com/) with [Velite](https://velite.js.org/)
- **Deployment:** [AWS](https://aws.amazon.com/) with [Terraform](https://www.terraform.io/) and [GitHub Actions](https://github.com/features/actions)

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- [Bun](https://bun.sh/)

### Installation

1.  Clone the repo
    ```sh
    git clone https://github.com/dagmarlewis/dagmarlewis.com.git
    ```
2.  Navigate to the `frontend` directory
    ```sh
    cd frontend
    ```
3.  Install NPM packages
    ```sh
    bun install
    ```
4.  Run the development server
    ```sh
    bun run dev
    ```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Deployment

The website is automatically deployed to AWS whenever changes are pushed to the `main` branch. The deployment pipeline is defined in the `.github/workflows` directory and uses Terraform to manage the infrastructure.

## Project Structure

```
.
├── .github/            # GitHub Actions workflows
├── frontend/           # Next.js application
│   ├── content/        # MDX content for blog posts, projects, etc.
│   ├── public/         # Static assets
│   └── src/            # Source code
│       ├── app/        # App router
│       ├── components/ # React components
│       ├── config/     # Site configuration
│       ├── lib/        # Utility functions and hooks
│       └── styles/     # Global styles
└── ops/                # Operations and infrastructure
    ├── scripts/        # Deployment scripts
    └── terraform/      # Terraform configuration
```