local WU, DB, REF = require("Common/WindowUtil")(this)
local m_callback, m_player, m_lastStatus
local AVProVideo = CS.RenderHeads.Media.AVProVideo

function SetupWindow()
  WU.BindButtonEvent(REF.AVProPlayer, OnClick)
end

function InitWindow()
  CS.SoundManager.Instance:ChangeMusicVolume(0)
  m_player = REF.AVProPlayer.MediaPlayer
  m_player.Events:AddListener(OnPlayerEvent)
end

function UninitWindow()
  CS.SoundManager.Instance:ChangeMusicVolume(1)
end

function OnPlayerEvent(player, event, error)
  if event == AVProVideo.MediaPlayerEvent.EventType.Started then
    OnStart()
  elseif event == AVProVideo.MediaPlayerEvent.EventType.FinishedPlaying then
    OnStop()
  end
end

function OnStart()
  if m_callback ~= nil then
    m_callback(true)
  end
end

function OnStop()
  if m_callback ~= nil then
    m_callback(false)
  end
end

function Play(path, callback)
  m_callback = callback
  local asset_path = path .. ".mp4"
  local real_path = CS.ResourceManager.Instance:ResolveStreamingAssetPath(asset_path)
  m_player:OpenVideoFromFile(AVProVideo.MediaPlayer.FileLocation.AbsolutePathOrURL, real_path, false)
  m_player:Play()
end

function OnClick()
  if m_player ~= nil then
    m_player:Stop()
    this:BroadcastGameEvent("TutorialTlog", "stopFirst")
  end
  OnStop()
end
