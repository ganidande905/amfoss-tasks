import os
import discord
from discord.ext import commands
from dotenv import load_dotenv
import requests
from bs4 import BeautifulSoup
import csv
from datetime import datetime

# Load environment variables
load_dotenv()
DISCORD_TOKEN = os.getenv('DISCORD_TOKEN')
# Define the intents
intents = discord.Intents.default()
intents.all()

# Set up the Discord bot with intents
bot = commands.Bot(command_prefix='/', intents=intents)

# Define scraping function
def scrape_live_scores():
    url = "https://www.espncricinfo.com/live-cricket-score"
    response = requests.get(url)

    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')

        # Check if the required elements are present
        team1_element = soup.find('span', class_='ds-flex ds-items-center ds-min-w-0 ds-mr-1')
        team2_element = soup.find('span', class_='ds-flex ds-items-center ds-min-w-0 ds-mr-1')

        if team1_element and team2_element:
            team1_name = team1_element.text.strip()
            team2_name = team2_element.text.strip()

            # Add similar checks for other elements you want to extract

            # Use the extracted information to build the live score message
            live_score_message = f"Team 1: {team1_name}\nTeam 2: {team2_name}\n"

            return live_score_message

    # If the required elements are not found, return an appropriate message
    return "No live scores available! Try again later."
# Define bot commands
@bot.command(name='livescore', help='Get live feed on the crux of the match.')
async def get_live_score(ctx):
    live_score = scrape_live_scores()
    await ctx.send(live_score)

@bot.command(name='generate', help='Get the CSV file containing live scores and timestamps.')
async def generate_csv(ctx):
    # Add logic to send the CSV file
    await ctx.send("CSV file generation functionality coming soon!")

# Change the name of your custom help command from /help to /bot_help
@bot.command(name='bot_help', help='Get a list of commands along with their description.')
async def get_bot_help(ctx):
    help_message = "/livescore - Get live feed on the crux of the match.\n" \
                   "/generate - Get the CSV file containing live scores and timestamps.\n" \
                   "/bot_help - Get a list of commands along with their description."
    await ctx.send(help_message)


# Run the bot
bot.run(DISCORD_TOKEN)
