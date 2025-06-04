import { themes as prismThemes } from 'prism-react-renderer';
import type { Config } from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'My Site',
  tagline: 'Dinosaurs are cool',
  favicon: 'img/favicon.png',

  future: {
    v4: true,
    experimental_faster: true,
  },

  url: 'https://wplytic.com',
  baseUrl: '/docs/',
  trailingSlash: true,

  organizationName: 'WPLytic',
  projectName: 'WPLytic Docs',

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          routeBasePath: '/',
          sidebarPath: './sidebars.ts',
          editUrl:
            'https://github.com/WPLytic/docs/tree/main/',
        },
        blog: false,
        pages: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themes: [
    [
      require.resolve('@easyops-cn/docusaurus-search-local'),
      {
        hashed: true,
        indexBlog: false,
        indexPages: false,
        language: ['en'],
        docsRouteBasePath: "/",
      },
    ],
  ],

  themeConfig: {
    image: 'img/docusaurus-social-card.jpg',
    navbar: {
      title: 'WPLytic - WordPress Analytics Plugin Docs',
      logo: {
        alt: 'WPLytic Logo',
        src: 'img/logo.png',
      },
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'defaultSidebar',
          position: 'left',
          label: 'Docs',
        },
        {
          href: 'https://wplytic.com/#pricing',
          label: 'Pricing',
          position: 'right',
        },
        {
          type: 'search',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Home',
              to: '/',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'X',
              href: 'https://x.com/WPLytic',
            },
            {
              label: 'Facebook',
              href: 'https://facebook.com/WPLytic',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'Website',
              href: 'https://wplytic.com?ref=docs',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} WPLytic.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
