import os
import json

def setupCron():
  envs = json.loads(os.getenv('__CRON') or '[]')
  crontab = open('/run/liara/crontab', 'w+')

  for i in range(len(envs)):
    crontab.write(envs[i] + '\n')

  crontab.close()

setupCron()
