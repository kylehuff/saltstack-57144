#!/usr/bin/enn python

def test_workaround(*args, **kwargs):
  test = list(filter(lambda v: v[0] == 'test', map(lambda arg: arg.split('='), __opts__.get('argv', []))))
  if len(test) > 0 and len(test[0]) > 0:
    test = test[0][1]
  else:
    test = kwargs.get('test', False)
  return test

def test_arg(*args, **kwargs):
  """ test arguments. """
  ret = {
    'kwargs': kwargs,
    '__opts__.test': __opts__.get('test'),
    '__opts__.argv': __opts__.get('argv'),
  }
  return ret
