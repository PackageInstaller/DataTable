local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local DU = require("Common/DungeonUtil")
local ATU = require("Common/AutumnUtil")
local mEvent
local mEventDungeonList = {}
local mCurrentEvent
local mEventRecord = {}
local mStageItem = {}
local m_currentType
local m_types = {
  autumn = {
    type = PB.enum.ActivityType.EventDungeon_Autumn2018,
    name = "Autumn",
    gbName = "EventAutumn",
    stageName = "EventAutumnStage"
  },
  autumnHard = {
    type = PB.enum.ActivityType.EventDungeon_Autumn2018Hard,
    name = "AutumnHard",
    gbName = "EventAutumnHard",
    stageName = "EventAutumnStageHard"
  },
  summer = {
    type = PB.enum.ActivityType.EventDungeon,
    name = "Summer"
  }
}
local m_activities = {}
local m_curActivity
local m_rewardSumry = {}
local currentRef

function SetupWindow()
  ManageButtonEvent()
end

function InitWindow()
  this:Bind("NavigationContext", OnWindowShow)
end

function ResetAllContent()
  SetMode()
  local activities = this:GetData("EventActivity/Activities")
  local updateTab = this:GetData("EventDungeon/TabIndexUpdateAble")
  local index = this:GetData("EventActivity/" .. m_currentType.type .. "/TabIndex")
  index = fif(index ~= nil and updateTab, U.ToInt(index), 1)
  m_curActivity = activities[index]
  REF[m_currentType.gbName]["$SetTab"](index)
  this:Bind("EventActivity/CurrentActivity", OnCurrentActivitChange)
  this:BindRemote(DB:GameRequest("fci/event-dungeon/record/"), function(record)
    TryPlayCartoon()
    PopulateProgress()
  end)
  local reward = this:GetData("fci/event-dungeon/star-reward")
  local updateReward = this:GetData("EventDungeon/RewardUpdateAble")
  if reward == nil or updateReward then
    RefreshReward()
  else
    m_rewardSumry = reward
    SetReward()
  end
  if currentRef and currentRef["$Animator"] then
    currentRef["$Animator"]:Play("Open", -1, 0)
  end
  CheckActivityClose()
end

function SetMode()
  local type2Change
  for k, v in pairs(m_types) do
    if v.stageName == WU.TopWindow().name then
      type2Change = v
    end
  end
  m_currentType = type2Change
  this:SetData("Activity/CurrentType", m_currentType.type)
  m_activities = ATU.GetActivitesByType(m_currentType.type)
end

function OnRedMark(flag)
  WU.SetActive(REF.EffectBox, flag)
end

function RefreshReward()
  this:GameRequest("fci/event-dungeon/star-reward"):Get(function(response)
    this:SetData("fci/event-dungeon/star-reward", response)
    this:SetData("EventDungeon/RewardUpdateAble", false)
    m_rewardSumry = response
    SetReward()
  end)
end

function OnWindowShow(name)
  if name == REF.root.name then
    ResetAllContent()
    DB:SetData("Event/ActivityType", nil)
  end
end

function OnCurrentActivitChange(activity)
  if activity == nil or WU.TopWindow().name ~= m_currentType.stageName then
    return
  end
  m_curActivity = activity
  SetEvent()
  SetReward()
  this:SetData("EventActivity/" .. m_currentType.type .. "/TabIndex", activity.index)
end

function UpdateWindow()
  if mCurrentEvent then
    local targetTime = mCurrentEvent.activityInfo.timestampEnd
    local remainTime = targetTime - CS.GameTime.serverUtc
    if 0 < remainTime then
      local timeString = RenderTime(remainTime)
      REF.LabelRest.UIHtmlLabel.text = timeString
    else
      REF.LabelRest.UIHtmlLabel.text = ""
    end
  end
end

function TryPlayCartoon()
  if mCurrentEvent == nil then
    return
  end
  local openCartoon = mCurrentEvent.eventDungeon.openCartoonId
  if not IsCartoonPlayed(openCartoon) then
    PlayCartoon(openCartoon)
    return
  end
  local record = this:GetData("fci/event-dungeon/record/")
  if record == nil then
    return
  end
  if #record < 1 then
    return
  end
  record = _ENV["!"](record)
  record = record:where(function(k, v)
    for index, dungeonId in pairs(mCurrentEvent.eventDungeon.dungeonId) do
      if dungeonId == v.dungeonId then
        return true
      end
    end
    return false
  end)
  if record == nil then
    return
  end
  if 1 < #record then
    table.sort(record, function(a, b)
      return a and b and a.dungeonId < b.dungeonId
    end)
  end
  for _, item in pairs(record) do
    if item.finished then
      local stage = PB.get("EventDungeonStage", item.dungeonId)
      local cartoonId = stage.finishCartoonId
      if not IsCartoonPlayed(cartoonId) then
        PlayCartoon(cartoonId)
        return
      end
    end
  end
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

function PlayCartoon(cartoonId)
  local preferences = m_configDataManager.GetPreferences()
  if preferences.playedEventCartoon == nil then
    preferences.playedEventCartoon = {}
  end
  table.insert(preferences.playedEventCartoon, cartoonId)
  m_configDataManager.SetPreferences(preferences)
  EnterCartoonLevel(cartoonId)
end

function EnterCartoonLevel(cartoonId)
  WU.EnterCartoonLevel(cartoonId, "Activity, " .. m_currentType.stageName)
end

function CheckActivityClose()
  if mCurrentEvent == nil then
    return
  end
  local activityInfo = mCurrentEvent.activityInfo
  local timeEnd = activityInfo.timestampEnd
  local now = CS.GameTime.serverUtc
  if timeEnd < now then
    ShowCloseHint()
  end
end

function ShowCloseHint()
  WU.ShowHintText(WU.GetString("EventActivity_Hint_Close"))
end

function SetEvent()
  if WU.TopWindow().name ~= m_currentType.stageName then
    return
  end
  mStageItem = {}
  local activityId = m_curActivity.activityId
  local eventId = activityId
  local eventDungeon
  local eventDungeon = PB.get("EventDungeon", activityId, m_curActivity.type)
  mCurrentEvent = {eventDungeon = eventDungeon, activityInfo = m_curActivity}
  mEventDungeonList[eventId] = eventDungeon
  local refObj = REF["StageMap" .. m_curActivity.index]
  local stage = _ENV["$"](refObj).root
  for index = 0, #stage - 1 do
    local item = stage[index]
    local luaIndex = index + 1
    local dungeonId = eventDungeon.dungeonId[luaIndex]
    table.insert(mStageItem, {
      root = item.root,
      dungeonId = dungeonId
    })
    WU.BindButtonEvent(item.root, function()
      OnStageClick({eventId = eventId, dungeonId = dungeonId})
    end)
  end
  PopulateProgress()
end

function OnReplayOpening(param)
  local openCartoon = mCurrentEvent.eventDungeon.openCartoonId
  PlayCartoon(openCartoon)
end

function PopulateRewardSummary()
  local rewardSummary = m_rewardSumry
  if mCurrentEvent == nil or rewardSummary == nil then
    return
  end
  local activityId = mCurrentEvent.activityInfo.activityId
  local summary = rewardSummary.rewardSummary[activityId]
  if summary then
    local currentStar = summary.totalStar
    REF.CurrentStar.UILabel.text = currentStar
    local allAwards = PB.all("EventReward"):where(function(k, v)
      return v.activityId == activityId
    end):toarray():sort(function(a, b)
      return a.star < b.star
    end)
    local last = 0
    local next = 0
    for k, reward in pairs(allAwards) do
      if currentStar >= reward.star then
        last = reward.star
      elseif currentStar <= reward.star and next == 0 then
        next = reward.star
      end
    end
    local progress = 0
    if currentStar >= next or next == last then
      progress = 1
    else
      progress = (currentStar - last) / (next - last)
    end
    REF.ProgressBar.UIProgressBar.value = progress
    REF.NextTargetStar.UILabel.text = next
  end
end

function PopulateProgress()
  local record = this:GetData("fci/event-dungeon/record/")
  mEventRecord = {}
  if record then
    for i = 1, #record do
      local item = record[i]
      mEventRecord[item.dungeonId] = item
    end
  end
  for i = 1, #mStageItem do
    local stage = mStageItem[i]
    local record = mEventRecord[stage.dungeonId]
    local stageInfo = PB.get("EventDungeonStage", stage.dungeonId)
    local stars = _ENV["$"](stage.root).stars
    local serverUtc = CS.GameTime.serverUtc
    local isClear = IsDungeonClear(stage.dungeonId)
    local isOpen = IsDungeonOpen(stage.dungeonId)
    local isUnlock = isClear and isOpen
    if stageInfo and (m_currentType ~= m_types.Autumn or m_currentType ~= m_types.AutumnHard) then
      local startTime = stageInfo.startTime
      local utc = CS.GameTime.ServerTimeStrToUtc(startTime)
      local currentTime = CS.GameTime.UtcToLocal(utc)
      local isOpen = serverUtc > utc
      if isOpen then
        _ENV["$"](stage.root).opentime.gameObject:SetActive(false)
      else
        _ENV["$"](stage.root).opentime.gameObject:SetActive(true)
        local mouth = currentTime.Month
        local day = currentTime.Day
        _ENV["$"](stage.root).opentime.UILabel.text = WU.GetString("EventActivity_Stage_OpenTime", mouth, day)
      end
    end
    if m_currentType == m_types.autumn or m_currentType == m_types.autumnHard then
      _ENV["$"](stage.root).opentime.gameObject:SetActive(false)
    end
    if isClear and isOpen then
      _ENV["$"](stage.root).sprite.UISprite.graify = false
    else
      _ENV["$"](stage.root).sprite.UISprite.graify = true
    end
    if record then
      stars.gameObject:SetActive(true)
      PopulateStageStar(stage.root, #record.targetsDone)
    else
      stars.gameObject:SetActive(false)
    end
    _ENV["$"](stage.root).name.UILabel.graify = _ENV["$"](stage.root).sprite.UISprite.graify
  end
end

function IsDungeonUnlock(dungeonId)
  return not IsDungeonOpen(dungeonId) or not IsDungeonClear(dungeonId)
end

function IsDungeonOpen(dungeonId)
  local stageInfo = PB.get("EventDungeonStage", dungeonId)
  if stageInfo then
    local serverUtc = CS.GameTime.serverUtc
    local startTime = stageInfo.startTime
    local utc = CS.GameTime.ServerTimeStrToUtc(startTime)
    local currentTime = CS.GameTime.UtcToLocal(utc)
    return serverUtc > utc
  end
  return false
end

function IsDungeonClear(dungeonId)
  local reward = PB.get("DungeonReward", dungeonId)
  if reward and reward.preDungeonId then
    local preDungeonId = reward.preDungeonId
    if preDungeonId == 0 then
      return true
    elseif mEventRecord[preDungeonId] then
      return mEventRecord[preDungeonId].finished
    end
  end
  return false
end

function PopulateStageStar(ref, starCount)
  local rest = starCount
  local stars = _ENV["$"](ref).stars
  for index = 0, #stars - 1 do
    local child = stars[index]
    if 0 < rest then
      child.root.UISprite.spriteName = "star_light"
    else
      child.root.UISprite.spriteName = "star_dark"
    end
    rest = rest - 1
  end
end

function SetReward()
  if m_curActivity == nil then
    return
  end
  local hasReward = DU.DoesEventActivityHasStarReward(m_rewardSumry.rewardSummary, m_curActivity.activityId)
  WU.SetActive(REF.EffectBox, hasReward)
  WU.SetActive(REF.SpriteRed, hasReward)
  ATU.MangeAutumnRedMark()
end

function OnStageClick(param)
  local event = mEventDungeonList[param.eventId]
  if event == nil then
    return
  end
  local dungeonId = param.dungeonId
  if not IsDungeonClear(dungeonId) or not IsDungeonOpen(dungeonId) then
    return
  end
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  local currentLevel = this:GetData("fci/baseinfo/").level
  local unlockLevel = dungeonReward.unlockLevel
  if unlockLevel and currentLevel < unlockLevel then
    WU.ShowHintText(WU.GetString("EventActivity_Level_Not_Enough", unlockLevel))
    return
  end
  this:SetData("WindowDungeon/DungeonId", dungeonId)
  local dungeonType = dungeonReward.type
  this:SetData("ActorGroup/DungeonType", dungeonType)
  this:SetData("Event/ActivityId", param.eventId)
  WU.AcquireWindowAsync("EventStagePrepare")
end

function OnRewardClick()
  local param = {
    eventId = m_curActivity.activityId
  }
  this:SetData("Event/ActivityId", param.eventId)
  if m_currentType.name == "Autumn" or m_currentType.name == "AutumnHard" then
    WU.AcquireWindowAsync("EventAutumnBonusPreview", function(ui)
      _ENV["$"](ui)["$$SetMode"](1)
    end)
  else
    WU.AcquireWindowAsync("EventBonusPreview")
  end
end

function RenderTime(time)
  local dateTime = CS.GameTime.UtcToLocal(time)
  local seconds = math.max(time, 0)
  local timeSpan = CS.System.TimeSpan(0, 0, seconds)
  local pattern = "<font size=48>%s</font>"
  local res = WU.GetString("EventActivity_Left_Time")
  if timeSpan.Days > 3 then
    return res .. string.format(pattern, timeSpan.Days) .. WU.GetString("Window_DayUnit")
  end
  local hours = math.floor(time / 3600)
  local minues = math.floor(time % 3600 / 60)
  if 0 < hours then
    res = res .. string.format(pattern, hours) .. WU.GetString("Window_HourUnit")
  end
  res = res .. string.format(pattern, minues) .. WU.GetString("Window_MinUnit")
  return res
end

function ManageButtonEvent()
  if REF.ReplayOpeningCartoon then
    WU.BindButtonEvent(REF.ReplayOpeningCartoon, OnReplayOpening)
  end
  WU.BindButtonEvent(REF.RewardButton, OnRewardClick)
  WU.BindButtonEvent(REF.BOX, OnRewardClick)
end
