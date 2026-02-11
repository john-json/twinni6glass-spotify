Uebersicht = require 'uebersicht'
command: "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyInfo.scpt"
refreshFrequency: 5000

render: (output) ->
  return "<div class='spotify-widget'>Not Playing</div>" unless output?.trim()
  parts = output.trim().split("||")
  return "<div class='spotify-widget'>Not Playing</div>" if parts.length < 3

  [track, artist,artwork, state] = parts
  playPauseIcon = if state is 'playing' then '' else '▶⏸'

  """
  <div class='spotify-widget'>
    <div class='spotify-info'>♫ #{track} — #{artist}</div>
    <div class='spotify-popup'>
      <img class='spotify-cover' src='#{artwork}' alt='cover'>
      <div class='spotify-controls'>
        <button class='button spotify-prev'>⏮</button>
        <button class='button spotify-play'>#{playPauseIcon}</button>
        <button class='button spotify-next'>⏭</button>
      </div>
    </div>
  </div>
  """



afterRender: (domEl) ->
  domEl.querySelector('.spotify-prev')?.addEventListener 'click', ->
    Uebersicht.run "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyPrev.scpt"
  domEl.querySelector('.spotify-play')?.addEventListener 'click', ->
    if domEl.querySelector('.spotify-play').innerText is '⏸'
      Uebersicht.run "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyPause.scpt"
    else
      Uebersicht.run "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyPlay.scpt"
  domEl.querySelector('.spotify-next')?.addEventListener 'click', ->
    Uebersicht.run "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyNext.scpt"

style: """
  .spotify-widget {
    justify-content: center; 
    position: fixed;
    top: 6px; 
    left: 20px;
    padding: 6px 15px;
    font-family: -apple-system, sans-serif;
    font-size: 12px; 
    color: white;
    background: rgba(28,28,28,0.4);
    border: 1px solid rgba(255,255,255,0.15);

    border-radius: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    backdrop-filter: blur(15px) saturate(180%);
  }
  .spotify-popup { display: none; margin-top: 15px; }
  .spotify-widget:hover .spotify-popup { display: block; justify-content: center; padding: 10px 10px;}
  .spotify-widget:hover .spotify-popup img { display: block; size: 12vh; border-radius: 15px; padding-bottom: 10px; }
  .spotify-controls { display: flex; gap: 20px; justify-content: center; background: none; padding-top: 10px; border-radius: 25px;  }
  .spotify-widget:hover .spotify-info { margin-top: 15px; font-size: 14px; }
  .spotify-widget:hover .spotify-popup { display: block; justify-content: center; padding: 10px 10px;}
  .spotify-controls button {
    background: rgba(14,14,14,0.4);
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 25px;
    padding: 3px 10px 0px 10px;
    color: white;
    cursor: pointer; 
    font-size: 16px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
  }
  .spotify-controls button:hover {  background: rgba(255,255,255, 0.4); box-shadow: 0 6px 18px rgba(0,0,0,0.22);}
"""
