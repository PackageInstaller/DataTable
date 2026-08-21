local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_activityManager = S:Get("ActivityManager")
local DU = require("Common/DungeonUtil")
local m_chapterInfo, m_activityId, m_dungeonIds, m_records

function SetupWindow()
  WU.TraverseChildren(_ENV["$"](REF.NormalChapter).Dungeons, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnDungeonClick)
  end)
  WU.TraverseChildren(_ENV["$"](REF.DangerChapter).Dungeons, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnDungeonClick)
  end)
  WU.BindButtonEvent(REF.BOX, OnBtnRewardClick)
end

function InitWindow()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Task")
  REF.NormalChapter.gameObject:SetActive(false)
  REF.DangerChapter.gameObject:SetActive(false)
  m_chapterInfo = this:GetData("ChristmasDungeon/Chapter")
  m_activityId = m_chapterInfo.activityInfo.activityId
  local t = PB.get("EventDungeon", m_activityId, PB.enum.ActivityType.Christmas)
  if t == nil then
    warning("EventDungeon.xlsx lack info for activityId:" .. m_activityId)
    return
  end
  m_dungeonIds = t.dungeonId
  UpdateStaticUI()
  RU.BindRedMark(this, "Welfare/Christmas/Reward/" .. m_activityId, function(flag)
    WU.SetActive(REF.EffectBox, flag)
    WU.SetActive(REF.SpriteRed, flag)
  end)
  local path = "fci/activity/record/" .. PB.enum.ActivityType.Christmas .. "/" .. m_activityId
  this:BindRemote(DB:GameRequest(path), function(records)
    if records == nil then
      return
    end
    m_records = records.records or _ENV["!"]({})
    UpdateRecordUI()
  end)
end

function Focus(on)
  if on then
    WU.SetWindowTitle("EventChristmasStageChapter", "EventChristmasStage")
  end
end

function UpdateStaticUI()
  local isNormal = m_chapterInfo.isNormal
  REF.NormalChapter.gameObject:SetActive(isNormal)
  REF.DangerChapter.gameObject:SetActive(not isNormal)
  local chapterIndex = m_chapterInfo.chapterIndex
  local ref = fif(isNormal, _ENV["$"](REF.NormalChapter), _ENV["$"](REF.DangerChapter))
  for i = 1, #m_dungeonIds do
    local path = fif(isNormal, "Texture/ChristmasActivity/christmas_2800", "Texture/ChristmasActivityHard/christmas_4000")
    ref.Dungeons[i - 1].TextureBoard.UITexture.mainTexturePath = path .. chapterIndex .. "0" .. i
  end
  if not isNormal then
    ref.Dungeons[#m_dungeonIds - 1].TextureFirstPass.UITexture.mainTexturePath = "Texture/ChristmasActivityHard/christmas_first_reward_bg" .. chapterIndex
    REF.LabelName.UIHtmlLabel.text = WU.GetString(string.format("Christmas_DangerDungeonChapter%s", chapterIndex))
  else
    REF.LabelName.UIHtmlLabel.text = WU.GetString(string.format("Christmas_NormalDungeonChapter%s", chapterIndex))
  end
  local TweenRef = fif(isNormal, _ENV["$"](REF.NormalChapter), _ENV["$"](REF.DangerChapter))
  TweenRef.Dungeons.UIPlayTween:ResetToBeginning()
  TweenRef.Dungeons.UIPlayTween:Play(true)
  REF.EffectBg.EffectGenerator:Play()
end

function UpdateRecordUI()
  local ref = fif(m_chapterInfo.isNormal, _ENV["$"](REF.NormalChapter), _ENV["$"](REF.DangerChapter))
  for i = 1, #m_dungeonIds do
    local dungeonRef = ref.Dungeons[i - 1]
    local dungeonId = m_dungeonIds[i]
    local record = GetDungeonRecord(m_activityId, dungeonId)
    dungeonRef["@record"] = record
    dungeonRef.TextureBoard.UITexture.graify = not record.unlocked
    local starRef = dungeonRef.Stars
    WU.SetActive(starRef, record.doneTimes > 0)
    if record.doneTimes > 0 then
      for j = 0, #starRef - 1 do
        starRef[j].root.UISprite.spriteName = "star_" .. fif(j < #record.targetsDone, "light", "dark")
      end
    end
  end
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
  local data = this:GetData(string.format("fci/activity/star-reward/%s/%s", PB.enum.ActivityType.Christmas, m_activityId))
  WU.AcquireWindowAsync("PrizePreview", function(window)
    _ENV["$"](window)["$$SetPrizePreview"]("EventActivityStar", {
      activityType = PB.enum.ActivityType.Christmas,
      activityId = m_activityId,
      playerRecord = data.rewardSummary[m_activityId].totalStar,
      xlsxFilter = {
        [1] = {key = "activityId", value = m_activityId},
        [2] = {
          key = "activityType",
          value = PB.enum.ActivityType.Christmas
        }
      }
    })
  end)
end
