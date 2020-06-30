import os

def setupCron():
  cron = os.getenv('__CRON')
  cron_file = open('/etc/cron.d/liara_cron', 'w+')

  if not cron:
    cron_file.close()
    return

  envs = cron.split('$__SEP') if cron else []

  cron_file.write('PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\n')
  cron_file.write('ROOT=/usr/src/app\n')

  for i in range(len(envs)):
    cron_file.write(envs[i] + '\n')

  cron_file.close()

setupCron()
