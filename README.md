# iOS Lyrics game based on Musixmatch API

A simple game based of Musixmatch's API for iOS 7 and above; tested for iPhone 5/6/6s screen settings.

Chose a song and try to select the words in the correct sequence in the minor time possible.
This is a simple test on the API; some crash can occur.
Also the API account is a free one, so the lyrics is limited to the 30% of the entire song.

#How it works

- Search your song with some keywords related to the title, the artist or the album
- Select it from the list
- In the details view you will able to see the level of difficulty via the colored dots under the track description (green for easy, yellow for medium, red for hard and black if it's an instrumental song. The difficulty level is based on the number of unique words contained in the lyrics).
- Play it! Select the words in the right order (if the selection is correct it will become orange). You'll get a +1 for each correct word and a -1 for each wrong word
- At the end you will see your score and elapsed time

WARNING :- The API requests are made with a simple HTTP GET method. Apple forbids this kind of procedure in the deployment fase; you can use it only in the development fase at your own risk.
This is a simple test-game on the API possibilities made in few days, it's barely a prototype.

For further information about Musixmatch and its API visit the link below

Musixmatch API - https://developer.musixmatch.com


#Further implementation

- Deezer API implementation in order to reproduce the desired song while playing
- Sync song and lyrics
