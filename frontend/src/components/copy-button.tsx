"use client";

import React, { useState } from "react";

export const CopyButton = ({ children }: { children: React.ReactNode }) => {
  const [isCopied, setIsCopied] = useState(false);

  const copy = async () => {
    const sourceCode = extractSourceCode(children);
    await navigator.clipboard.writeText(sourceCode);
    setIsCopied(true);

    setTimeout(() => {
      setIsCopied(false);
    }, 10000);
  };

  const extractSourceCode = (node: React.ReactNode): string => {
    if (typeof node === "string") {
      return node;
    }
  
    // Handle null, undefined, and boolean nodes, which render nothing.
    if (node === null || typeof node === "boolean" || typeof node === "undefined") {
      return "";
    }
  
    if (Array.isArray(node)) {
      return node.map(extractSourceCode).join("");
    }
  
    if (React.isValidElement(node)) {
      const { type, props } = node as React.ReactElement<any>;
      // Determine the tag name from the element's type.
      const tagName = typeof type === "string" ? type : type.name || "Component";
  
      // Recursively get the string representation of the children.
      const children = React.Children.map(
        props.children,
        extractSourceCode
      )?.join("");
  
      // Build the props string, making sure to exclude children.
      const propPairs = Object.entries(props)
        .filter(([key]) => key !== "children")
        .map(([key, value]) => {
          // Handle string props with quotes, which is standard for JSX.
          if (typeof value === "string") {
            return `${key}="${value}"`;
          }
          // For other types, wrap in curly braces.
          // Note: This is a simplification. Functions and complex objects won't serialize to valid, runnable JSX.
          return `${key}={${JSON.stringify(value)}}`;
        })
        .join(" ");
  
      const propsString = propPairs ? ` ${propPairs}` : "";
  
      // Handle self-closing tags for elements without children.
      if (!children) {
        return `<${tagName}${propsString} />`;
      }
  
      return `<${tagName}${propsString}>${children}</${tagName}>`;
    }
  
    return "";
  };

  return (
    <button disabled={isCopied} onClick={copy}>
      {isCopied ? "Copied!" : "Copy"}
    </button>
  );
};