# CryptoTracker-SwiftUI

iOS application built with Swift and SwiftUI that displays cryptocurrency data from the CoinGecko API.

The project follows MVVM architecture and includes pagination (lazy loading of coins) along with caching for images and coin details to improve performance and provide a smooth user experience.

---

## Features

- Real-time cryptocurrency data from CoinGecko API  
- Clean MVVM architecture  
- Pagination with lazy loading (50 coins per batch)  
- Detail screen for each cryptocurrency  
- Image caching for improved performance  
- Data caching to reduce redundant network calls  
- Smooth and responsive SwiftUI UI  

---

## Performance Optimizations

- Pagination to reduce initial load time  
- Image caching to avoid unnecessary downloads  
- Cached coin data to minimize API requests  

---

## API

Data is fetched from:  
[CoinGecko API](https://www.coingecko.com/en/api)

---

## Tech Stack

- Swift  
- SwiftUI  
- URLSession  
- MVVM Architecture  

---

## Notes

This project was built as a learning exercise to deepen understanding of SwiftUI, networking, and scalable architecture design.
