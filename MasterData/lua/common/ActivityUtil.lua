local PB = require("Common/PbHelper")
local WU, DB = require("Common/WindowUtil")()
local U = require("Common/Util")
local ACU = {
  SummerActivityId = 27001,
  AutumnActivityId = {
    39001,
    39002,
    39003
  }
}

function ACU.GetStatus(activityInfo)
  local result = PB.enum.ActivityStatus.None
  if activityInfo then
    local time = CS.GameTime.serverUtc
    if activityInfo.timestampClose > 0 and time >= activityInfo.timestampClose then
      result = PB.enum.ActivityStatus.Close
    elseif 0 < activityInfo.timestampEnd and time >= activityInfo.timestampEnd then
      result = PB.enum.ActivityStatus.Finished
    elseif time >= activityInfo.timestampStart then
      result = PB.enum.ActivityStatus.Started
    elseif time >= activityInfo.timestampPreheat then
      result = PB.enum.ActivityStatus.PreHeat
    end
  end
  return result
end

function ACU.IsForeverActivity(activityInfo)
  local nowSeconds = CS.GameTime.serverUtc
  if nowSeconds > activityInfo.timestampStart and activityInfo.timestampEnd == 0 then
    return true
  end
  return false
end

function ACU._IsOpenByHour(activityInfo)
  if activityInfo.dayOpenTime == nil or #activityInfo.dayOpenTime == 0 then
    return true
  end
  local diff = CS.GameTime.serverNow.TimeOfDay.TotalSeconds
  for i, v in ipairs(activityInfo.dayOpenTime) do
    if diff >= v.timestampStart and diff < v.timestampEnd then
      return true
    end
  end
  return false
end

function ACU.IsOpenForDoing(activityInfo, bCloseTime, ignoreHour)
  if activityInfo == nil or table.empty(activityInfo) then
    return false
  end
  local now = CS.GameTime.serverNow
  local nowDay = U.ToInt(now.DayOfWeek)
  if nowDay == 0 then
    nowDay = 7
  end
  local nowSeconds = CS.GameTime.serverUtc
  local startTime = activityInfo.timestampStart
  local endTime = activityInfo.timestampEnd
  if bCloseTime then
    endTime = activityInfo.timestampClose
  end
  if nowSeconds >= startTime and (nowSeconds < endTime or endTime == 0) then
    if table.empty(activityInfo.weekdays) then
      return true
    else
      for i, v in pairs(activityInfo.weekdays) do
        if v == nowDay then
          return ignoreHour or ACU._IsOpenByHour(activityInfo)
        end
      end
    end
    return false
  else
    return false
  end
  return false
end

function ACU.IsActivitiesOn(activityInfoList)
  if activityInfoList then
    for i = 1, #activityInfoList do
      if ACU.IsActivityOn(activityInfoList[i]) then
        return true
      end
    end
  end
  return false
end

function ACU.IsActivityOn(activityInfo)
  if activityInfo then
    local timeRangeMin = activityInfo.timestampPreheat
    if timeRangeMin == 0 then
      timeRangeMin = activityInfo.timestampStart
    end
    local timeRangeMax = activityInfo.timestampClose
    if timeRangeMax == 0 then
      timeRangeMax = activityInfo.timestampEnd
    end
    local nowSeconds = CS.GameTime.serverUtc
    return (timeRangeMin == 0 or timeRangeMin <= nowSeconds) and (timeRangeMax == 0 or timeRangeMax >= nowSeconds)
  end
  return false
end

function ACU.NeedDisplay(activityInfo)
  local needDisplay = true
  local status = ACU.GetStatus(activityInfo)
  if status == PB.enum.ActivityStatus.None or status == PB.enum.ActivityStatus.Close then
    needDisplay = false
  end
  return needDisplay
end

function ACU.GetRemainTime(activityInfo)
  local remainTime = 0
  local status = ACU.GetStatus(activityInfo)
  local time = CS.GameTime.serverUtc
  if status == PB.enum.ActivityStatus.PreHeat then
    remainTime = activityInfo.timestampStart - time
  elseif status == PB.enum.ActivityStatus.Started then
    remainTime = activityInfo.timestampEnd - time
  elseif status == PB.enum.ActivityStatus.Finished then
    remainTime = activityInfo.timestampClose - time
  end
  return remainTime
end

function ACU.GetAllLeftAsyncPvpRecord()
  local allLeftRewardWinNumList = {}
  local asyncPvpActivityId
  local activityInfoList = DB:GetData("ActivityList")
  if activityInfoList then
    for i, v in ipairs(activityInfoList) do
      if v.category == PB.enum.ActivityCategory.Tournament and v.type == PB.enum.ActivityType.Tournament_AsyncPvp then
        asyncPvpActivityId = v.activityId
        break
      end
    end
  end
  if asyncPvpActivityId ~= nil then
    local tournamentInfo = DB:GetData("fci/tournament/info/" .. PB.enum.ActivityType.Tournament_AsyncPvp .. "/" .. asyncPvpActivityId)
    if tournamentInfo then
      local _, tournamentInfo = table.find(tournamentInfo.tournamentConf, function(k, v)
        return v.id == asyncPvpActivityId
      end)
      if tournamentInfo then
        local asyncPvpRecord = DB:GetData("fci/asyncpvprecord/")
        if asyncPvpRecord and asyncPvpRecord.leftRewardsWinNum then
          for j = 1, #asyncPvpRecord.leftRewardsWinNum do
            table.insert(allLeftRewardWinNumList, asyncPvpRecord.leftRewardsWinNum[j])
          end
        end
      end
    end
  end
  return allLeftRewardWinNumList
end

function ACU.GetActivitiesByCategory(category, activityId)
  local result = {}
  local activityInfoList = DB:GetData("ActivityList")
  if activityInfoList then
    for i, v in ipairs(activityInfoList) do
      if v.category == category then
        if activityId ~= nil then
          if v.activityId == activityId then
            table.insert(result, v)
          end
        else
          table.insert(result, v)
        end
      end
    end
  end
  return result
end

function ACU.GetCurrentActivityList(type)
  local activities = DB:GetData("ActivityList")
  local currentActivityList = {}
  for i = 1, #activities do
    local mulId = 0
    local tab = PB.get("ActivityDungeon", activities[i].activityId)
    if tab ~= nil then
      mulId = tab.multipleActivityId
    end
    if type == PB.enum.ActivityType.DungeonTeam then
      mulId = -1
    end
    if type == PB.enum.ActivityType.DungeonTeamWelfare then
      mulId = -1
    end
    if activities[i].type == type and mulId ~= 0 then
      table.insert(currentActivityList, activities[i])
    end
  end
  table.sort(currentActivityList, function(a, b)
    return a.activityId < b.activityId
  end)
  return currentActivityList
end

function ACU.GetCurStaticTournamentInfo()
  local staticTournamentInfo
  local curTournamentId = DB:GetData("fci/tournament/curId")
  local activityType = DB:GetData("fci/tournament/curActivityType")
  local tournamentInfo = DB:GetData("fci/tournament/info/" .. activityType .. "/" .. curTournamentId)
  if tournamentInfo and curTournamentId then
    local idx = table.find(tournamentInfo.tournamentConf, function(k, v)
      return curTournamentId == v.id
    end)
    if idx then
      staticTournamentInfo = tournamentInfo.tournamentConf[idx]
    end
  end
  return staticTournamentInfo
end

function ACU.GetTournamentStatus(activityId)
  local status = PB.enum.TournamentStatus.NoParticipation
  local tournament = ACU.GetTournamentById(activityId)
  if tournament ~= nil then
    status = tournament.status
  end
  return status
end

function ACU.GetTournamentById(activityId)
  local tournamentSummary = DB:GetData("fci/tournament/summary/")
  if tournamentSummary and tournamentSummary.activityInfo then
    local _, tournament = table.find(tournamentSummary.activityInfo, function(k, v)
      return v.activity and v.activity.activityId == activityId
    end)
    return tournament
  end
end

function ACU.IsActivityUnlockedWithHint(type, bForCheck)
  local enumVal = WU.ActivityTypeToUnlockWindowType(type)
  return not WU.WindowIsLocked(enumVal, fif(bForCheck, nil, enumVal))
end

function ACU.SetCurTournamentId(activityId)
  DB:SetData("fci/tournament/curId", activityId)
  local tournamentInfo = ACU.GetTournamentById(activityId)
  if tournamentInfo ~= nil and tournamentInfo.activity then
    DB:SetData("fci/tournament/curActivityType", tournamentInfo.activity.type)
  else
    error("Tournament", "SetCurTournamentId failed, cannot find activity by activityId: " .. activityId)
  end
end

function ACU.RenderTime2(time, showHours, showYear)
  local result = ""
  local dateTime = CS.GameTime.UtcToLocal(time)
  local hour = dateTime.Hour
  local minute = dateTime.Minute
  local second = dateTime.Second
  if hour == 23 and minute == 59 and second == 59 then
    hour = 24
  end
  if showHours then
    if showYear then
      result = WU.GetString("Window_Year_Month_Day_Hour", dateTime.Month, dateTime.Day, hour)
    else
      result = WU.GetString("Window_Month_Day_Hour", dateTime.Month, dateTime.Day, hour)
    end
  elseif showYear then
    result = WU.GetString("Window_Year_Month_Day", dateTime.Year, dateTime.Month, dateTime.Day)
  else
    result = WU.GetString("Window_Month_Day", dateTime.Month, dateTime.Day)
  end
  return result
end

function ACU.RenderTimeSlice(time1, time2, localizationText)
  local t1, t2
  local isSameYear = U.IsSameYear(time1, time2)
  t1 = ACU.RenderTime2(time1, false, not isSameYear)
  t2 = ACU.RenderTime2(time2, false, not isSameYear)
  return WU.GetString(localizationText, t1, t2)
end

function ACU.GetGoldDungeonTicket()
  local goldDungeonLevelInfo = PB.get("GoldDungeonLevel", DB:GetData("fci/baseinfo").level)
  if goldDungeonLevelInfo then
    local dungeonRewardInfo = PB.get("DungeonReward", goldDungeonLevelInfo.dungeonId)
    if dungeonRewardInfo then
      local cost = dungeonRewardInfo.costWin[1]
      return cost
    end
  end
end

function ACU.DosePostCardHasRedPoint(res, activity)
  if res == nil then
    return
  end
  local rewardList = res.prizeInfo
  local canGetTotal = true
  if res.isFirstEnter then
    return true
  end
  local itemInfo = PB.get("PostcardCell", 1, 1).cost
  local item = DB:GetData("fci/item/" .. itemInfo.id)
  local itemCount = 0
  if item then
    itemCount = item.count or 0
  end
  for i = 2, #rewardList do
    local open = ACU.IsPostcardOpen(i - 1)
    if res.postcardInfo[i - 1] == nil then
      return
    end
    local cells = res.postcardInfo[i - 1].postcardCell
    local _, v = table.find(cells, function(_, c)
      return c.isLighten == false
    end)
    if v == nil and open then
      if rewardList[i].prizeReceiveStatus == false then
        return true
      end
    elseif itemCount >= itemInfo.count and open then
      return true
    else
      canGetTotal = false
    end
  end
  if rewardList[1].prizeReceiveStatus == false and canGetTotal then
    return true
  end
  return false
end

function ACU.IsPostcardOpen(postcardId)
  local prize = PB.get("PostcardPrize", postcardId)
  if prize == nil then
    warning("PostcardPrize not found : " .. postcardId)
    return true
  end
  local timeStart = prize.timeStart
  if timeStart == nil then
    return true
  end
  local serverTime = CS.GameTime.UtcToLocal(CS.GameTime.serverUtc)
  local startTime = CS.System.DateTime.Parse(timeStart)
  local timeLeft = math.floor((startTime - serverTime).TotalSeconds)
  local open = timeLeft <= 0
  return open, startTime
end

function ACU.HasHalloweenRedPoint(res)
  if res == nil then
    return false
  end
  local bFirst = res.isFirstEnter
  local info = PB.all("JigsawPuzzleCell")
  local rewardInfo = PB.all("JigsawPuzzlePrize")
  local bOk = false
  local lightCnt = #res.lightenCell
  if not bFirst then
    for i, v in pairs(rewardInfo) do
      if lightCnt >= v.lightNum and 0 < lightCnt and v.lightNum > 0 then
        local bDone = false
        for i, hasLightNum in ipairs(res.receivePrize) do
          if v.lightNum == hasLightNum then
            bDone = true
            break
          end
        end
        if not bDone then
          bOk = true
          break
        end
      end
    end
    if not bOk then
      for k, costItem in pairs(info) do
        local storageCnt = 0
        if costItem.cost.type == PB.enum.ResourceType.ResItem then
          local costStock = DB:GetData("fci/item/" .. costItem.cost.id)
          if costStock then
            storageCnt = costStock.count
          end
        else
          storageCnt = DB:GetData("fci/resource/" .. PB.enum.ResourceType[v.cost.type] .. "_" .. v.cost.id)
        end
        local bHas = false
        if storageCnt >= costItem.cost.count then
          for i, v in ipairs(res.lightenCell) do
            if costItem.cellId == v then
              bHas = true
              break
            end
          end
          if not bHas then
            bOk = true
            break
          end
        end
      end
    end
  end
  return bFirst or bOk
end

function ACU.GetActivityUnlockLevel(type)
  return DB:GetData("UnlockWindowData")[WU.ActivityTypeToUnlockWindowType(type)] or 0
end

function ACU.IsActivityUnlocked(type)
  local requiredLevel = DB:GetData("UnlockWindowData")[WU.ActivityTypeToUnlockWindowType(type)] or 0
  return requiredLevel <= DB:GetData("fci/baseinfo").level
end

function ACU.GetNormalGachaTabId(activities)
  if activities == nil then
    return 1
  end
  for i, v in ipairs(activities) do
    if v.activityId == 0 then
      return i
    end
  end
  return 1
end

function ACU.MarkActivityViewed(type, id)
  local data = DB:GetData("activityViewed") or {}
  if data[type] and data[type][id] and data[type][id].repointValue then
    return
  end
  data[type] = data[type] or {}
  data[type][id] = {
    redpointId = id,
    redpointType = type,
    redpointValue = true
  }
  DB:GameRequest("fci/redpoint/data"):Post(data[type][id], function()
    DB:SetData("activityViewed", data)
  end)
end

function ACU.ReplaceIconRes(iconId)
  local allActivities = CS.DataBindingManager.Instance:GetData("ActivityList")
  local replaceIcon
  if allActivities == nil then
    return
  end
  for _, activity in pairs(allActivities) do
    if activity.type == PB.enum.ActivityType.ChangeIcon then
      if not ACU.IsOpenForDoing(activity) then
        return
      end
      local replaceInfo = PB.get("ActivityItemIconInfo", activity.activityId)
      if replaceInfo == nil then
        warning("ActivityItemIconInfo", "No ActivityId:" .. activity.activityId)
        return
      end
      local iconInfos = replaceInfo.iconInfos
      if iconInfos == nil then
        return
      end
      for i = 1, #iconInfos do
        if iconInfos[i].id == iconId then
          replaceIcon = iconInfos[i].resIcon
        end
      end
    end
  end
  return replaceIcon
end

function ACU.IsInCultivationPVPActivity(dungeonId)
  local S = require("Common/Singleton")
  local dungeon2activity = DB:GetData("dungeon2cultivationPVPActivityId")
  return ACU.IsOpenForDoing(S:Get("ActivityManager").GetActivitySync(PB.enum.ActivityType.CultivationPvP, dungeon2activity[dungeonId]))
end

function ACU.RenderLeftTime(time)
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

return ACU
