local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local S = require("Common/Singleton"):Register(_ENV, "ActivityManager")
local U = require("Common/Util")
local IU = require("Common/ItemUtil")
local m_activityList
local m_activityStatus = {}
local m_updateTimer = 0
local m_coroutine, m_mapActivity
local m_welfareActivityPath = {
  [PB.enum.ActivityType.TenCheckin] = "fci/activity-signin",
  [PB.enum.ActivityType.EveryDayCheckin] = "everydaysignin",
  [PB.enum.ActivityType.HalfYearBack] = "fci/half-year-back-activity/",
  [PB.enum.ActivityType.Lottery] = "Time/Welfare/Lottery"
}
local m_curDay
local m_minPreOpenTimeList = {}

function Start()
  this:Bind("fci/activity/", OnActivityListGet)
  m_coroutine = this:RepeatInvokeInSeconds(5, function()
    CoroUpdate()
  end)
end

function Update()
  RefreshCNYResearchResult()
end

function OnActivityListGet(info)
  if info then
    m_activityList = {}
    m_minPreOpenTimeList = {}
    for key, activity in pairs(info) do
      if activity.type == 0 and activity.activityId == 0 then
        table.insert(m_minPreOpenTimeList, activity.preOpenTime)
      else
        table.insert(m_activityList, activity)
      end
    end
    m_minPreOpenTimeList = table.distinct(m_minPreOpenTimeList)
    table.sort(m_minPreOpenTimeList, function(a, b)
      return a < b
    end)
    m_mapActivity = {}
    for k, v in pairs(m_activityList) do
      local activityList = m_mapActivity[v.type]
      if activityList == nil then
        activityList = {}
        m_mapActivity[v.type] = activityList
      end
      table.insert(activityList, v)
    end
    this:SetData("ActivityList", m_activityList)
  end
end

function GetLocalWeekDay(day)
  local temp = string.format("PVPREALRACE_WEEK%d", day)
  return WU.GetString(temp)
end

function GetActivityByType(type, call, failCall)
  if m_mapActivity == nil then
    DB:GameRequest("fci/activity/"):Get(function(activityResp)
      DB:SetData("fci/activity/", activityResp)
      if call and m_mapActivity ~= nil then
        call(m_mapActivity[type])
      elseif failCall then
        failCall()
      end
    end, function()
      if failCall then
        failCall()
      end
    end)
  elseif call then
    call(m_mapActivity[type])
  end
end

function GetActivitiesByTypeSync(type)
  if m_mapActivity then
    return m_mapActivity[type]
  end
end

function GetActivitySync(type, id)
  local activityList = GetActivitiesByTypeSync(type)
  if activityList then
    for i = 1, #activityList do
      if activityList[i].activityId == id then
        return activityList[i]
      end
    end
  end
end

function GetActivityRedByType(type, call)
  if type == PB.enum.ActivityType.ActivityType_DiffActorInherit then
    GetActivityByType(type, function(acList)
      if acList and acList[1] and ACU.IsOpenForDoing(acList[1]) == true then
        local yes = WU.GetGameDataCache("HasDecrepitTransportRedMark")
        if yes == nil or yes == "" then
          yes = true
          call(yes)
          WU.SetGameDataCache("HasDecrepitTransportRedMark", yes)
        elseif yes == true then
          call(yes)
        else
          call(false)
        end
      else
        if call then
          call(false)
        end
        WU.SetGameDataCache("HasDecrepitTransportRedMark", nil)
      end
    end)
  elseif type == PB.enum.ActivityType.ActivityType_ConditionReward then
    GetActivityByType(type, function(acList)
      DB:GameRequest("fci/conditionreward"):Get(function(res)
        local shouldActiveCondition = res.hasRewardQualification and not res.isRewardGot
        DB:SetData("shouldActiveCondition", shouldActiveCondition)
        if shouldActiveCondition then
          DB:SetData("ConditionReward", res.manualBoxReward)
          if acList and acList[1] and ACU.IsOpenForDoing(acList[1]) == true then
            local yes = WU.GetGameDataCache("HasConditionRewardRedMark")
            if yes == nil or yes == "" then
              yes = true
              call(yes)
              WU.SetGameDataCache("HasConditionRewardRedMark", yes)
            elseif yes == true then
              call(yes)
            else
              call(false)
            end
          else
            if call then
              call(false)
            end
            WU.SetGameDataCache("HasConditionRewardRedMark", nil)
          end
        end
      end)
    end)
  end
end

function IsActivityReallyOpen(activiytType)
  local theActivity
  local isOpen = false
  GetActivityByType(activiytType, function(activityList)
    if activityList then
      local activity = activityList[1]
      if ACU.IsOpenForDoing(activity) == true then
        theActivity = activity
        isOpen = true
      end
    end
  end)
  return isOpen, theActivity
end

function GetActivitiesStatus(type)
  local acList = GetActivitiesByTypeSync(type)
  local res = {}
  if acList then
    for _, ac in ipairs(acList) do
      res[ac.activityId] = m_activityStatus[ac.type .. "_" .. ac.activityId] or ACU.GetStatus(ac)
    end
  end
  return res
end

function GetByActivityOpen(type, call, bCloseTime)
  GetActivityByType(type, function(acList)
    if acList then
      local ac = acList[1]
      if ac and ACU.IsOpenForDoing(ac, bCloseTime) == true and call then
        call()
      end
    end
  end)
end

function GetTimeLimitExtraReward(extraData, callback)
  if m_activityList then
    HandleTimeLimitExtraReward(extraData, callback, m_activityList)
  else
    DB:GameRequest("fci/activity/"):Get(function(activityResp)
      DB:SetData("fci/activity/", activityResp)
      HandleTimeLimitExtraReward(extraData, callback, activityResp)
    end)
  end
end

function HandleTimeLimitExtraReward(extraData, callback, activityList)
  local res = {}
  local rules = PB.all("ActivityExtraRewardRule"):where(function(_, rule)
    local isEnable = false
    for i = 1, #activityList do
      local activity = activityList[i]
      if rule.ruleId == activity.activityId then
        local status = ACU.GetStatus(activity)
        if status == PB.enum.ActivityStatus.Started then
          isEnable = true
          break
        else
          print("GetTimeLimitExtraReward", rule.ruleId .. " is not in open list")
          return false
        end
      end
    end
    return isEnable and rule.type ~= nil and (rule.type == PB.enum.ActivityExtraRewardRuleType.Dungeon_Any and extraData.dungeonId or rule.type == extraData.type)
  end):toarray()
  for i = 1, #rules do
    local rule = rules[i]
    local dropCondition = rule.dropConditionType
    if dropCondition == PB.enum.ActivityExtraRewardRuleDropConditionType.Dungeon_ExtraRewardGroups then
      local dungeonId = extraData.dungeonId
      local dungeonReward, conditions
      if dungeonId then
        dungeonReward = PB.get("DungeonReward", dungeonId)
        conditions = rule.dropConditionParams
      end
      if dungeonReward and dungeonReward.extraRewardGroups and #dungeonReward.extraRewardGroups > 0 and conditions and 0 < #conditions then
        local rewardGroup = dungeonReward.extraRewardGroups
        local isAdded = false
        for k1, condition in pairs(conditions) do
          if isAdded then
            break
          end
          for k2, rGroup in pairs(rewardGroup) do
            if rGroup == condition then
              AddDungeonExtraDrop(rule, res)
              isAdded = true
              break
            end
          end
        end
      end
    elseif dropCondition == PB.enum.ActivityExtraRewardRuleDropConditionType.Dungeon_Range then
      local dungeonId = extraData.dungeonId
      local minRange = rule.dropConditionParams[1]
      local maxRange = rule.dropConditionParams[2]
      if dungeonId and dungeonId >= minRange and dungeonId <= maxRange then
        AddDungeonExtraDrop(rule, res)
      end
    elseif dropCondition == PB.enum.ActivityExtraRewardRuleDropConditionType.Dungeon_OutOfRange then
      local dungeonId = extraData.dungeonId
      local minRange = rule.dropConditionParams[1]
      local maxRange = rule.dropConditionParams[2]
      if dungeonId and dungeonId < minRange or dungeonId > maxRange then
        AddDungeonExtraDrop(rule, res)
      end
    elseif extraData.type == PB.enum.ActivityExtraRewardRuleType.AsyncPVP then
      if extraData.winNum == rule.dropConditionParams[1] then
        AddDungeonExtraDrop(rule, res)
      end
    elseif extraData.type == PB.enum.ActivityExtraRewardRuleType.Dungeon_SemiFixed then
      local dungeonId = extraData.dungeonId
      local minRange = rule.dungeonStart
      local maxRange = rule.dungeonEnd
      if dungeonId and dungeonId >= minRange and dungeonId <= maxRange then
        AddDungeonExtraDrop(rule, res)
      end
    elseif extraData.type == PB.enum.ActivityExtraRewardRuleType.Dungeon_Team then
      AddDungeonExtraDrop(rule, res)
    elseif extraData.type == PB.enum.ActivityExtraRewardRuleType.Dungeon_Gold then
      AddDungeonExtraDrop(rule, res)
    elseif IsInDungeonRule(rule, extraData.dungeonId) then
      local subChapter = -1
      if extraData.chapterId ~= nil then
        local chapterInfo = PB.get("ChapterInfo", extraData.chapterId)
        if chapterInfo then
          for id = 1, #chapterInfo.dungeonId do
            if chapterInfo.dungeonId[id] == extraData.dungeonId then
              subChapter = id
              break
            end
          end
        end
      end
      if dropCondition == PB.enum.ActivityExtraRewardRuleDropConditionType.Dungeon_All then
        AddDungeonExtraDrop(rule, res)
      elseif dropCondition == PB.enum.ActivityExtraRewardRuleDropConditionType.Dungeon_SingleDouble then
        local isOdd = rule.dropConditionParams[1] == 1
        local chapterIsOdd = subChapter % 2 == 1
        if isOdd == chapterIsOdd then
          AddDungeonExtraDrop(rule, res)
        end
      elseif dropCondition == PB.enum.ActivityExtraRewardRuleDropConditionType.Dungeon_Special then
        local min = rule.dropConditionParams[1]
        local max = rule.dropConditionParams[2]
        if subChapter >= min and subChapter <= max then
          AddDungeonExtraDrop(rule, res)
        end
      elseif dropCondition == PB.enum.ActivityExtraRewardRuleDropConditionType.TaskActivePointReward then
        if extraData.activePoint == rule.dropConditionParams[1] then
          AddDungeonExtraDrop(rule, res)
        end
      elseif dropCondition == PB.enum.ActivityExtraRewardRuleDropConditionType.Dungeon_WithCouple then
        if rule.dropConditionParams == nil or rule.dropConditionParams[1] == nil then
          AddDungeonExtraDrop(rule, res)
        else
          local dungeonId = extraData.dungeonId
          local definition = {"InRange", "OutRange"}
          local isInRange = fif(definition[rule.dropConditionParams[1]] == "InRange", true, false)
          local minRange = rule.dropConditionParams[2]
          local maxRange = rule.dropConditionParams[3]
          if dungeonId and (isInRange and dungeonId >= minRange and dungeonId <= maxRange or not isInRange and (dungeonId < minRange or dungeonId > maxRange)) then
            AddDungeonExtraDrop(rule, res)
          end
        end
      else
        error("ActivityExtraRewardRule dropCondition is not implemented:" .. dropCondition, table.dump(rule))
      end
    end
  end
  IU.RemoveExtraRewards(res)
  callback(res)
end

function AddDungeonExtraDrop(rule, dropList)
  local drop = rule.dropDisplay
  for d = 1, #drop do
    table.insert(dropList, drop[d])
  end
end

function IsInDungeonRule(rule, dungeonId)
  if dungeonId ~= nil and rule.dungeonStart ~= 0 and rule.dungeonEnd ~= 0 then
    return dungeonId >= rule.dungeonStart and dungeonId <= rule.dungeonEnd
  end
  return true
end

function CoroUpdate()
  local nowDay = CS.GameTime.serverNow.Day
  if m_curDay == nil then
    m_curDay = nowDay
  elseif m_curDay ~= nowDay then
    m_curDay = nowDay
    this:BroadcastGameEvent("NewDayCome0")
  end
  if m_activityList then
    for _, v in pairs(m_activityList) do
      local key = v.type .. "_" .. v.activityId
      local curStatus = ACU.GetStatus(v)
      local oldStatus = m_activityStatus[key]
      m_activityStatus[key] = curStatus
      if oldStatus ~= nil and oldStatus ~= curStatus then
        this:BroadcastGameEvent("ActivityStatusChanged", v.category, v.activityId, curStatus, v.type, v)
        if curStatus == PB.enum.ActivityStatus.Started then
          if v.type == PB.enum.ActivityType.Warmup_Chapter then
            DB:SyncRemote(DB:GameRequest("fci/warmup/"))
          elseif v.type == PB.enum.ActivityType.Theme then
            DB:SyncRemote(DB:GameRequest("fci/task/extra-activepoint/"))
          elseif v.type == PB.enum.ActivityType.MaidCafe_RankMode then
            DB:SyncRemote(DB:GameRequest("fci/maidcafe/rank-mode"))
            DB:SyncRemote(DB:GameRequest("fci/maidcafe/rank-mode/pass-reward/"))
          end
        end
      end
      local dataPath = m_welfareActivityPath[v.type]
      if dataPath then
        local detail = this:GetData(dataPath)
        if detail then
          if v.type == PB.enum.ActivityType.TenCheckin and detail.GetDay ~= CS.GameTime.serverNow.Day then
            detail.GetDay = CS.GameTime.serverNow.Day
            if curStatus == PB.enum.ActivityStatus.Started and detail.day < 10 and detail.signed then
              detail.day = detail.day + 1
              detail.signed = false
              this:SetData(dataPath, detail)
              RU.SetRedMark("Welfare/TenCheckin", not detail.signed)
            end
          end
          if v.type == PB.enum.ActivityType.EveryDayCheckin and ACU.IsOpenForDoing(v) and detail.day ~= CS.GameTime.serverNow.Day then
            detail.day = CS.GameTime.serverNow.Day
            if detail.nowDay <= detail.allDayCount then
              detail.nowDay = detail.nowDay + 1
              this:SetData(dataPath, detail)
              if 1 < detail.nowDay then
                RU.SetRedMark("Welfare/EveryDayCheckin", true)
              end
            end
          end
          if v.type == PB.enum.ActivityType.HalfYearBack and ACU.IsOpenForDoing(v) then
            local misc = PB.index("Misc", 1)
            local res = this:GetData("fci/half-year-back-activity/")
            if res == nil then
              return
            end
            local activeTime = CS.GameTime.UtcToLocal(res.activeTime)
            local activeDay24 = CS.System.DateTime(activeTime.Year, activeTime.Month, activeTime.Day, 0, 0, 0):AddDays(1)
            local signStep = res.signStep
            local m_allRewardsList = PB.all("ActivitySigninGift"):where(function(k, tv)
              return tv.activityId == v.activityId
            end):toarray()
            local endDoTime = activeDay24:AddDays(misc.halfYearBackDuration)
            local endTime = activeDay24:AddDays(misc.halfYearBackDuration + misc.halfYearBackShowDay)
            if endTime > CS.GameTime.serverNow then
              if endDoTime > CS.GameTime.serverNow then
                local oldTime = this:GetData("HalfYearBackSigninTime")
                if oldTime == nil then
                  oldTime = CS.GameTime.serverUtc
                  this:SetData("HalfYearBackSigninTime", oldTime)
                elseif signStep < #m_allRewardsList then
                  if CS.GameTime.IsSameDate(oldTime, CS.GameTime.serverUtc) then
                    this:SetData("HalfYearBackSigninTime", CS.GameTime.serverUtc)
                  else
                    this:SetData(dataPath, detail)
                    this:SetData("HalfYearBackSigninTime", CS.GameTime.serverUtc)
                  end
                end
              else
                RU.SetRedMark("Welfare/HalfYearBack/Signin/", false)
                this:SetData("halfyearbackcando", false)
              end
            else
              this:SetData("fci/half-year-back-activity/", nil)
              this:BroadcastGameEvent("ActivityStatusChanged", v.category, v.activityId, PB.enum.ActivityStatus.Close, v.type)
            end
          end
          if v.type == PB.enum.ActivityType.Lottery then
            if ACU.IsOpenForDoing(v) then
              if CS.GameTime.serverNow.Day == detail.nextUpdateTime.Day and CS.GameTime.serverNow.Hour == 6 then
                local nextUpdateTime = CS.GameTime.serverNow:AddDays(1)
                this:SetData("Time/Welfare/Lottery", {nextUpdateTime = nextUpdateTime})
                this:BroadcastGameEvent("ActivityLotteryANewDay")
                RU.SetRedMark("Welfare/Lottery", true)
                this:SetData("Welfare/Lottery", nil)
              end
            elseif oldStatus ~= curStatus then
              RU.SetRedMark("Welfare/Lottery", false)
            end
          end
        end
      end
    end
    local preOpenTimeReachedIndex = 0
    local serverUtc = CS.GameTime.serverUtc
    if 0 < #m_minPreOpenTimeList then
      for i = 1, #m_minPreOpenTimeList do
        if serverUtc >= m_minPreOpenTimeList[i] then
          preOpenTimeReachedIndex = i
        else
          break
        end
      end
    end
    if 0 < preOpenTimeReachedIndex then
      for i = preOpenTimeReachedIndex, 1, -1 do
        table.remove(m_minPreOpenTimeList, i)
      end
      DB:GameRequest("fci/activity-preopen"):Get(function(newOpenActivityList)
        if newOpenActivityList and 0 < #newOpenActivityList then
          for k, v in pairs(newOpenActivityList) do
            if v.type == 0 and v.activityId == 0 then
              error("Debug", "activity-preopen gets invalid activities.")
            else
              local ac = GetActivitySync(v.type, v.activityId)
              local activityList = m_mapActivity[v.type]
              if activityList == nil then
                activityList = {}
                m_mapActivity[v.type] = activityList
              end
              if ac == nil then
                table.insert(m_activityList, v)
                table.insert(activityList, v)
              end
            end
          end
          this:SetData("ActivityList", m_activityList)
        end
      end)
    end
    local opened = false
    local surpriseEventInfo = this:GetData("surpriseEventInfo")
    if surpriseEventInfo and surpriseEventInfo.surpriseEvent then
      local info = surpriseEventInfo.surpriseEvent
      local expireTime = info.expireTime
      local lastTriggerTime = CS.GameTime.UtcToLocal(info.lastTriggerTime)
      local timeNow = CS.GameTime.serverNow
      local endTime = lastTriggerTime:AddSeconds(expireTime)
      if timeNow < endTime then
        opened = true
      else
        opened = false
      end
    else
      opened = false
    end
    this:SetData("hasGiftSaku", opened)
  end
end

function RefreshCNYResearchResult()
  if m_mapActivity == nil then
    return
  end
  local acs = m_mapActivity[PB.enum.ActivityType.Cooking]
  if acs == nil then
    return
  end
  local status = m_activityStatus[acs[1].type .. "_" .. acs[1].activityId] or ACU.GetStatus(acs[1])
  if status ~= PB.enum.ActivityStatus.Started then
    return
  end
  local info = DB:GetData("HotPot/ResearchProgress")
  if info == nil then
    return
  end
  local oldflag = RU.GetRedMark("Welfare/ChineseNewYear/HotPot/Research/Result")
  local nowFlag = false
  local now = CS.GameTime.serverUtc
  for i = 1, 3 do
    if info[i] and now > info[i].researchEndTime and info[i].recipeGot == 0 then
      nowFlag = true
      break
    end
  end
  if oldflag ~= nowFlag then
    RU.SetRedMark("Welfare/ChineseNewYear/HotPot/Research/Result", nowFlag)
  end
end

function ProcessWhenActivityStartedOrFinished(activityType, callback)
  GetActivityByType(activityType, function(activity)
    local acStatus = PB.enum.ActivityStatus.None
    if activity and activity[1] then
      acStatus = ACU.GetStatus(activity[1])
    end
    if acStatus == PB.enum.ActivityStatus.Started or acStatus == PB.enum.ActivityStatus.Finished then
      callback()
    end
  end)
end

function IsRedForWlfQuestion(res)
  if res == nil then
    return false
  end
  local hasRed = false
  local canGetReward = false
  local canAnswer = false
  local config = PB.get("WelfareConfig", "QuestionReward")
  local activity = GetActivitySync(config.relatedActivityType, config.relatedActivityIds[1])
  if ACU.IsOpenForDoing(activity) and res then
    local info = PB.all("QuestionActivtyProcess")
    for i, v in ipairs(info) do
      local pos = table.find(res.gotProcess, function(k, v)
        return v == i
      end)
      if pos == nil and res.curProcess >= v.process then
        canGetReward = true
        break
      end
    end
    local info = PB.get("QuestionActivtyConfig", config.relatedActivityIds[1])
    local key = "fci/question/system/" .. config.relatedActivityIds[1]
    local activityData = this:GetData(key)
    local questionCount = info.refreshCount
    if activityData then
      questionCount = activityData.questionCount
    end
    local isEnoughCount = questionCount > res.dayAnwserTimes
    local costStock = this:GetData("fci/item/" .. info.questionActivtyCost.id)
    if costStock and costStock.count >= info.questionActivtyCost.count and isEnoughCount then
      canAnswer = true
    end
    hasRed = canAnswer or canGetReward
  end
  return hasRed
end
