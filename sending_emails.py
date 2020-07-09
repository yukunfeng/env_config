import smtplib
from email.mime.text import MIMEText

mail_host = 'smtp.126.com'            
mail_username = 'fengyukun_blcu@126.com'
mail_auth_password = "*"     
 
#  sender = mail_username
sender = 'fengyukun_blcu@126.com'
receivers = 'yukunfg@gmail.com'
#  receivers = '270114497@qq.com, zhenghaishu@126.com' # multiple receivers
 
message = MIMEText('finished', 'plain', 'utf-8')
message['From'] = sender
message['To'] =  receivers
message['Subject'] = "program status"
 
try:
    #  smtpObj = smtplib.SMTP(mail_host, 25)                               # 生成smtpObj对象，使用非SSL协议端口号25
    smtpObj = smtplib.SMTP_SSL(mail_host, 465)                         # 生成smtpObj对象，使用SSL协议端口号465
    smtpObj.login(mail_username, mail_auth_password)                    # 登录邮箱
    smtpObj.sendmail(sender, receivers, message.as_string())          # one receiver
    #  smtpObj.sendmail(sender, receivers.split(','), message.as_string()) # #  multiple receivers
    print ("sending email succeeds")
except smtplib.SMTPException:
    print ("sending email failed")
