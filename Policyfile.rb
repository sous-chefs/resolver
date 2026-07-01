# frozen_string_literal: true

name 'resolver'

run_list 'recipe[resolver-test::test_packages]', 'recipe[resolver-test::default]'

cookbook 'resolver', path: '.'
cookbook 'resolver-test', path: './test/integration/cookbooks/resolver-test'

Dir.children('./test/integration/cookbooks/resolver-test/recipes').grep(/\.rb\z/).sort.each do |recipe|
  recipe_name = File.basename(recipe, '.rb')

  named_run_list recipe_name.to_sym, 'resolver-test::' + recipe_name
end
