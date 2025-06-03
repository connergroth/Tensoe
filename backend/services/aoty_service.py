import httpx
from typing import Optional, Dict, Any, List
from app.config import AOTY_API_URL
from backend.aoty_api.app.scraper.aoty_scraper import get_album_url
from backend.utils.matching import find_best_match, clean_title

# Simple in-memory cache
_album_cache = {}

async def get_cached_album(cache_key: str) -> Optional[Dict[str, Any]]:
    """Get album data from cache if available."""
    return _album_cache.get(cache_key)

async def cache_album_data(cache_key: str, data: Dict[str, Any]) -> None:
    """Store album data in cache."""
    _album_cache[cache_key] = data

class AOTYService:
    def __init__(self, base_url=AOTY_API_URL):
        self.base_url = base_url
        self.client = httpx.AsyncClient(timeout=30.0)
    
    async def close(self):
        await self.client.aclose()
    
    async def get_album(self, artist: str, album: str) -> Optional[Dict[str, Any]]:
        """Fetch album data from AOTY API with caching."""
        # Generate a cache key
        cache_key = f"{artist}:{album}".lower().replace(" ", "-")
        
        # Check cache first
        cached_data = await get_cached_album(cache_key)
        if cached_data:
            return cached_data
        
        # Fetch from API if not in cache
        try:
            response = await self.client.get(
                f"{AOTY_API_URL}/album/",
                params={"artist": artist, "album": album}
            )
            response.raise_for_status()
            album_data = response.json()
            
            # Cache for future use
            await cache_album_data(cache_key, album_data)
            return album_data
        except httpx.HTTPStatusError as e:
            if e.response.status_code == 404:
                return None
            raise
        except Exception as e:
            print(f"Error fetching album data for {artist} - {album}: {str(e)}")
            return None
    
    async def get_similar_albums(self, artist: str, album: str, limit: int = 5) -> List[Dict[str, Any]]:
        """Fetch similar albums from AOTY API."""
        try:
            response = await self.client.get(
                f"{AOTY_API_URL}/album/similar/",
                params={"artist": artist, "album": album, "limit": limit}
            )
            response.raise_for_status()
            return response.json()
        except Exception as e:
            print(f"Error fetching similar albums for {artist} - {album}: {str(e)}")
            return []