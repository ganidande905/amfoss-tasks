
import os
import discord
from discord.ext import commands
from dotenv import load_dotenv
from scrapper import scrape_live_scores

load_dotenv()
DISCORD_TOKEN = os.getenv('DISCORD_TOKEN')

intents = discord.Intents.default()
intents.message_content = True
bot = commands.Bot(command_prefix='/', intents=intents)

@bot.command(name='livescore')
async def get_live_score(ctx):
    live_scores = scrape_live_scores()
    await ctx.send(f"Team 1: {live_scores['team1']}\nTeam 2: {live_scores['team2']}\nOvers: {live_scores['overs']}")
@bot.command(name='summary')
async def get_live_score(ctx):
    live_scores = scrape_live_scores()
    await ctx.send(f"Summary: {live_scores['summary']}")
@bot.command(name='teams')
async def get_live_score(ctx):
    live_scores = scrape_live_scores()
    await ctx.send(f"Team 1: {live_scores['team1']}\nTeam 2: {live_scores['team2']}")
@bot.command(name='bot_help')
async def get_bot_help(ctx):
    help_message = "/livescore - Get live feed on the crux of the match.\n" \
                   "/summary - Get the summary of the match.\n"
    await ctx.send(help_message)

bot.run(DISCORD_TOKEN)
