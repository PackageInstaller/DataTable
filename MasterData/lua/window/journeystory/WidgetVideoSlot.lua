local WU, DB, REF = require("Common/WindowUtil")(this)
local base = inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local m_showNew = false
local m_chapterTag, m_snapShotPath, m_storyName, m_cartoonId, m_hasNext
local m_changed = false
local m_video, m_pvName
local m_VideoDescBg = "story_title_bg_1"
local m_TagColor = CS.NGUIMath.HexToColor(1601869311)

function Start()
  WU.BindButtonEvent(REF.ButtonSlot, OnOpenCartoon)
end

function Draw()
  WU.SetActive(REF["$"], m_cartoonId ~= nil)
  REF.SpriteBg.UISprite.spriteName = m_VideoDescBg
  if m_snapShotPath ~= nil and m_snapShotPath ~= "Texture/JouneyVideo/" then
    REF.TextureSnapshot.UITexture.mainTexturePath = m_snapShotPath
    WU.SetActive(REF.TextureSnapshot, true)
    WU.SetActive(REF.TextureNoCover, false)
  else
    WU.SetActive(REF.TextureSnapshot, false)
    WU.SetActive(REF.TextureNoCover, true)
  end
  if m_storyName ~= nil and m_storyName ~= "" then
    REF.LabelStoryName.UILabel.text = m_storyName
    REF.LabelStoryName.UILabel.color = m_TagColor
    WU.SetActive(REF.LabelStoryName, true)
  else
    WU.SetActive(REF.LabelStoryName, false)
  end
  if m_chapterTag ~= nil then
    REF.LabelChapterTag.UILabel.text = m_chapterTag
    REF.LabelChapterTag.UILabel.color = m_TagColor
    WU.SetActive(REF.LabelChapterTag, true)
  else
    WU.SetActive(REF.LabelChapterTag, false)
  end
  WU.SetActive(REF.SpriteNew, m_showNew)
  if m_changed then
    PlayTween()
    m_changed = false
  end
end

function ShowCustom(data)
  m_video = data
  m_showNew = data.showNew
  m_chapterTag = data.chapterTag
  m_snapShotPath = data.movieIcon
  m_cartoonId = data.cartoonId
  m_storyName = data.storyName
  m_hasNext = data.hasNext
  m_pvName = data.pvName
  m_changed = true
  m_VideoDescBg = data.tagBg
  m_TagColor = data.tagColor
  MarkAsDirty()
end

function ClearSlot()
  m_showNew = false
  m_chapterTag = nil
  m_snapShotPath = nil
  m_storyName = nil
  m_cartoonId = nil
  m_hasNext = nil
  m_changed = false
  m_video = nil
  m_pvName = nil
  m_VideoDescBg = "story_title_bg_1"
  m_TagColor = CS.NGUIMath.HexToColor(1601869311)
  MarkAsDirty()
end

function OnOpenCartoon()
  DB:BroadcastGameEvent("JourneyVideo/Enter")
  WU.SetActive(REF.SpriteNew, false)
  local playerCartoonId = m_cartoonId .. DB:GetData("playerId")
  local preferences = m_configDataManager.GetPreferences()
  if preferences.playedStoryCartoon == nil then
    preferences.playedStoryCartoon = {}
  end
  table.insert(preferences.playedStoryCartoon, playerCartoonId)
  m_configDataManager.SetPreferences(preferences)
  DB:SetData("Cartoon/NextCartoon", m_hasNext)
  if m_pvName == nil or m_pvName == "" then
    if m_hasNext then
      WU.EnterCartoonLevel(m_cartoonId, nil, "nextcartoon")
    else
      local entrance = this:GetData("JourneyStory/Entrance") or {}
      local window = entrance.window or "Portal,JourneyStory"
      local extra = entrance.extra
      WU.EnterCartoonLevel(m_cartoonId, window, extra)
    end
  else
    WU.PlayMovie(m_pvName)
  end
end

function PlayTween()
  local playTween = REF["$"].UIPlayTween
  if playTween ~= nil then
    playTween:Play(true)
  end
end
