import argparse
import smtplib
from email.mime.text import MIMEText

# Originally adapted from https://www.jianshu.com/p/690e79b43e00

if __name__ == "__main__":
  parser = argparse.ArgumentParser(
    description='Program for sending emails',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
  parser.add_argument('-s',
                      '--subject',
                      required=False,
                      default="program status")
  parser.add_argument('-c', '--content', required=False, default="finished")
  args = vars(parser.parse_args())

  mail_host = 'smtp.126.com'
  mail_username = 'fengyukun_blcu@126.com'
  mail_auth_password = ""

  sender = 'fengyukun_blcu@126.com'
  receivers = 'yukunfg@gmail.com'

  message = MIMEText(args['content'], 'plain', 'utf-8')
  message['From'] = sender
  message['To'] = receivers
  message['Subject'] = args['subject']

  try:
    smtpObj = smtplib.SMTP_SSL(mail_host, 465)
    smtpObj.login(mail_username, mail_auth_password)
    smtpObj.sendmail(sender, receivers, message.as_string())
    print("sending email succeeds")
  except smtplib.SMTPException:
    print("sending email failed")
