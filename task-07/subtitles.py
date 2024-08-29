import click
import os
import requests
from bs4 import BeautifulSoup
import urllib.parse

@click.group()
def cli():
    pass

@cli.command()
@click.argument('movie_file', type=click.Path(exists=True))
@click.option('-l', '--language', type=str, help='Filter subtitles by language')
@click.option('-o', '--output', type=click.Path(exists=True), help='Specify the output folder for subtitles')
@click.option('-s', '--file-size', type=int, help='Filter subtitles by movie file size')
@click.option('-h', '--match-by-hash', type=bool, is_flag=True, help='Match subtitles by movie hash')
@click.option('-b', '--batch-download', type=bool, is_flag=True, help='Enable batch mode for directory')
def download_subtitles(movie_file, language, output, file_size, match_by_hash, batch_download):
    """Download subtitles for the specified movie file."""
    if batch_download:
        for root, dirs, files in os.walk(movie_file):
            for file in files:
                if file.endswith(('.mp4', '.mkv', '.avi')):
                    movie_path = os.path.join(root, file)
                    handle_subtitle_download(movie_path, language, output, file_size, match_by_hash)
    else:
        handle_subtitle_download(movie_file, language, output, file_size, match_by_hash)

def handle_subtitle_download(movie_file, language, output, file_size, match_by_hash):
    imdb_id, movie_hash, movie_size = get_movie_details(movie_file)
    if imdb_id:
        subtitles = scrape_subtitles(imdb_id, movie_hash, movie_size, language)

        if subtitles:
            click.echo("Available Subtitles:")
            for idx, subtitle in enumerate(subtitles):
                click.echo(f"{idx + 1}. {subtitle['title']} - Downloads: {subtitle['downloads']}")

            choice = click.prompt("Select a subtitle to download", type=int)
            chosen_subtitle = subtitles[choice - 1]
            download_subtitle(chosen_subtitle['url'], output)
        else:
            click.echo("No subtitles found matching the criteria.")
    else:
        click.echo("Failed to retrieve IMDb ID.")

def get_movie_details(movie_file):
    movie_hash = hash_movie(movie_file)  # Replace with actual hash computation
    movie_size = os.path.getsize(movie_file)  # Get file size in bytes
    imdb_id = get_imdb_id(movie_file)  # Get IMDb ID from movie name
    return imdb_id, movie_hash, movie_size

def hash_movie(movie_file):
    # Implement a real hash computation based on movie file contents
    return "dummy_hash"

def get_imdb_id(movie_file):
    movie_name = os.path.splitext(os.path.basename(movie_file))[0]  # Get movie name without extension
    api_key = 'your_omdb_api_key'  # Replace with your OMDb API key
    url = f"http://www.omdbapi.com/?t={urllib.parse.quote(movie_name)}&apikey=38f70ec3"
    
    response = requests.get(url)
    
    if response.status_code == 200:
        data = response.json()
        if data['Response'] == 'True':
            return data['imdbID']
        else:
            print(f"Error: {data['Error']}")
            return None
    else:
        print(f"Failed to retrieve IMDb ID, status code: {response.status_code}")
        return None

def scrape_subtitles(imdb_id, movie_hash, movie_size, language=None):
    url = f"https://www.opensubtitles.org/en/search/sublanguageid-{language or 'all'}/idmovie-{imdb_id}"
    print(f"Searching subtitles for IMDb ID: {imdb_id} at URL: {url}")

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36'
    }

    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        print(soup.prettify())  # Debugging: Prints the HTML content to verify it’s correct

        # Continue with parsing logic
        subtitle_options = []
        for subtitle in soup.find_all('a', class_='subtitles'):
            title = subtitle.get_text()
            download_url = subtitle['href']
            downloads = subtitle.find_next_sibling('span', class_='downloads').get_text()
            subtitle_options.append({
                'title': title,
                'url': download_url,
                'downloads': downloads
            })
        
        return subtitle_options
    else:
        print(f"Failed to retrieve subtitles, status code: {response.status_code}")
        return None

def download_subtitle(subtitle_url, output_dir):
    response = requests.get(subtitle_url)
    
    if response.status_code == 200:
        subtitle_filename = subtitle_url.split('/')[-1]
        subtitle_path = os.path.join(output_dir, subtitle_filename)
        
        with open(subtitle_path, 'wb') as subtitle_file:
            subtitle_file.write(response.content)
        
        click.echo(f"Downloaded: {subtitle_filename}")
    else:
        click.echo("Failed to download subtitle.")

cli.add_command(download_subtitles)

if __name__ == '__main__':
    cli()
