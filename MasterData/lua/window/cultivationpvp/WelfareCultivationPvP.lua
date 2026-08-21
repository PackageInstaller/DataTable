local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local ACU = require("Common/ActivityUtil")
local GotoUtil = require("Common/GotoUtil")
local S = require("Common/Singleton")
local mActiveDungeons = {}
local mActivated = false
local mNowActivityId
local mDungeons = {}

function Awake()
  WU.BindButtonEvent(REF.ButtonCulRank, OnClickRank)
  WU.BindButtonEvent(REF.ButtonCulRule, OnClickRule)
  WU.BindButtonEvent(REF.ButtonCulReward, OnClickReward)
  for i = 0, #REF.EntranceGrid - 1 do
    local ref = REF.EntranceGrid[i]
    ref["@index"] = i
    WU.BindButtonEvent(ref["$"], function()
      OnClickEnterDungeon(ref["@index"])
    end)
  end
end

function OnClickEnterDungeon(index)
  if mActivated == false then
    WU.ShowHintText(WU.GetString("CultivationPvP_NotActivated"))
    return
  end
  local info = PB.get("ChallengeModeDungeon", mNowActivityId)
  if info == nil then
    warning("No activityId" .. mNowActivityId("in ChallengeModeDungeon.xlsx"))
    return
  end
  local dungeonId = info.dungeonId[index + 1]
  local _, dst = table.find(PB.all("ChipDungeonToCultivationDungeon"), function(k, v)
    return v.cultivationPVPDungeonId == dungeonId
  end)
  if dst and dst.chipDungeonId ~= nil then
    dungeonId = dst.chipDungeonId
  end
  GotoUtil.Goto("DungeonStory", {dungeonId, true})
end

function OnEnable()
  this:Bind("ActivityList", OnActivityChanged)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
  DB:GameRequest("fci/challenge-mode/reward"):Get(function(resp)
    DB:SetData("fci/challenge-mode/reward", resp)
    UpdateScore()
  end)
  RU.BindRedMark(this, "Welfare/CultivationPvP/Reward", OnRedMark)
end

function OnDisable()
  this:Unbind("ActivityList", OnActivityChanged)
  this:UnregisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
  RU.UnbindRedMark(this, "Welfare/CultivationPvP/Reward", OnRedMark)
end

function OnRedMark(flag)
  WU.SetActive(REF.CulRewardSpriteRedPoint, flag)
end

function OnClickReward()
  if not mActivated then
    return
  end
  WU.AcquireWindowAsync("WelfareCultivationPVPRewardListAll")
end

function OnClickRank()
  if not mActivated then
    return
  end
  WU.AcquireWindowAsync("CultivationPVPRanks")
end

function OnClickRule()
end

function OnActivityChanged(activityList)
  if activityList == nil then
    return
  end
  for _, activity in pairs(activityList) do
    if activity.type == PB.enum.ActivityType.CultivationPvP then
      mActivated = ACU.GetStatus(activity) == PB.enum.ActivityStatus.Started
      if mActivated then
        mNowActivityId = activity.activityId
        break
      end
    end
  end
  UpdateDesc()
end

function OnActivityStatusChanged(category, activityId, status, type)
  if type == PB.enum.ActivityType.CultivationPvP and status == PB.enum.ActivityStatus.Started then
    mNowActivityId = activityId
  end
  UpdateDesc()
end

function UpdateDesc()
  if not mActivated then
    return
  end
  local dungeonIds = PB.get("ChallengeModeDungeon", mNowActivityId).dungeonId
  local TexturePaths = PB.get("ChallengeModeDungeon", mNowActivityId).dungeonPic
  local record = this:GetData("CultivationPvP/scoreRecord")
  for i = 0, #REF.EntranceGrid - 1 do
    local ref = REF.EntranceGrid[i]
    local dungeonId = dungeonIds[i + 1]
    local score = 0
    ref.dungeonName.UIHtmlLabel.text = WU.GetString("ChallengeName_" .. dungeonId)
    ref.root.UITexture.mainTexturePath = "Texture/CultivationPVPChapter/" .. TexturePaths[i + 1]
    if dungeonId and record[tostring(dungeonId)] then
      score = record[tostring(dungeonId)]
    end
    ref.CurrentScore.UILabel.text = fif(score == 0, WU.GetString("Welfare_CultivationPVPScore", "--"), WU.GetString("Welfare_CultivationPVPScore", score))
  end
  local mActivityManager = S:Get("ActivityManager")
  local acInfo = mActivityManager.GetActivitySync(PB.enum.ActivityType.CultivationPvP, mNowActivityId)
  local startTime = acInfo.timestampStart
  local endTime = acInfo.timestampEnd
  local startDate = ACU.RenderTime2(startTime, true)
  local endDate = ACU.RenderTime2(endTime, true)
  REF.TimeLimit.UILabel.text = WU.GetString("CultivationPvP_TimeLimit", startDate, endDate)
end

function UpdateScore()
  if mNowActivityId == nil then
    return
  end
  local dungeonIds = PB.get("ChallengeModeDungeon", mNowActivityId).dungeonId
  local record = this:GetData("CultivationPvP/scoreRecord")
  for i = 0, #REF.EntranceGrid - 1 do
    local ref = REF.EntranceGrid[i]
    local dungeonId = dungeonIds[i + 1]
    local score = 0
    if dungeonId and record[tostring(dungeonId)] then
      score = record[tostring(dungeonId)]
    end
    ref.CurrentScore.UILabel.text = fif(score == 0, WU.GetString("Welfare_CultivationPVPScore", "--"), WU.GetString("Welfare_CultivationPVPScore", score))
  end
end
