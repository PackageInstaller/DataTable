local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local m_activityType, m_activityGroup, m_clicking

function Start()
  WU.BindButtonEvent(REF.ButtonActivity, OnButtonActivityClick)
  REF.SpriteRedMark.gameObject:SetActive(false)
end

function OnEnable()
  this:RegisterGameEvent("OnPlayerLevelup", OnPlayerLevelup)
  this:Bind("SelectedActivityGroup", OnSelectedActivityGroupChange)
end

function OnDisable()
  this:UnregisterGameEvent("OnPlayerLevelup", OnPlayerLevelup)
  this:Unbind("SelectedActivityGroup", OnSelectedActivityGroupChange)
end

function OnButtonActivityClick()
  if m_activityGroup ~= this:GetData("SelectedActivityGroup") then
    WU.RecordButtonClick(117400 + m_activityGroup[1].type)
    m_clicking = true
    this:SetData("SelectedActivityGroup", m_activityGroup)
    m_clicking = false
  end
end

function OnPlayerLevelup(lvFrom, lvTo)
  UpdateLockStatus()
end

function OnSelectedActivityGroupChange(selectedActivityGroup)
  UpdateSelectedStatus(selectedActivityGroup == m_activityGroup)
end

function SetData(activityGroup)
  if m_activityGroup then
    if m_activityGroup[1].type == PB.enum.ActivityType.EventDungeon then
      RU.UnbindRedMark(this, string.format("Activity/%s/%s", PB.enum.ActivityType.EventDungeon, m_activityGroup[1].activityId))
    else
      RU.UnbindRedMark(this, "Activity/" .. m_activityGroup[1].type)
    end
  end
  m_activityGroup = activityGroup
  if m_activityGroup then
    if m_activityGroup[1].type == PB.enum.ActivityType.EventDungeon then
      RU.BindRedMark(this, string.format("Activity/%s/%s", PB.enum.ActivityType.EventDungeon, m_activityGroup[1].activityId), OnRedMarkChange)
    else
      RU.BindRedMark(this, "Activity/" .. m_activityGroup[1].type, OnRedMarkChange)
    end
    UpdateContent()
  end
end

function OnRedMarkChange(flag)
  REF.SpriteRedMark.gameObject:SetActive(flag)
end

function UpdateContent()
  REF.SpriteActivity.UISprite.spriteName = "activities_" .. m_activityGroup[1].type
  REF.LabelName.UILabel.text = WU.GetString("WeekActivitiesType_Name_" .. m_activityGroup[1].type)
  local openTime = ""
  local activity
  for i = 1, #m_activityGroup do
    if ACU.IsActivityOn(m_activityGroup[i]) then
      activity = m_activityGroup[i]
    end
  end
  if activity.timeType == PB.enum.ActivityTimeType.Forever then
    openTime = WU.GetOpenHourRender(activity)
    if openTime == "" then
      openTime = WU.GetString("Window_OpenForever")
    else
      openTime = WU.GetString("Window_PerDay") .. openTime
    end
  elseif activity.timeType == PB.enum.ActivityTimeType.Week then
    openTime = WU.GetActivityWeekRender(activity, true)
  elseif activity.timeType == PB.enum.ActivityTimeType.Period then
    openTime = WU.RenderTime2(activity.timestampStart)
    openTime = openTime .. "~" .. WU.RenderTime2(activity.timestampEnd)
    openTime = openTime .. WU.GetOpenHourRender(activity)
  else
    openTime = "Invalid time type"
  end
  REF.LabelTime.UILabel.text = openTime
  REF.LabelOutput.UILabel.text = WU.GetString("Activity_Output_" .. m_activityGroup[1].type)
  UpdateLockStatus()
  UpdateSelectedStatus(m_activityGroup == this:GetData("SelectedActivityGroup"))
  REF.Danger.gameObject:SetActive(UsedForAutumn(true))
  local displayRunning = false
  local activities = DB:GetData("ActivityList")
  for i = 1, #m_activityGroup do
    if PB.get("DisplayRunningActivities", m_activityGroup[i].activityId) then
      for k, v in pairs(activities) do
        if v.activityId == m_activityGroup[i].activityId and ACU.IsOpenForDoing(v) then
          displayRunning = true
          break
        end
      end
      break
    end
  end
  REF.ActivityRunning.gameObject:SetActive(displayRunning)
end

function UpdateLockStatus()
  local locked = WU.WindowIsLocked(WU.ActivityTypeToUnlockWindowType(m_activityGroup[1].type))
  REF.NodeLock.gameObject:SetActive(locked)
end

function UpdateSelectedStatus(selected)
  if selected then
    if m_clicking then
      REF["$UIPlayTween"]:Play(true)
    else
      REF["$UIPlayTween"]:Finish()
    end
  else
    REF["$UIPlayTween"]:ResetToBeginning()
    REF["$UIPlayTween"]:Stop()
    REF.Visual.UIPlayTween:Finish()
  end
end

function UsedForAutumn(hard)
  local acType = m_activityGroup[1].type
  if hard then
    return acType == PB.enum.ActivityType.EventDungeon_Autumn2018Hard
  else
    return acType == PB.enum.ActivityType.EventDungeon_Autumn2018 or acType == PB.enum.ActivityType.EventDungeon_Autumn2018Hard
  end
end
