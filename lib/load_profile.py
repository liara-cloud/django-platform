import os
import json

def setupCron():
  cron = os.getenv('__CRON') or '[]'
  crontab = open('/run/liara/crontab', 'w+')

  if '$__SEP' in cron:
    envs = cron.split('$__SEP')
  else:
    envs = json.loads(cron)

  for i in range(len(envs)):
    crontab.write(envs[i] + '\n')

  crontab.close()

setupCron()
