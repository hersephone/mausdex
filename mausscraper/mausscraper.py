# Import required modules
from lxml import html
import requests
mode = 0
url = 'https://rk9.gg/teamlist/public/LA02wmhcWKPq3P8MHq4H/uYgHC4ws9qMQsUNIbINq'
page = requests.get(url)
buyers = ""
  
# Parsing the page
# (We need to use page.content rather than 
# page.text because html.fromstring implicitly
# expects bytes as input.)
tree = html.fromstring(page.content)

#pkmn1
for x in range (1, 7):
    #event name
    buyers += tree.xpath('//*[@id="content"]/div/div[1]/h4')[0].text_content().strip() + ","
    #pokemon name
    buyers += str(tree.xpath('/html/body/div[1]/div/div[4]/div[' + str(x) + ']/text()[2]')[0]).strip() + ","
    #tera type
    buyers += str(tree.xpath('/html/body/div[1]/div/div[4]/div[' + str(x) + ']/text()[5]')[0]).strip() + ","
    #ability name
    buyers += str(tree.xpath('/html/body/div[1]/div/div[4]/div[' + str(x) + ']/text()[7]')[0]).strip() + ","
    #item name
    buyers += str(tree.xpath('/html/body/div[1]/div/div[4]/div[' + str(x) + ']/text()[8]')[0]).strip() + ","
    #move1 name
    buyers += tree.xpath('//*[@id="lang-EN"]/div[' + str(x) + ']/h5/span[1]')[0].text_content().strip() + ","
    #move2 name
    buyers += tree.xpath('//*[@id="lang-EN"]/div[' + str(x) + ']/h5/span[2]')[0].text_content().strip() + ","
    #move3 name
    buyers += tree.xpath('//*[@id="lang-EN"]/div[' + str(x) + ']/h5/span[3]')[0].text_content().strip() + ","
    #move4 name
    buyers += tree.xpath('//*[@id="lang-EN"]/div[' + str(x) + ']/h5/span[4]')[0].text_content().strip() + "\n"

with open("output.txt", "w") as f:
  f.write(buyers)
