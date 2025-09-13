import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Actual Build",
  description: "Full Stack Development Environment",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="antialiased">
        {children}
      </body>
    </html>
  );
}
