# https://stackoverflow.com/questions/67631/how-to-import-a-module-given-the-full-path

import sys
import importlib
import importlib.util

module_name = sys.argv[1].replace('/', '.')
module_path = '/usr/src/app/' + sys.argv[1]

spec = importlib.util.spec_from_file_location(module_name, module_path)

mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)

[part1, part2, app] = mod.WSGI_APPLICATION.split('.')

print(part1 + '.' + part2 + ':' + app)
