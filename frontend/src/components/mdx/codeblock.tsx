import { CopyButton } from "@/components/copy-button";
import { cn } from "@/lib/utils";

export const CodeBlock = ({
  children,
  className,
  ...props
}: React.HTMLAttributes<HTMLPreElement>) => {
  return (
      <div className="mb-4 mt-6 relative rounded-lg font-mono text-sm">
          <div className="flex justify-end py-1 pr-3 backdrop-filter backdrop-blur-3xl  drop-shadow-sm backdrop-saturate-150 bg-neutral-800  text-gray-200 rounded-t-lg">
              <CopyButton>{children}</CopyButton>
          </div>
          <pre
              className={cn(
                  'overflow-x-auto text-pretty py-4 backdrop-filter backdrop-blur-3xl rounded-b-xl drop-shadow-sm backdrop-saturate-150 bg-neutral-900 bg-opacity-70',
                  className
              )}
              {...props}
          >
              <code>{children}</code>
          </pre>
      </div>
  )
};

