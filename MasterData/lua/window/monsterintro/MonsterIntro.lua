local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local TU = require("Common/TextUtil")
local m_actorConfig, m_boardActorConfig, m_audioActionList
local m_audioActionIndex = 0
local m_targetAction, m_audioSource
local m_subtitleCoros = {}
local m_closeCallback
local ActorTypePrefix = {
  "WindowActorList_Actor",
  "WindowActorList_Assist"
}
local TagColors = {
  4290261247,
  255,
  4285164287,
  255,
  255,
  2241000959
}

function SetupWindow()
  WU.BindButtonEvent(REF.BtnVoice, function()
    PlayAudio()
  end)
  WU.BindButtonEvent(REF.Black, function()
    if m_closeCallback then
      m_closeCallback()
    end
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
  REF.LabelSubtitle.UIHtmlLabel.text = ""
end

function UninitWindow()
  if m_audioSource then
    m_audioSource:Stop()
  end
  StopSubtitleCoros()
end

function PlayAudio()
  if m_actorConfig and m_boardActorConfig then
    if m_audioSource then
      m_audioSource:Stop()
    end
    m_audioActionIndex = m_audioActionIndex % #m_audioActionList + 1
    m_targetAction = m_audioActionList[m_audioActionIndex]
    local audioPath = string.format("Voice/%s/board_Emote/%s", m_boardActorConfig.name, m_targetAction.audio)
    m_audioSource = CS.SoundManager.Instance:PlaySound(audioPath)
    UpdateSubtitle(m_targetAction.text, m_audioSource.clip.length)
    REF.BtnVoice.TweenAlpha.enabled = true
    this:DelayInvokeInSeconds(math.ceil(m_audioSource.clip.length), function()
      REF.BtnVoice.TweenAlpha.enabled = false
      REF.BtnVoice.UISprite.alpha = REF.BtnVoice.TweenAlpha.to
    end)
  end
end

function StopSubtitleCoros()
  for _, coro in ipairs(m_subtitleCoros) do
    this:StopCoroutine(coro)
  end
  m_subtitleCoros = {}
end

function UpdateSubtitle(text, time)
  StopSubtitleCoros()
  local boardVoice2Text = PB.get("BoardVoice2Text", text)
  if boardVoice2Text then
    for _, data in ipairs(boardVoice2Text.data) do
      local subtitle = data.localizationText
      if data.delayInvoke > 0 then
        table.insert(m_subtitleCoros, this:DelayInvokeInSeconds(data.delayInvoke, function()
          REF.LabelSubtitle.UIHtmlLabel.text = WU.GetString(subtitle)
          table.remove(m_subtitleCoros, 1)
        end))
      else
        REF.LabelSubtitle.UIHtmlLabel.text = WU.GetString(subtitle)
      end
    end
    table.insert(m_subtitleCoros, this:DelayInvokeInSeconds(time, function()
      REF.LabelSubtitle.UIHtmlLabel.text = ""
      m_subtitleCoros = {}
    end))
  end
end

function GetActorDescribe()
  local maxCount = 5
  local roleID = m_actorConfig.role
  local desc = ""
  for i = 1, maxCount do
    local key = "ActorDescribe_" .. roleID .. "_" .. i
    if WU.IsExist(key) then
      local thisDesc = WU.GetString(key)
      if thisDesc and thisDesc ~= "" and thisDesc ~= key then
        desc = desc .. thisDesc
      end
    end
  end
  return desc
end

function SetData(monsterId, callback)
  m_closeCallback = callback
  local monsterInfo = PB.get("MonsterInfo", monsterId)
  if monsterInfo then
    m_actorConfig = PB.get("ActorConfig", monsterInfo.actorID)
    m_boardActorConfig = PB.get("BoardActorConfig", monsterInfo.actorID)
    m_audioActionList = _ENV["!"](m_boardActorConfig.actions):where(function(k, v)
      return v.audio and #v.audio > 0
    end):toarray()
    m_audioActionIndex = 0
    local actorDesc = GetActorDescribe()
    local novelId = AU.GetActorNovel(monsterInfo.actorID)
    if novelId then
      actorDesc = actorDesc .. "<l width=100%><c width=100% align=right>" .. WU.GetString("NovelName_" .. novelId) .. "</c></l>"
    end
    REF.IconActorName.UISprite.spriteName = "ActorListNameVertical/actor_name_" .. m_actorConfig.animRes
    REF.IconActorName.UISprite:SnapWithoutScale()
    REF.LabelViewSummary.UIHtmlLabel.text = actorDesc
    REF.IconActorType.UISprite.spriteName = "ActorListNameVertical/actor_type_" .. m_actorConfig.id
    REF.LabelCVDesc.UILabel.text = string.replace(WU.GetString("ActorCV_" .. m_actorConfig.id), "CV\239\188\154", "")
    if REF.LabelViewSummary.UIHtmlLabel.height <= REF.ScrollView.UIPanel.finalClipRegion.w then
      REF.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Center
    else
      REF.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Top
    end
    REF.ScrollView.UIScrollView:ResetPosition()
    local textKind = WU.GetString(ActorTypePrefix[m_actorConfig.kind])
    local textCategory = WU.GetString("ActorCategory_" .. tostring(m_actorConfig.category))
    REF.LabelType.UILabel.text = textKind
    REF.LabelTypeCategory.UILabel.text = textCategory
    PlayAudio()
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. m_actorConfig.animRes
    REF.TextureActor.UITexture.maskTexturePath = "Texture/ActorPortrait/actor_portrait_" .. m_actorConfig.animRes
    local width = REF.TextureActor.UITexture.width
    local height = REF.TextureActor.UITexture.height
    local offsetX = -m_actorConfig.portraitUVOffsetX / width
    local offsetY = m_actorConfig.portraitUVOffsetY / height
    local tileX = 1
    local tileY = 1
    REF.TextureActor.UITexture.uvRect = CS.UnityEngine.Rect(offsetX, offsetY, tileX, tileY)
    local actorTag = PB.get("ActorTag", monsterInfo.actorID)
    local j = 1
    local i = 1
    while i <= #REF.NodeTags do
      local tag = actorTag.tag[j]
      local tagRef = REF.NodeTags[i - 1]
      tagRef["$gameObject"]:SetActive(false)
      if tag then
        local actorTagInfo = PB.get("ActorTagInfo", tag)
        if actorTagInfo and actorTagInfo.displayTag then
          tagRef["$gameObject"]:SetActive(true)
          tagRef["$UISprite"].color = CS.NGUIMath.HexToColor(TagColors[actorTagInfo.color])
          tagRef.TagLabel.UIHtmlLabel.text = "<img src='Fight.ActorTypeTagIcon/actor_type_tag_" .. tag .. "'/>&nbsp;" .. WU.GetString("tag" .. tag)
          i = i + 1
        end
        j = j + 1
      else
        i = i + 1
      end
    end
  end
end
