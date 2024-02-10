import requests
from bs4 import BeautifulSoup

url = "https://www.espncricinfo.com/live-cricket-score"

try:
    response = requests.get(url)
    response.raise_for_status()  # Raise an HTTPError for bad responses (4xx or 5xx)

    soup = BeautifulSoup(response.text, 'html.parser')

    team1_name = soup.find('span', class_='ds-flex ds-items-center ds-min-w-0 ds-mr-1')
    team2_name = soup.find('span', class_='ds-flex ds-items-center ds-min-w-0 ds-mr-1')
    team1_score = soup.find('span', class_='ds-text-compact-s ds-text-typo ds-text-right ds-whitespace-nowrap fadeIn-exit-done')
    team2_score = soup.find('span', class_='s-text-compact-s ds-text-typo ds-text-right ds-whitespace-nowrap fadeIn-exit-done')
    match_summary = soup.find('div', class_='ds-text-tight-s ds-font-regular ds-truncate ds-text-typo')

    if team1_name and team2_name and team1_score and team2_score and match_summary:
        print(f"Team 1: {team1_name.text.strip()} {team1_score.text.strip()}")
        print(f"Team 2: {team2_name.text.strip()} {team2_score.text.strip()}")
        print(f"Match Summary: {match_summary.text.strip()}")
    else:
        print("One or more elements not found. Check class names or HTML structure.")

except requests.exceptions.RequestException as e:
    print(f"Failed to fetch the ESPN Cricket webpage. Error: {e}")

