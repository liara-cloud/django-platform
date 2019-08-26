import sys
import importlib

mod = importlib.import_module(sys.argv[1].replace('/', '.'))

[part1, part2, app] = mod.WSGI_APPLICATION.split('.')

print(part1 + '.' + part2 + ':' + app)
