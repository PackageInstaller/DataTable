local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_activityManager = S:Get("ActivityManager")
local m_configDataManager = S:Get("ConfigDataManager")
local DU = require("Common/DungeonUtil")
local m_chapterInfo, m_activityId, m_dungeonIds, m_records, m_cartoonId

function SetupWindow()
  WU.TraverseChildren(REF.NormalChapter, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnDungeonClick)
  end)
  WU.TraverseChildren(REF.DangerChapter, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnDungeonClick)
  end)
  WU.BindButtonEvent(REF.BtnReward, OnBtnRewardClick)
end

function InitWindow()
  WU.SetActive(REF.NormalChapter, false)
  WU.SetActive(REF.NormalChapterBG, false)
  WU.SetActive(REF.NormalP, false)
  WU.SetActive(REF.DangerChapter, false)
  WU.SetActive(REF.DangerChapterBG, false)
  WU.SetActive(REF.DangerP, false)
  m_chapterInfo = this:GetData("CNYDungeon/Chapter")
  m_activityId = m_chapterInfo.activityInfo.activityId
  local t = PB.get("EventDungeon", m_activityId, PB.enum.ActivityType.ChineseNewYear)
  if t == nil then
    warning("EventDungeon.xlsx lack info for activityId:" .. m_activityId)
    return
  end
  m_dungeonIds = t.dungeonId
  m_cartoonId = t.openCartoonId
  UpdateStaticUI()
  RU.BindRedMark(this, "Welfare/ChineseNewYear/Reward/" .. m_activityId, function(flag)
    WU.SetActive(REF.EffectBox, flag)
    WU.SetActive(REF.SpriteRed, flag)
  end)
  local path = "fci/activity/record/" .. PB.enum.ActivityType.ChineseNewYear .. "/" .. m_activityId
  this:BindRemote(DB:GameRequest(path), function(records)
    if records == nil then
      return
    end
    m_records = records.records or _ENV["!"]({})
    local goCartoon = TryPlayCartoon()
    if not goCartoon then
      UpdateRecordUI()
    end
  end)
end

function Focus(on)
  if on then
    WU.SetWindowTitle("EventCNYStageChapter", "EventCNYStage")
  end
end

function UpdateStaticUI()
  local chapterIndex = m_chapterInfo.chapterIndex
  local bgRef = fif(m_chapterInfo.isNormal, _ENV["$"](REF.NormalChapterBG), _ENV["$"](REF.DangerChapterBG))
  local path = fif(m_chapterInfo.isNormal, "Texture/NewYearActivity/newyear_", "Texture/NewYearActivityHard/newyearhard_")
  if m_chapterInfo.isNormal then
    bgRef.BoardStory.UITexture.mainTexturePath = path .. chapterIndex .. "_" .. 1
  end
  for i = 1, #m_dungeonIds do
    local t = bgRef["Board" .. i]
    local index = fif(m_chapterInfo.isNormal, i + 1, i)
    bgRef["Board" .. i].UITexture.mainTexturePath = path .. chapterIndex .. "_" .. index
  end
end

function UpdateRecordUI()
  local ref = fif(m_chapterInfo.isNormal, _ENV["$"](REF.NormalChapter), _ENV["$"](REF.DangerChapter))
  local bgRef = fif(m_chapterInfo.isNormal, _ENV["$"](REF.NormalChapterBG), _ENV["$"](REF.DangerChapterBG))
  if m_chapterInfo.isNormal then
    local dungeonRef = _ENV["$"](ref.DungeonStory)
    dungeonRef["@isStory"] = true
  else
    REF.TextureFirstPass.UITexture.mainTexturePath = "Texture/NewYearActivityHard/christmas_first_reward_" .. m_chapterInfo.chapterIndex
  end
  for i = 1, #m_dungeonIds do
    local dungeonRef = _ENV["$"](ref["Dungeon" .. i])
    local dungeonId = m_dungeonIds[i]
    local record = GetDungeonRecord(m_activityId, dungeonId)
    dungeonRef["@record"] = record
    dungeonRef["@isNormal"] = m_chapterInfo.isNormal
    bgRef["Board" .. i].UITexture.color = CS.NGUIMath.HexToColor(fif(record.unlocked, 4294967295, 2340783615))
    local starRef = dungeonRef.Stars
    WU.SetActive(starRef, record.doneTimes > 0)
    if record.doneTimes > 0 then
      for j = 0, #starRef - 1 do
        starRef[j].root.UISprite.spriteName = "star_" .. fif(j < #record.targetsDone, "b", "b_dark")
      end
    end
  end
  local isNormal = m_chapterInfo.isNormal
  WU.SetActive(REF.NormalChapter, isNormal)
  WU.SetActive(REF.NormalChapterBG, isNormal)
  WU.SetActive(REF.NormalP, isNormal)
  WU.SetActive(REF.DangerChapter, not isNormal)
  WU.SetActive(REF.DangerChapterBG, not isNormal)
  WU.SetActive(REF.DangerP, not isNormal)
  local tweenGroup = fif(isNormal, 2, 3)
  REF.Contents.UIPlayTween.tweenGroup = tweenGroup
  REF.Contents.UIPlayTween:Play(true)
end

function GetDungeonRecord(acId, dungeonId)
  local _, record = table.find(m_records, function(k, v)
    return v.dungeonId == dungeonId
  end)
  if record == nil then
    error("GamePlay", string.format("dungeon%s's record is not in fci/activity/record/%s/%s", dungeonId, PB.enum.ActivityType.Christmas, acId))
  end
  return record
end

function OnDungeonClick(go)
  local ac = m_chapterInfo.activityInfo
  if not ACU.IsOpenForDoing(ac) then
    WU.ShowHintText(WU.GetString("Window_Activity_Close"))
    return
  end
  local ref = _ENV["$"](go)
  if ref["@isStory"] then
    OnStoryDungeonClick(go)
    return
  end
  local record = ref["@record"]
  if not record.unlocked then
    WU.ShowHintText(WU.GetString("Error_MustFinishPreDun"))
    return
  end
  local dungeonId = record.dungeonId
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  if dungeonReward.unlockLevel and this:GetData("fci/baseinfo/").level < dungeonReward.unlockLevel then
    WU.ShowHintText(WU.GetString("EventActivity_Level_Not_Enough", dungeonReward.unlockLevel))
    return
  end
  this:SetData("EventActivity/CurrentActivity", ac)
  this:SetData("WindowDungeon/DungeonId", dungeonId)
  this:SetData("ActorGroup/DungeonType", dungeonReward.type)
  WU.AcquireWindowAsync("EventStagePrepare")
end

function OnBtnRewardClick()
  local data = this:GetData(string.format("fci/activity/star-reward/%s/%s", PB.enum.ActivityType.ChineseNewYear, m_activityId))
  WU.AcquireWindowAsync("PrizePreview", function(window)
    _ENV["$"](window)["$$SetPrizePreview"]("EventActivityStar", {
      activityType = PB.enum.ActivityType.ChineseNewYear,
      activityId = m_activityId,
      playerRecord = data.rewardSummary[m_activityId].totalStar,
      xlsxFilter = {
        [1] = {key = "activityId", value = m_activityId},
        [2] = {
          key = "activityType",
          value = PB.enum.ActivityType.ChineseNewYear
        }
      }
    })
  end)
end

function OnStoryDungeonClick(go)
  PlayCartoon(m_cartoonId)
end

function TryPlayCartoon()
  if m_cartoonId == nil then
    return false
  end
  if not IsCartoonPlayed(m_cartoonId) then
    PlayCartoon(m_cartoonId, true)
    return true
  end
  return false
end

function IsCartoonPlayed(cartoonId)
  if cartoonId == nil or cartoonId == 0 then
    return true
  end
  local preferences = m_configDataManager.GetPreferences()
  if preferences.playedEventCartoon ~= nil then
    for _, v in pairs(preferences.playedEventCartoon) do
      if v == cartoonId then
        return true
      end
    end
  else
    preferences.playedEventCartoon = {}
  end
  return false
end

function PlayCartoon(cartoonId, auto)
  if auto then
    local preferences = m_configDataManager.GetPreferences()
    if preferences.playedEventCartoon == nil then
      preferences.playedEventCartoon = {}
    end
    table.insert(preferences.playedEventCartoon, cartoonId)
    m_configDataManager.SetPreferences(preferences)
  end
  EnterCartoonLevel(cartoonId)
end

function EnterCartoonLevel(cartoonId)
  WU.EnterCartoonLevel(cartoonId, "Welfare, EventCNYStage, EventCNYStageChapter")
end
