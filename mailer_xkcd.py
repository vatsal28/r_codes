#Downloading from xkcd
from bs4 import BeautifulSoup
import requests, os, bs4, shutil
import smtplib
import os
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.mime.multipart import MIMEMultipart

url = "http://xkcd.com"
res = requests.get(url)
#res.raise_for_status()
soup = bs4.BeautifulSoup(res.text)

link = soup.select('#comic img')
comicURL = 'http:'+link[0].get('src')
response = requests.get(comicURL,stream = 'TRUE')
subject = link[0].get('alt')

with open('img.png','wb') as out_file:
	shutil.copyfileobj(response.raw, out_file)
del response

##Sending the downloaded image to mail 
msgRoot = MIMEMultipart('related')
recipients = ['vatsal.mishra@mu-sigma.com']
bcc = ['adit.patel@mu-sigma.com', 'gautam.ganapathy@mu-sigma.com','abhishek.gharal@mu-sigma.com','akilesh.r@mu-sigma.com']
msgRoot['Bcc'] = ", ".join(bcc)
msgRoot['Subject'] = str(subject)
msgRoot['From'] = 'John Doe'
msgRoot['To'] = ", ".join(recipients)
msgRoot.preamble = 'This is a multi-part message in MIEM format'

msgAlternative = MIMEMultipart('alternative')
msgRoot.attach(msgAlternative)

#msgText = MIMEText('This is the alternative plain text message.')
#msgAlternative.attach(msgText)

msgText = MIMEText('<b> Your daily XKCD comic:<img src="cid:image1"><br>This is a bot.Version 1.0', 'html')
msgAlternative.attach(msgText)

fp = open('img.png', 'rb')
msgImage = MIMEImage(fp.read())
fp.close()

#Define the image's ID as referenced above
msgImage.add_header('Content-ID', '<image1>')
msgRoot.attach(msgImage)

## Send the email (this example assumes SMTP authentication is required)

smtp = smtplib.SMTP('smtp.gmail.com:587')
smtp.ehlo()
smtp.starttls()
smtp.ehlo()
smtp.login('jubileecof@gmail.com', 'jubileecof1234')
smtp.sendmail('jubileecof@gmail.com', recipients+bcc, msgRoot.as_string())
smtp.quit()




