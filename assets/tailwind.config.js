// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  darkMode: 'class',
  content: [
    "./js/**/*.js",
    "../lib/*_web.ex",
    "../lib/*_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        /* =~= Theme Colors  =~= */
        /* primary | #61afef */
        "surface-50": "rgb(223 223 225)", /* ⬅ #dfdfe1 */
        "surface-100": "rgb(212 213 214)", /* ⬅ #d4d5d6 */
        "surface-200": "rgb(201 202 204)", /* ⬅ #c9cacc */
        "surface-300": "rgb(169 171 174)", /* ⬅ #a9abae */
        "surface-400": "rgb(105 107 113)", /* ⬅ #696b71 */
        "surface-500": "rgb(40 44 52)", /* ⬅ #282c34 */
        "surface-600": "rgb(36 40 47)", /* ⬅ #24282f */
        "surface-700": "rgb(30 33 39)", /* ⬅ #1e2127 */
        "surface-800": "rgb(24 26 31)", /* ⬅ #181a1f */
        "surface-900": "rgb(20 22 25)", /* ⬅ #141619 */

        "primary-50": "rgb(231 243 253)", /* ⬅ #e7f3fd */
        "primary-100": "rgb(223 239 252)", /* ⬅ #dfeffc */
        "primary-200": "rgb(216 235 251)", /* ⬅ #d8ebfb */
        "primary-300": "rgb(192 223 249)", /* ⬅ #c0dff9 */
        "primary-400": "rgb(144 199 244)", /* ⬅ #90c7f4 */
        "primary-500": "rgb(97 175 239)", /* ⬅ #61afef */
        "primary-600": "rgb(87 158 215)", /* ⬅ #579ed7 */
        "primary-700": "rgb(73 131 179)", /* ⬅ #4983b3 */
        "primary-800": "rgb(58 105 143)", /* ⬅ #3a698f */
        "primary-900": "rgb(48 86 117)", /* ⬅ #305675 */

        "secondary-50": "rgb(246 235 250)", /* ⬅ #f6ebfa */
        "secondary-100": "rgb(244 228 248)", /* ⬅ #f4e4f8 */
        "secondary-200": "rgb(241 221 247)", /* ⬅ #f1ddf7 */
        "secondary-300": "rgb(232 201 241)", /* ⬅ #e8c9f1 */
        "secondary-400": "rgb(215 161 231)", /* ⬅ #d7a1e7 */
        "secondary-500": "rgb(198 120 221)", /* ⬅ #c678dd */
        "secondary-600": "rgb(178 108 199)", /* ⬅ #b26cc7 */
        "secondary-700": "rgb(149 90 166)", /* ⬅ #955aa6 */
        "secondary-800": "rgb(119 72 133)", /* ⬅ #774885 */
        "secondary-900": "rgb(97 59 108)", /* ⬅ #613b6c */
        /* tertiary | #56b6c2 */
        "tertiary-50": "rgb(230 244 246)", /* ⬅ #e6f4f6 */
        "tertiary-100": "rgb(221 240 243)", /* ⬅ #ddf0f3 */
        "tertiary-200": "rgb(213 237 240)", /* ⬅ #d5edf0 */
        "tertiary-300": "rgb(187 226 231)", /* ⬅ #bbe2e7 */
        "tertiary-400": "rgb(137 204 212)", /* ⬅ #89ccd4 */
        "tertiary-500": "rgb(86 182 194)", /* ⬅ #56b6c2 */
        "tertiary-600": "rgb(77 164 175)", /* ⬅ #4da4af */
        "tertiary-700": "rgb(65 137 146)", /* ⬅ #418992 */
        "tertiary-800": "rgb(52 109 116)", /* ⬅ #346d74 */
        "tertiary-900": "rgb(42 89 95)", /* ⬅ #2a595f */
        /* success | #98c379 */
        "success-50": "rgb(240 246 235)", /* ⬅ #f0f6eb */
        "success-100": "rgb(234 243 228)", /* ⬅ #eaf3e4 */
        "success-200": "rgb(229 240 222)", /* ⬅ #e5f0de */
        "success-300": "rgb(214 231 201)", /* ⬅ #d6e7c9 */
        "success-400": "rgb(183 213 161)", /* ⬅ #b7d5a1 */
        "success-500": "rgb(152 195 121)", /* ⬅ #98c379 */
        "success-600": "rgb(137 176 109)", /* ⬅ #89b06d */
        "success-700": "rgb(114 146 91)", /* ⬅ #72925b */
        "success-800": "rgb(91 117 73)", /* ⬅ #5b7549 */
        "success-900": "rgb(74 96 59)", /* ⬅ #4a603b */
        /* warning | #e5c07b */
        "warning-50": "rgb(251 246 235)", /* ⬅ #fbf6eb */
        "warning-100": "rgb(250 242 229)", /* ⬅ #faf2e5 */
        "warning-200": "rgb(249 239 222)", /* ⬅ #f9efde */
        "warning-300": "rgb(245 230 202)", /* ⬅ #f5e6ca */
        "warning-400": "rgb(237 211 163)", /* ⬅ #edd3a3 */
        "warning-500": "rgb(229 192 123)", /* ⬅ #e5c07b */
        "warning-600": "rgb(206 173 111)", /* ⬅ #cead6f */
        "warning-700": "rgb(172 144 92)", /* ⬅ #ac905c */
        "warning-800": "rgb(137 115 74)", /* ⬅ #89734a */
        "warning-900": "rgb(112 94 60)", /* ⬅ #705e3c */
        /* error | #e06c75 */
        "error-50": "rgb(250 233 234)", /* ⬅ #fae9ea */
        "error-100": "rgb(249 226 227)", /* ⬅ #f9e2e3 */
        "error-200": "rgb(247 218 221)", /* ⬅ #f7dadd */
        "error-300": "rgb(243 196 200)", /* ⬅ #f3c4c8 */
        "error-400": "rgb(233 152 158)", /* ⬅ #e9989e */
        "error-500": "rgb(224 108 117)", /* ⬅ #e06c75 */
        "error-600": "rgb(202 97 105)", /* ⬅ #ca6169 */
        "error-700": "rgb(168 81 88)", /* ⬅ #a85158 */
        "error-800": "rgb(134 65 70)", /* ⬅ #864146 */
        "error-900": "rgb(110 53 57)", /* ⬅ #6e3539 */
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({ addVariant }) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Hero Icons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function ({ matchComponents, theme }) {
      let iconsDir = path.join(__dirname, "./vendor/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).map(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = { name, fullPath: path.join(iconsDir, dir, file) }
        })
      })
      matchComponents({
        "hero": ({ name, fullPath }) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": theme("spacing.5"),
            "height": theme("spacing.5")
          }
        }
      }, { values })
    })
  ]
}
