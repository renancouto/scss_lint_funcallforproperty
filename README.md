# Function Call for Property
> A custom linter for [SCSS-Lint](https://github.com/brigade/scss-lint/) that checks if function calls are being used instead of literals.

## Installation

  1. Clone this repo

  2. And add its path to `plugin_directories`:

    ```yml
    # SCSS-Lint configuration file
    plugin_directories: ['./scss_lint_funcallforproperty']
    ```

## Configuration

This plugin is **disabled by default**.

The configuration works the same way as the default [VariableForProperty plugin](https://github.com/brigade/scss-lint/blob/master/lib/scss_lint/linter/README.md#variableforproperty). So you can configure like this:

```yml
# SCSS-Lint configuration file
linters:
  FuncallForProperty:
    enabled: true
    properties:
      - z-index
```

The examples below show how SCSS-Lint behaves with that configuration:

#### :disappointed: Bad
```scss
div {
  z-index: 100;
}
```

#### :smile: Good
```scss
div {
  z-index: map-get($depth-map, 'highest');
}
```

Note that values like `currentColor`, `inherit`, `initial`, and `transparent` will not be reported, as they are special kinds of values that convey additional meaning.

Configuration Option | Description
---------------------|----------------------------------
`properties`         | Array of property names to check

## License

This project is released under the [MIT license](LICENSE).

## Author

Renan Couto
