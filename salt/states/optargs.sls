{%- set is_test = salt['config.get']('test') %}

{%- set args_seen_by_runner = salt['publish.runner']('optargs.test_arg', ['keyword_arg1=1', 'keyword_arg2=2', 'test={}'.format(is_test)]) %}
{%- set args_seen_by_runner_workaround = salt['publish.runner']('optargs.test_workaround', ['keyword_arg1=1', 'keyword_arg2=2', 'test={}'.format(salt['config.get']('test'))]) %}

config.get check for is_test:
  cmd.run:
    - name: echo '{{ is_test }}'

opts.get check for test:
  cmd.run:
    - name: echo '{{ opts.get('test') }}'

runner check for test:
  cmd.run:
    - name: "echo {{ args_seen_by_runner|yaml }}"

runner check for test workaround:
  cmd.run:
    - name: "echo {{ args_seen_by_runner_workaround|yaml }}"
