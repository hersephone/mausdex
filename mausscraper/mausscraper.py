# Import required modules
from lxml import html
import requests
mode = 0

page = requests.get('https://rk9.gg/teamlist/public/BA02mLVeF4Ne522zgw2g/TREYi2rrNL5x1tmwq9uJ')
  
# Parsing the page
# (We need to use page.content rather than 
# page.text because html.fromstring implicitly
# expects bytes as input.)
tree = html.fromstring(page.content)
  
# Get element using XPath
buyers = str(tree.xpath('//*[@id="lang-EN"]/div[1]/text()[2]'))
start = 0
end = -1
for x in range (0, len(buyers)):
    if buyers[x].isupper():
        start = x
        break
for x in range (start, len(buyers)):
    if buyers[x] == "\\":
        end = x
        break
print (buyers[start:end])
