module.exports = {
  mode: 'jit',
  purge: {
    content: [
      './app/**/*.html.erb',
      './app/components/**/*.rb',
      './app/helpers/**/*.rb',
      './app/javascript/**/*.js',
      './postcss.safelist.txt'
      // Add any other JS files here (i.e. .jsx, .ts, etc...)
    ],
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}
