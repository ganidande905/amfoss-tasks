# scraper.py
import requests
from bs4 import BeautifulSoup

def scrape_live_scores():
    URL = "https://www.espncricinfo.com/live-cricket-score"
    page = requests.get(URL)
    soup = BeautifulSoup(page.content, "html.parser")
    
    team1 = soup.find('p', class_='ds-text-tight-m ds-font-bold ds-capitalize ds-truncate').text
    team2 = soup.find('div', class_='ds-flex ds-items-center ds-min-w-0 ds-mr-1').text
    overs = soup.find('span', class_='ds-text-compact-xs ds-mr-0.5').text
    summary = soup.find('p', class_='ds-text-tight-s ds-font-regular ds-truncate ds-text-typo').text

    return {'team1': team1, 'team2': team2, 'over': overs, 'summary': summary}

