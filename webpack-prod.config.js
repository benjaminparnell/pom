const path = require('path')
const ClosureCompiler = require('google-closure-compiler-js').webpack

module.exports = {
  entry: {
    app: [
      './src/index.js'
    ]
  },

  output: {
    path: path.join(__dirname, '/dist'),
    filename: '[name].js'
  },

  plugins: [
    new ClosureCompiler({})
  ],

  module: {
    rules: [
      {
        test: /\.(css|scss)$/,
        use: [
          'style-loader',
          'css-loader'
        ]
      },

      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file-loader?name=[name].[ext]'
      },

      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader?verbose=true&warn=true'
      },

      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?limit=10000&mimetype=application/font-woff'
      },

      {
        test: /\.(ttf|eot|svg|mp3)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader'
      }
    ],

    noParse: /\.elm$/
  },

  devServer: {
    inline: true,
    stats: { colors: true }
  }
}
