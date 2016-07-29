module SCSSLint
  # Reports the use of literals for properties where function calls are prefered.
  # Based of VariableForProperty
  class Linter::FuncallForProperty < Linter
    include LinterRegistry

    IGNORED_VALUES = %w[currentColor inherit initial transparent].freeze

    def visit_root(_node)
      @properties = Set.new(config['properties'])
      yield if @properties.any?
    end

    def visit_prop(node)
      property_name = node.name.join
      return unless @properties.include?(property_name)
      return if ignored_value?(node.value)
      return if node.children.first.is_a?(Sass::Script::Tree::Funcall)
      return if variable_property_with_important?(node.value)

      add_lint(node, "Property #{property_name} should use " \
                     'a function call rather than a literal value')
    end

  private

    def variable_property_with_important?(value)
      value.is_a?(Sass::Script::Tree::ListLiteral) &&
        value.children.length == 2 &&
        value.children.first.is_a?(Sass::Script::Tree::Variable) &&
        value.children.last.value.value == '!important'
    end

    def ignored_value?(value)
      value.respond_to?(:value) &&
        IGNORED_VALUES.include?(value.value.to_s)
    end
  end
end
