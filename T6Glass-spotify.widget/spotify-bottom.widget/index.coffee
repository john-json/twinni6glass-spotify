Uebersicht = require 'uebersicht'
command: "osascript ~/Library/Application\\ Support/Übersicht/scripts/spotifyInfo.scpt"
refreshFrequency: 5000

render: (output) ->
  return "<div class='spotify-widget'>Not Playing</div>" unless output?.trim()
  parts = output.trim().split("||")
  return "<div class='spotify-widget'>Not Playing</div>" if parts.length < 3

  [track, artist, artwork, state] = parts
  playPauseIcon = if state is 'playing' then '⏸' else '▶'

  """
  <div class='spotify-widget'>
    <div class='spotify-anchor'>
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
    z-index: 1000;
    display: flex;
    justify-content: flex-start;
    align-items: flex-end;
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    margin-left: 5px;
    padding: 6px 16px 8px 16px;
    font-family: -apple-system, sf-pro, monospace;
    font-size: 10pt;
    color: white;
    box-shadow: 0 0 0 rgba(0,0,0,0.0);
    text-shadow: 0 0 1px rgba(0, 0, 0, 1);
    max-width: 30%;
    border-radius: 25px;
  }

  .spotify-anchor {
    position: relative;
    display: inline-flex;
    flex-direction: column;
    align-items: center;
  }

  .spotify-info {
    display: block;
    pointer-events: none;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    opacity: 1;
    transform: scale(1);
    transform-origin: center center;
    transition:
      opacity 0.20s ease-out,
      transform 0.20s ease-out;
  }

  .spotify-popup {
    display: block;
    position: absolute;
    bottom: calc(100% + 6px);
    left: 50%;
    opacity: 0;
    max-height: 0;
    overflow: hidden;
    padding: 0 10px;
    justify-content: center;
    transform: translateX(-50%) translateY(6px) scale(0.8);
    transform-origin: bottom center;
    transition:
      opacity 0.3s ease-out,
      transform 0.3s ease-out,
      max-height 0.3s ease-out,
      padding 0.3s ease-out,
      box-shadow 0.3s ease-out,
      border 0.3s ease-out,
      background 0.3s ease-out;
  }

  .spotify-widget:hover .spotify-info {
    opacity: 0;
    transform: scale(1, 0.5);
    display: block;
  }

  .spotify-widget:hover .spotify-popup {
    display: block;
    opacity: 1;
    max-height: 400px;
    padding: 10px 10px;
    background: rgba(255,255,255,0.2);
    border: 2px solid rgba(255,255,255,0.15);
    border-radius: 25px;
    box-shadow: 0 4px 25px rgba(0,0,0,0.1);
    transform: translateX(-50%) translateY(0) scale(0.8);
    transition:
      opacity 0.4s ease-out,
      transform 0.4s ease-out,
      max-height 0.4s ease-out,
      padding 0.4s ease-out,
      box-shadow 0.4s ease-out,
      border 0.4s ease-out,
      background 0.4s ease-out;
  }

  .spotify-widget .spotify-popup img {
    display: block;
    margin: auto;
    padding: 10px;
    width: 7vw;
    height: 7vw;
    border-radius: 25px;
    box-shadow: 0 15px 20px rgba(0,0,0,0.1);
    transition:
      transform 0.3s ease-out,
      box-shadow 0.3s ease-out;
    transform: scale(1);
  }

  .spotify-controls {
    display: flex;
    justify-content: space-around;
    background: rgba(255,255,255,0.1);
    border: 1px solid rgba(255,255,255,0.2);
    padding-top: 5px;
    margin-top: 10px;
    border-radius: 25px;
    transform: scale(1);
    transition:
      background 0.2s ease-out,
      box-shadow 0.2s ease-out;
  }

  .spotify-controls button {
    padding: 5px 8px;
    border-radius: 25px;
    color: white;
    cursor: pointer;
    font-size: 10pt;
    background: rgba(255,255,255,0.0);
    border: 1px solid rgba(255,255,255,0.0);
    transition:
      background 0.2s ease-out,
      border 0.2s ease-out,
      transform 0.15s ease-out,
      box-shadow 0.2s ease-out;
  }

  .spotify-controls button:hover {
    display: inline-block;
    transform: translateY(-1px) scale(1.5);
    box-shadow: 0 18px 24px rgba(0,0,0,0.18);
    background: rgba(255,255,255,1);
    color: black;
    transition:
      transform 0.3s ease-out,
      box-shadow 0.3s ease-out;
  }
"""
