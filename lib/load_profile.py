import os
import json

def setupCron():
  cron = os.getenv('__CRON') or '[]'
  crontab = open('/run/liara/crontab', 'w+')

  try:
    envs = json.loads(cron)
  except ValueError:
    envs = cron.split('$__SEP')

  for i in range(len(envs)):
    crontab.write(envs[i] + '\n')

  crontab.close()

setupCron()
