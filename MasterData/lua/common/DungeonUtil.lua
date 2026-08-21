local DU = {}
local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local IU = require("Common/ItemUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local TLog = require("Common/TlogUtil")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local PU = require("Common/PlatformUtil")
local m_activityManager = S:Get("ActivityManager")
local ACU = require("Common/ActivityUtil")
local U = require("Common/Util")

function DU._IsDungeonUnlock(dungeonRecord)
  if dungeonRecord == nil then
    return false
  end
  local isOpen = true
  local strOpenTime
  local dunId = dungeonRecord.dungeonId
  local dungeonReward = PB.get("DungeonReward", dunId)
  if dungeonReward and dungeonReward.openTimeId and dungeonReward.openTimeId > 0 then
    local openInfo = PB.get("DungeonOpenTime", dungeonReward.openTimeId)
    if openInfo then
      local openTime = CS.GameTime.ServerTimeStrToUtc(openInfo.openTime)
      if openTime > CS.GameTime.serverUtc then
        isOpen = false
        strOpenTime = openInfo.openTime
      end
    end
  end
  if dungeonRecord.unlocked and isOpen then
    return true
  else
    return false, strOpenTime
  end
end

function DU.IsChapterUnlocked(chapterSummary, chapterId)
  if chapterId == nil then
    return false
  end
  local chapterInfo = PB.get("ChapterInfo", chapterId)
  if chapterInfo == nil then
    return false
  end
  local firstDunId = chapterInfo.firstDunId
  if firstDunId and 0 < firstDunId then
    local dungeonReward = PB.get("DungeonReward", firstDunId)
    if dungeonReward and dungeonReward.openTimeId and 0 < dungeonReward.openTimeId then
      local openInfo = PB.get("DungeonOpenTime", dungeonReward.openTimeId)
      if openInfo then
        local openTime = CS.GameTime.ServerTimeStrToUtc(openInfo.openTime)
        if openTime > CS.GameTime.serverUtc then
          return false, openInfo.openTime
        end
      end
    end
  end
  for _, unlockedId in pairs(chapterSummary.unlockedChapterId) do
    if unlockedId == chapterId or unlockedId == chapterInfo.storyChapterId or unlockedId == chapterInfo.trainingId then
      return true
    end
  end
  return false
end

function DU.IsDungeonUnlocked(chapterSummary, dungeonId, callback)
  local chapterId = DU.GetChapterId(dungeonId)
  if DU.IsChapterUnlocked(chapterSummary, chapterId) then
    local info = DB:GetData("fci/dungeon/chapter/" .. chapterId)
    local isUnlock = DU._IsDungeonUnlock(info.recordDungeons[dungeonId])
    callback(isUnlock)
  else
    callback(false)
  end
end

function DU.IsDungeonFinished(chapterSummary, dungeonId, callback)
  local chapterId = DU.GetChapterId(dungeonId)
  if DU.IsChapterUnlocked(chapterSummary, chapterId) then
    local info = DB:GetData("fci/dungeon/chapter/" .. chapterId)
    local dungeon = info.recordDungeons[dungeonId]
    local finished = false
    if dungeon then
      finished = dungeon.finished
    end
    callback(finished)
  else
    callback(false)
  end
end

function DU.IsChapterFinished(chapterSummary, chapterId)
  for _, finishedId in pairs(chapterSummary.finishedChapterId) do
    if finishedId == chapterId then
      return true
    end
  end
  return false
end

function DU.GetChapterRewards(chapterId)
  local rewards = PB.all("ChapterReward"):where(function(k, v)
    return v.chapterId == chapterId
  end):toarray()
  table.sort(rewards, function(a, b)
    return a.star < b.star
  end)
  return rewards
end

function DU.GetChapterId(dungeonId)
  local all = PB.all("ChapterInfo")
  for _, chapter in pairs(all) do
    if _ENV["!"](chapter.dungeonId):find(function(k, v)
      return v == dungeonId
    end) ~= nil then
      return chapter.chapterId
    end
  end
end

function DU.IsShowStar(dungeonId)
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  if dungeonReward then
    return #dungeonReward.target > 0
  end
  return false
end

function DU.DoesChapterHasStarReward(chapterRecord)
  local rewards = DU.GetChapterRewards(chapterRecord.chapterId)
  for _, reward in pairs(rewards) do
    local hasGot = table.has(chapterRecord.starRewardGot, reward.star)
    if not hasGot and (reward.star == 0 and chapterRecord.finished or reward.star > 0 and chapterRecord.totalStar >= reward.star) then
      return true
    end
  end
  return false
end

function DU.IsWaitingForJob(callback, noTips)
  local state = false
  if DU.IsWaitingForDungeonTeam(callback, noTips) then
    state = true
  elseif DU.IsWaitingPVPRank(callback, noTips) then
    state = true
  elseif DU.IsWatingPVPFriend(callback, noTips) then
    state = true
  end
  return state
end

function DU.IsWaitingForDungeonTeam(callback, noTips)
  local state = DB:GetData("DungeonTeam/OnFastJoin")
  if state and (noTips == nil or noTips == false) then
    local activityType = DB:GetData("DungeonTeamActivityType")
    local string1 = ""
    if activityType and activityType == PB.enum.ActivityType.DungeonTeamWelfare then
      string1 = "DungeonTeamWelfare_CancelWaitingHint"
    else
      string1 = "DungeonTeam_CancelWaitingHint"
    end
    WU.ShowMessageYesNo(WU.GetString(string1), function(result)
      if result == "YES" then
        local ui = WU.FindWindow("DungeonTeamFastJoin")
        if ui and ui.gameObject.activeSelf then
          _ENV["$"](ui)["$$CancelWaiting"](callback)
        end
      end
    end)
  end
  return state
end

function DU.IsWatingPVPFriend(callback, noTips)
  local state = DB:GetData("DungeonTeam/TopPvpFriendJoin")
  if state and (noTips == nil or noTips == false) then
    WU.ShowMessageYesNo(WU.GetString("TopPvpFriendJoin_CancelWaitingHint"), function(result)
      if result == "YES" then
        local ui = WU.FindWindow("TopPvpFriendJoin")
        if ui and ui.gameObject.activeSelf then
          _ENV["$"](ui)["$$CancelWaiting"](callback)
        end
      end
    end)
  end
  return state
end

function DU.IsWaitingPVPRank(callback, noTips)
  local state = DB:GetData("DungeonTeam/TopPvpJoin")
  if state and (noTips == nil or noTips == false) then
    WU.ShowMessageYesNo(WU.GetString("TopPvpJoin_CancelWaitingHint"), function(result)
      if result == "YES" then
        local ui = WU.FindWindow("TopPvpJoin")
        if ui and ui.gameObject.activeSelf then
          _ENV["$"](ui)["$$CancelWaiting"](callback)
        end
      end
    end)
  end
  return state
end

function DU.Restart()
  DB:SetData("FightInfo/Aura", nil)
  local dungeonId = DB:GetData("WindowDungeon/DungeonId")
  local fightDungeonType = DB:GetData("FightDungeonType")
  
  local function EnterDungeon(result)
    if CS.FightBase.Instance ~= nil then
      DB:SetData("Dungeon/DungeonUid", result.dungeonUid)
      DBH.ResChange(result.resChange)
      WU.SyncActorAttr(result.baseInfo)
      CS.FightBase.Instance:LeaveGameLua(tostring(dungeonId))
    end
  end
  
  DB:GameRequest("fci/dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    local param = DB:GetData("WindowDungeon/EnterParam")
    if fightDungeonType == PB.enum.DungeonType.Training or fightDungeonType == PB.enum.DungeonType.Challenge or fightDungeonType == PB.enum.DungeonType.Story then
      DB:GameRequest("fci/dungeon/"):Post({dungeonId = dungeonId}, EnterDungeon)
    elseif fightDungeonType == PB.enum.DungeonType.Normal then
      local wireFormatTable = ProtobufT("ApiDungeon", param)
      DB:GameRequest("fci/dungeon/"):Post(wireFormatTable, EnterDungeon)
    elseif fightDungeonType == PB.enum.DungeonType.WeekActivity then
      local wireFormatTable = ProtobufT("ApiActivityDungeon", param)
      DB:GameRequest("fci/activity-dungeon/"):Post(wireFormatTable, EnterDungeon)
    elseif fightDungeonType == PB.enum.DungeonType.Gold then
      local wireFormatTable = ProtobufT("ApiGoldDungeon", param)
      DB:GameRequest("fci/gold-dungeon/"):Post(wireFormatTable, EnterDungeon)
    elseif fightDungeonType == PB.enum.DungeonType.AssistGuild or fightDungeonType == PB.enum.DungeonType.ChallengeGuild then
      local guildId = DB:GetData("guildId")
      if guildId == nil or guildId == 0 then
        DU.LeaveDungeon(3)
      else
        local wireFormatTable = ProtobufT("ApiGuildDungeon", param)
        DB:GameRequest("fci/guild-dungeon/v2"):Post(wireFormatTable, EnterDungeon)
      end
    end
  end)
end

function DU.SendAutoFightSetting()
  local param = {
    configureSkills = DB:GetData("fci/autoFightSetting/")
  }
  DB:GameRequest("fci/auto-fight-conf/"):Post(param, function(result)
    DB:SetData("fci/autoFightSetting/", result.banedSkills)
  end)
end

function DU.IsAutoFightOpen(dungeonType)
  if dungeonType == 0 or dungeonType == nil then
    return false
  end
  local m_autoData = DB:GetData("fci/autoFightSetting/") or {}
  local auto_val = m_autoData["1"]
  local isAutoFight = false
  if auto_val ~= nil then
    isAutoFight = 1 << tonumber(dungeonType) & auto_val ~= 0
    return isAutoFight
  end
  return false
end

function DU.SetAutoFight(dungeonType, open)
  if dungeonType == 0 or dungeonType == nil then
    return
  end
  local m_autoData = DB:GetData("fci/autoFightSetting/") or {}
  local cur_val = m_autoData["1"] or 0
  local cur_auto = 1 << tonumber(dungeonType)
  if open then
    m_autoData["1"] = cur_val | cur_auto
  else
    m_autoData["1"] = cur_val & ~cur_auto
  end
  DB:SetData("fci/autoFightSetting/", m_autoData)
end

function EndRecordVideo()
  if PU.IsRecordVideoEnabled() then
    local isRecording = CS.RecordVideoManager.Instance:isRecordingMoments()
    if isRecording then
      CS.RecordVideoManager.Instance:EndMomentsRecording(function(status)
        if status == CS.GameJoyAPI.RecordingStartStatus.Fail then
          warning("Debug", "record end error")
        end
      end)
    end
  end
end

function DU.CreateResetList()
  DU.AddToResetListExitGame("Assistant/Aura", nil)
  DU.AddToResetListExitGame("FightInfo/Aura", nil)
  DU.AddToResetListExitGame("IsCultivationPVPMode", false)
  DU.AddToResetListExitGame("CultivationPVPFromWelfare", false)
  DU.AddToResetListExitGame("FightActorInfoSynced", false)
  DU.AddToResetListExitGame("Event/ActivityType", nil)
  DU.AddToResetListExitGame("BalanceInfo/Groups", nil)
  DU.AddToResetListExitGame("FightBuffAffix", nil)
  DU.AddToResetListExitGame("RandomCall/UpdateAble", nil)
  DU.AddToResetListExitGame("SemiFixedChapterIn", nil)
end

function DU.LeaveDungeon(leaveFrom, windowParam)
  if leaveFrom == 3 then
    CS.SoundManager.Instance:StopCurrentMusic()
    DU.SendAutoFightSetting()
  end
  if PU.IsRecordVideoEnabled() then
    EndRecordVideo()
    CS.RecordVideoManager.Instance:CancelGenerateMomentsVideo()
    CS.RecordVideoManager.Instance:CloseGenerateMomentsVideoDialog()
  end
  TLog.RecordLeaveDungeon(leaveFrom)
  local eventActivityType = DB:GetData("Event/ActivityType")
  if eventActivityType then
    DB:SetData("Event/ActivityType", nil)
    DB:SetData("Event/ActivityId", nil)
    LeaveEvent(leaveFrom, eventActivityType, windowParam)
    return
  end
  local dungeonType = DB:GetData("FightDungeonType")
  if dungeonType == PB.enum.DungeonType.BurstLinkPvp then
    LeaveBurstLinkPvp(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.RacePVP then
    LeaveRacePvp(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.TeamPve then
    LeaveTeamPve(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.AsyncPvp then
    LeaveAsyncPvp(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.FriendPvp then
    LeaveTopPVPFriend(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.Tower then
    DU.LeaveTower(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.TowerNew then
    DU.LeaveTowerNew(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.WeekActivity then
    LeaveWeekActivity(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.Gold then
    LeaveGold(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.Normal then
    local isCultivationPVPModeThisTime = DB:GetData("IsCultivationPVPMode")
    local cultivationPVPFromWelfare = DB:GetData("CultivationPVPFromWelfare")
    LeaveNormal(leaveFrom, isCultivationPVPModeThisTime, cultivationPVPFromWelfare)
  elseif dungeonType == PB.enum.DungeonType.Story then
    LeaveStory(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.Training then
    local isCultivationPVPModeThisTime = DB:GetData("IsCultivationPVPMode")
    local cultivationPVPFromWelfare = DB:GetData("CultivationPVPFromWelfare")
    LeaveNormal(leaveFrom, isCultivationPVPModeThisTime, cultivationPVPFromWelfare)
    LeaveTraining(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.Challenge then
    LeaveChallenge(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.Maze then
    LeaveMaze(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.Triggered then
    LeaveTriggered(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.AssistGuild or dungeonType == PB.enum.DungeonType.ChallengeGuild then
    LeaveGuild(leaveFrom, windowParam)
  elseif dungeonType == PB.enum.DungeonType.SemiFixed then
    LeaveSemiFixed(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.MaidCafe then
    LeaveMaidCafe(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.AsyncPvpV2 then
    LeaveAsyncPvpNew(leaveFrom)
  elseif dungeonType == PB.enum.DungeonType.RD then
    LeaveRandomCall(leaveFrom)
  else
    error("GamePlay", "no dungeonType = " .. dungeonType)
  end
end

function LeaveGame(windowParam, leaveFrom)
  DU.CreateResetList()
  DU.ResetFlagExitGame()
  if leaveFrom == 3 then
    WU.SaveCitySceneContext(windowParam)
    CS.FightBase.Instance:LeaveGameLua("SceneCity")
  else
    WU.ReturnCity(windowParam)
  end
end

function LeaveTopPVPFriend(leaveFrom)
  local windowParam = DB:GetData("RecordReturnWindow")
  if windowParam == nil then
  end
  DB:SetData("RecordReturnWindow", nil)
  if leaveFrom == 3 then
    DB:GameRequest("fci/friendpvp/balance/{Dungeon/DungeonUid}"):Post({}, function(response)
      DB:SetData("DungeonBalance/result", response)
      LeaveGame(windowParam, leaveFrom)
    end)
  else
    LeaveGame(windowParam, leaveFrom)
  end
end

function LeaveSemiFixed(leaveFrom)
  DB:GameRequest("fci/semifixed-dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    LeaveGame("Welfare, EventCarnival91Stage", leaveFrom)
  end)
end

function LeaveBurstLinkPvp(leaveFrom)
  if leaveFrom == 3 then
    DB:GameRequest("fci/BurstLinkDunBalance/"):Post({}, function(response)
      DB:SetData("DungeonBalance/result", response)
      CS.FightBase.Instance:LeaveGameLua("SceneBalance")
    end)
  else
    LeaveGame("Activity, BurstLinkActorGroup", leaveFrom)
  end
end

function DU.LeavePVPNetDungeon()
  WU.SetLockFlag(WU.LockInputFlag.SceneLoading, true)
  local postData = {
    dungeonId = DB:GetData("Dungeon/DungeonUid")
  }
  DB:WebSocketSendLua(CS.Restifizer.WebSocketTag.FightService, "CsLeaveDungeonReq", postData)
end

function LeaveRacePvp(leaveFrom)
  if leaveFrom == 3 then
    local fightLuaTable = ProtobufT("FightActiveData", CS.FightLuaLogic.Instance.FightLuaTable)
    DB:GameRequest("fci/dungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
      DB:GameRequest("fci/racepvp-dungeon/{Dungeon/DungeonUid}/balance/"):Post({}, function(response2)
        DB:SetData("DungeonBalance/result", response2)
        CS.FightBase.Instance:LeaveGameLua("SceneBalance")
      end)
    end)
  else
    DB:GameRequest("fci/racepvp-dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
      LeaveGame("Activity, RacePVP", leaveFrom)
    end)
  end
end

function LeaveEvent(leaveFrom, activityType, overrideWindowP)
  DB:GameRequest("fci/event-dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    local newTriggeredEvent = DB:GetData("TriggeredEvent/New")
    local windowParam = ""
    if activityType == PB.enum.ActivityType.EventDungeon_Autumn2018 then
      windowParam = "Activity, EventAutumnStage"
    elseif activityType == PB.enum.ActivityType.EventDungeon_Autumn2018Hard then
      windowParam = "Activity, EventAutumnStageHard"
    elseif activityType == PB.enum.ActivityType.Carnival91 then
      windowParam = "Welfare, EventCarnival91Stage"
    elseif activityType == PB.enum.ActivityType.Christmas then
      windowParam = "Welfare,EventChristmasStage,EventChristmasStageChapter"
      DB:SetData("WelfareTab", "Christmas")
    elseif activityType == PB.enum.ActivityType.ChineseNewYear then
      windowParam = "Welfare,EventCNYStage,EventCNYStageChapter"
      DB:SetData("WelfareTab", "ChineseNewYear")
    elseif activityType == PB.enum.ActivityType.MaidCafe_DaemonMode then
      windowParam = "Welfare, EventMaidCafeStage"
      DB:SetData("WelfareTab", "MaidCafe")
    elseif activityType == PB.enum.ActivityType.Warmup_Chapter then
      windowParam = "Welfare, ArmWarmup"
      DB:SetData("WelfareTab", "ArmWarmup")
    else
      windowParam = "Activity, EventActivityStage"
    end
    if newTriggeredEvent ~= nil and leaveFrom == 1 then
      windowParam = "Activity, TriggeredEvent"
    elseif leaveFrom == 2 then
      local leaveInfo = DB:GetData("DungeonBalanceRecommendInfo")
      if leaveInfo and leaveInfo.gotoAble then
        DB:SetData("Actor/SelectedUid", leaveInfo.actor.uid)
        windowParam = windowParam .. ", ActorInfo"
      end
    end
    windowParam = fif(overrideWindowP ~= nil, overrideWindowP, windowParam)
    DB:SetData("EventDungeon/RewardUpdateAble", true)
    LeaveGame(windowParam, leaveFrom)
  end)
end

function LeaveTeamPve(leaveFrom)
  local newTriggeredEvent = DB:GetData("TriggeredEvent/New")
  local activityInfo = DB:GetData("Activity/CurrentActivity")
  local windowParam = "Activity, DungeonTeam"
  if activityInfo and activityInfo[1] and activityInfo[1].type == PB.enum.ActivityType.DungeonTeamWelfare then
    windowParam = "Welfare, DungeonTeam"
    DB:SetData("WelfareTab", "ChineseNewYear")
  end
  if newTriggeredEvent ~= nil and leaveFrom == 1 then
    windowParam = "Activity, TriggeredEvent"
  end
  LeaveGame(windowParam, leaveFrom)
end

function LeaveAsyncPvp(leaveFrom)
  local activityType = DB:GetData("fci/tournament/curActivityType")
  
  local function quit()
    DB:GameRequest("fci/tournament/dungeonquit/"):Post({activityType = activityType}, function(response)
      if response then
        LeaveGame("Activity, AsyncPvp", leaveFrom)
      end
    end)
  end
  
  if leaveFrom == 3 then
    local fightLuaTable = ProtobufT("FightActiveData", CS.FightLuaLogic.Instance.FightLuaTable)
    DB:GameRequest("fci/tournamentdungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function()
      DB:GameRequest("fci/tournament/dungeonbalance/"):Post({activityType = activityType}, quit)
    end)
  else
    quit()
  end
end

function DU.LeaveTower(leaveFrom, windowParam)
  DB:GameRequest("fci/tower-dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    if windowParam == nil then
      windowParam = "Activity,Tower"
      if leaveFrom == 3 then
        windowParam = "Activity,Tower,TowerActorGroup"
      end
    end
    LeaveGame(windowParam, leaveFrom)
  end)
end

function DU.LeaveTowerNew(leaveFrom, windowParam)
  DB:GameRequest("fci/extreme-challenge/{Dungeon/DungeonUid}"):Delete(function(response)
    local summary = DB:GetData("fci/extreme-challenge/summary/")
    if windowParam == nil then
      windowParam = "Activity, TowerNewPrepare"
    end
    if leaveFrom == 1 then
      DB:SetData("TowerNew/PillUpdateAble", true)
    end
    LeaveGame(windowParam, leaveFrom)
  end)
end

function LeaveWeekActivity(leaveFrom)
  DB:GameRequest("fci/activity-dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    local newTriggeredEvent = DB:GetData("TriggeredEvent/New")
    local windowParam = "Activity, ActivityStageChoose" .. DB:GetData("Activity/CurrentType")
    if newTriggeredEvent ~= nil and leaveFrom == 1 then
      windowParam = "Activity, TriggeredEvent"
    end
    if leaveFrom == 3 then
      windowParam = windowParam .. ", WeekActivityPrepare, ActivityActorGroup"
    elseif leaveFrom == 2 then
      local leaveInfo = DB:GetData("DungeonBalanceRecommendInfo")
      if leaveInfo and leaveInfo.gotoAble then
        DB:SetData("Actor/SelectedUid", leaveInfo.actor.uid)
        windowParam = windowParam .. ", ActorInfo"
      end
    end
    LeaveGame(windowParam, leaveFrom)
  end)
end

function LeaveNormal(leaveFrom, isCultivationPVPMode, cultivationPVPFromWelfare)
  DB:GameRequest("fci/dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    local newTriggeredEvent = DB:GetData("TriggeredEvent/New")
    local windowParam = "ChapterNormal"
    if leaveFrom == 1 then
      if newTriggeredEvent ~= nil then
        windowParam = "Activity, TriggeredEvent"
      elseif isCultivationPVPMode then
        DB:SetData("WelfareTab", "CultivationPvP")
        windowParam = fif(cultivationPVPFromWelfare, "Welfare", "ChapterNormal, DungeonStory")
      elseif DB:GetData("SemiFixedChapterIn") then
        windowParam = "ChapterNormal"
      end
    elseif leaveFrom == 2 then
      local leaveInfo = DB:GetData("DungeonBalanceRecommendInfo")
      if leaveInfo and leaveInfo.gotoAble then
        DB:SetData("Actor/SelectedUid", leaveInfo.actor.uid)
        windowParam = "ChapterNormal, ActorInfo"
      elseif DB:GetData("SemiFixedChapterIn") then
        windowParam = "ChapterNormal, DungeonStory, SemiFixedChapterActorGroup"
      end
    elseif leaveFrom == 3 then
      DB:SetData("NoNewChapterUnlocked", true)
      windowParam = "ChapterNormal, DungeonStory, " .. fif(isCultivationPVPMode, "ActorGroupCultivationPVP", "ActorGroup")
      if DB:GetData("SemiFixedChapterIn") then
        windowParam = "ChapterNormal, DungeonStory, SemiFixedChapterActorGroup"
      end
    end
    LeaveGame(windowParam, leaveFrom)
  end)
end

function LeaveStory(leaveFrom)
  DB:GameRequest("fci/dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    local windows = "ChapterNormal"
    if DB:GetData("Tutorial/ToCity") then
      windows = ""
      DB:SetData("Tutorial/ToCity", false)
    end
    LeaveGame(windows, leaveFrom)
  end)
end

function LeaveTraining(leaveFrom)
  DB:GameRequest("fci/dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    local windowParam = "ChapterNormal"
    if leaveFrom == 3 then
      windowParam = "ChapterNormal, DungeonTraining"
    end
    LeaveGame(windowParam, leaveFrom)
  end)
end

function LeaveChallenge(leaveFrom)
  DB:GameRequest("fci/dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    local windowParam = "Activity, ChapterChallenge, ChallengeDungeon"
    if leaveFrom == 3 then
      windowParam = "Activity, ChapterChallenge, ChallengeDungeon, DungeonTraining"
    end
    LeaveGame(windowParam, leaveFrom)
  end)
end

function LeaveMaze(leaveFrom)
  DB:GameRequest("fci/maze-dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    local mazeActivityId = DB:GetData("MazeActivityId")
    if mazeActivityId == 34001 then
      LeaveGame("Activity, MazeMain", leaveFrom)
    elseif mazeActivityId == 34002 then
      DB:SetData("WelfareTab", "Miku")
      LeaveGame("Welfare, MazeMain", leaveFrom)
    end
  end)
end

function LeaveTriggered(leaveFrom)
  DB:GameRequest("fci/triggered-dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    LeaveGame("Activity, TriggeredEvent", leaveFrom)
  end)
end

function LeaveGold(leaveFrom)
  DB:GameRequest("fci/gold-dungeon/{Dungeon/DungeonUid}"):Delete(function(response)
    local windowParam = "Activity, DungeonGold"
    if leaveFrom == 3 then
      windowParam = "Activity, DungeonGold, DungeonGoldActorGroup"
    end
    LeaveGame(windowParam, leaveFrom)
  end)
end

function LeaveGuild(leaveFrom, windowParam)
  DB:GameRequest("fci/guild-dungeon/v2/{Dungeon/DungeonUid}"):Delete(function(response)
    local guildId = DB:GetData("guildId")
    if guildId == nil or guildId == 0 then
      WU.ShowMessageOK(WU.GetString("Window_JustQuitGuild"), function(result)
        local wp = "RelationPortal,GuildPortal"
        LeaveGame(wp, leaveFrom)
      end)
    else
      local wp
      if windowParam and windowParam ~= "" then
        wp = windowParam
      elseif leaveFrom == 3 then
        wp = "RelationPortal, Guild, DungeonGuildStage, DungeonGuildPrepare"
      else
        wp = "RelationPortal, Guild, DungeonGuildStage"
      end
      LeaveGame(wp, leaveFrom)
    end
  end)
end

function LeaveMaidCafe(leaveFrom)
  DB:GameRequest("fci/dungeon-ex/{Dungeon/DungeonUid}"):Delete(function(response)
    DB:SetData("WelfareTab", "MaidCafe")
    local windowParam = "Welfare, MaidCafeRecruitMent"
    LeaveGame(windowParam, leaveFrom)
  end)
end

function LeaveAsyncPvpNew(leaveFrom)
  if leaveFrom == 3 then
    if DB:GetData("FightDataRecord") ~= nil then
      DB:SetData("FightDataRecord", nil)
      DB:SetData("FightRecordMode", nil)
      local windowParam = DB:GetData("AsyncPvpNewWindowParam")
      WU.ReturnCity(windowParam)
    else
      local fightLuaTable = ProtobufT("FightActiveData", CS.FightLuaLogic.Instance.FightLuaTable)
      DB:GameRequest("fci/dungeon-ex/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        DB:GameRequest("fci/dungeon-ex/{Dungeon/DungeonUid}/balance"):Post({}, function(response2)
          DB:SetData("DungeonBalance/result", response2.dungeonExBalanceResult)
          CS.FightBase.Instance:LeaveGameLua("SceneBalance")
        end)
      end)
    end
  else
    DB:GameRequest("fci/dungeon-ex/{Dungeon/DungeonUid}"):Delete(function(response)
      local windowParam = "Activity, AsyncPvpNew"
      LeaveGame(windowParam, leaveFrom)
    end)
  end
end

function LeaveRandomCall(leaveFrom, windowParam)
  DB:SetData("RandomCall/UpdateAble", true)
  if windowParam == nil then
    windowParam = "Activity, RandomCallJoin"
  end
  LeaveGame(windowParam, leaveFrom)
end

function DU.IsTowerAwardCanGet(towerSummary)
  local floorRewardInfo = PB.all("TowerFloorReward")
  for _, info in pairs(floorRewardInfo) do
    if info.towerFloor <= towerSummary.towerFloorRecord then
      local _, floor = table.find(towerSummary.rewardGot, function(_, v)
        return info.towerFloor == v
      end)
      if floor == nil then
        return true
      end
    end
  end
  return false
end

function DU.GetDungeonBalanceRewards(balance)
  local result = {}
  local expOverFlow = {}
  if not balance or not balance.resChange and not balance.expReturn then
    return _ENV["!"]({})
  else
    if balance and balance.resChange then
      result = IU.FlatInboxItems(balance.resChange):where(function(_, change)
        local target = change.baseRes or change.equip or change.actor
        return target and target.countDelta > 0 and (not target.baseRes or target.baseRes.type ~= PB.enum.ResourceType.ResPlayerExp)
      end):toarray()
    end
    if balance and balance.expReturn then
      expOverFlow = IU.FlatInboxItems(balance.expReturn):where(function(_, change)
        local target = change.baseRes
        return target and target.countDelta > 0 and (not target.baseRes or target.baseRes.type ~= PB.enum.ResourceType.ResPlayerExp)
      end):toarray()
      for i, v in pairs(expOverFlow) do
        v.isExpReturn = 1
        table.insert(result, v)
      end
    end
    return result
  end
end

function DU.GetDungeonBalanceExpOverFlow(balance)
  if balance and balance.expReturn then
    return IU.FlatInboxItems(balance.expReturn):where(function(_, change)
      local target = change.baseRes
      return target and target.countDelta > 0 and (not target.baseRes or target.baseRes.type ~= PB.enum.ResourceType.ResPlayerExp)
    end):toarray()
  else
    return _ENV["!"]({})
  end
end

function DU.CultivationReachExpection(members, m_dungeonId)
  local result = {}
  result.isReach = true
  local groupCul = 0
  local lowestCul, lowestMember
  for i = 1, #members do
    local member = members[i]
    local uid, actor
    if member.actorUid and member.actorUid ~= 0 then
      uid = member.actorUid
    end
    if uid == nil and member.uid ~= nil and member.uid ~= 0 then
      uid = member.uid
    end
    if member.isNpc then
      actor = PB.get("DungeonNPC", member.npcId)
      AU.RenameDungeonNPCFields(actor)
    elseif uid then
      actor = DB:GetData("fci/actor/" .. uid)
    end
    if actor then
      local actorCul = AU.GetActorCultivationDegree(actor)
      groupCul = groupCul + actorCul
      if (lowestCul == nil or lowestCul > actorCul) and actor.uid then
        lowestCul = actorCul
        lowestMember = actor
      end
    end
  end
  local expection = PB.get("DungeonReward", m_dungeonId).expectCulDegree
  if expection ~= nil and groupCul < expection then
    result.isReach = false
    result.suggest = lowestMember
  end
  result.suggest = lowestMember
  return result
end

function DU.ShowChallengeChapterUnlockHint(chapterId)
  local chapterInfo = PB.get("ChapterInfo", chapterId)
  if chapterInfo then
    local conditions = {preChapterFinished = false, challengeStarNumReached = false}
    local chapterSummary = DB:GetData("fci/dungeon/chapter-summary")
    conditions.preChapterFinished = DU.IsChapterFinished(chapterSummary, chapterInfo.preChapterId)
    conditions.challengeStarNumReached = chapterSummary.totalChallengeStar >= chapterInfo.dungeonTypeStar
    local text = ""
    if not conditions.preChapterFinished then
      text = WU.GetString("Training_dungeon_locked_by_chapter", chapterInfo.preChapterId)
    end
    if not conditions.challengeStarNumReached then
      if text ~= "" then
        text = text .. WU.GetString("Challenge_Lock_Conjunction")
      end
      text = text .. WU.GetString("Challenge_Star_Requirement", chapterInfo.dungeonTypeStar)
    end
    if text ~= nil and text ~= "" then
      WU.ShowHintText(text)
    end
  end
end

function DU.CanEnterGoldDungeon()
  local goldDungeonLevelInfo = PB.get("GoldDungeonLevel", DB:GetData("fci/baseinfo").level)
  if goldDungeonLevelInfo then
    local dungeonRewardInfo = PB.get("DungeonReward", goldDungeonLevelInfo.dungeonId)
    if dungeonRewardInfo then
      local cost = dungeonRewardInfo.costWin[1]
      if cost and DB:GetData("fci/item/" .. cost.id) and DB:GetData("fci/item/" .. cost.id).count >= cost.count then
        return true
      end
    end
  end
  return false
end

function DU.StoryChapterToNormal(storyId)
  local chapterInfos = PB.all("ChapterInfo")
  for i, v in ipairs(chapterInfos) do
    if v.storyChapterId == storyId then
      return v.chapterId
    end
  end
end

function DU.DoesEventActivityHasStarReward(rewardSummary, activityId)
  if rewardSummary == nil then
    return
  end
  local summary = rewardSummary[activityId]
  if summary then
    local starCnt = summary.totalStar
    local rewardGotCnt = #summary.rewardGot
    return rewardGotCnt < #PB.all("EventReward"):where(function(k, v)
      return v.activityId == activityId and v.star <= starCnt
    end):toarray()
  end
  return false
end

function DU.GetDungeonGoldLevel()
  local baseInfo = DB:GetData("fci/baseinfo")
  return PB.get("GoldDungeonLevel", baseInfo.level)
end

function DU.GetDungeonGoldCost()
  local goldLevel = DU.GetDungeonGoldLevel()
  local reward = PB.get("DungeonReward", goldLevel.dungeonId)
  if reward and #reward.costWin > 0 then
    return reward.costWin[1]
  end
end

function DU.SetDungeonTeamUrl(url)
  local lastTeamDungeonUrl = DB:GetData("fci/teamdungeonurl/")
  if lastTeamDungeonUrl ~= nil and lastTeamDungeonUrl ~= url then
    CS.Restifizer.RestifizerManager.Instance:StopWebSocket(CS.Restifizer.WebSocketTag.DungeonTeamService)
  end
  DB:SetData("fci/teamdungeonurl/", url)
  CS.Restifizer.RestifizerManager.Instance:SetDungeonTeamWebSocketUrl(url)
end

function DU.IsInDungeonTeamPrepare(callback)
  local dungeonTeamPrepare = WU.FindWindow("DungeonTeamPrepare")
  if dungeonTeamPrepare ~= nil then
    info("DungeonTeam", "dungeonTeamPrepare.gameObject.activeSelf : " .. tostring(dungeonTeamPrepare.gameObject.activeSelf))
  else
    info("DungeonTeam", "dungeonTeamPrepare is nil")
  end
  if (dungeonTeamPrepare == nil or not dungeonTeamPrepare.gameObject.activeSelf) and callback then
    callback()
  else
    WU.ShowHintText(WU.GetString("DungeonTeam_OnJoinDungeonTeam"))
  end
end

function DU.CultivationPVPRatioConvert(members, ratios)
  local reduceInfo = {}
  if members then
    for i = 1, 6 do
      if members[i].actorUid ~= 0 then
        local ratio = 1000
        if ratios then
          ratio = ratios[members[i].index] * 1000
        end
        reduceInfo[tostring(members[i].actorUid)] = ratio
      end
    end
  end
  return reduceInfo
end

function DU.GetChipDungeonList()
  local dungeonList = {}
  local allRewards = PB.all("DungeonReward"):where(function(k, v)
    local con = v.dropDisplayOutside and #v.dropDisplayOutside > 0 and v.isChipDungeon
    return con
  end)
  local allChapter = PB.all("ChapterInfo"):where(function(k, v)
    return v.type == PB.enum.DungeonType.Normal
  end):toarray()
  local culDungeon = PB.all("ChipDungeonToCultivationDungeon")
  for k, v in pairs(allRewards) do
    for key, val in pairs(allChapter) do
      local chipDun, _ = table.find(val.dungeonId, function(idx, dunId)
        return dunId == v.dungeonId
      end)
      local fake, _ = table.find(culDungeon, function(culIdx, culVal)
        return culVal.cultivationPVPDungeonId == v.dungeonId
      end)
      local chapterUnlock = DU.IsChapterUnlocked(DB:GetData("fci/dungeon/chapter-summary"), key)
      local exchangeInfo = DB:GetData("fci/chipexchange/")
      local reward = PB.get("DungeonReward", v.dungeonId)
      local outInfo = reward.dropDisplayOutside
      local acStatus
      if chipDun and not fake and chapterUnlock then
        S:Get("ActivityManager").GetActivityByType(PB.enum.ActivityType.ActorChipExchange, function(activity)
          if activity and activity[1] then
            acStatus = ACU.GetStatus(activity[1])
          end
          if exchangeInfo and acStatus and acStatus == PB.enum.ActivityStatus.Started then
            local _, tmpList = DU.ReplaceActorChip(v.dungeonId, outInfo)
            if tmpList then
              outInfo = tmpList
            end
          end
        end)
        table.insert(dungeonList, {
          dungeonId = v.dungeonId,
          chapterId = key,
          chapterIndex = val.chapterIndex,
          outInfo = outInfo
        })
      end
    end
  end
  table.sort(dungeonList, function(a, b)
    return a.dungeonId < b.dungeonId
  end)
  return dungeonList
end

function DU.GetActorChipList()
  local dungeonList = {}
  local allRewards = PB.all("DungeonReward")
  for k, v in pairs(allRewards) do
    if v.chipExchangePlayerPos ~= nil and v.chipExchangePlayerPos > 0 then
      table.insert(dungeonList, {
        dungeonId = v.dungeonId,
        posIndex = v.chipExchangePlayerPos
      })
    end
  end
  return dungeonList
end

function DU.ReplaceActorChip(dungeonId, dropDisplay)
  local chipId, tmpList, index
  local chipList = DU.GetActorChipList()
  local _, dungeon = table.find(chipList, function(key, val)
    return val.dungeonId == dungeonId
  end)
  if dungeon == nil then
    return
  end
  local chipInfo = DB:GetData("fci/chipexchange/")
  local chipId = chipInfo.exchangePosInfo[dungeon.posIndex]
  if chipId and chipId ~= 0 then
    tmpList = _ENV["!"]({})
    _ENV["!"](dropDisplay):copy(tmpList, true)
  else
    tmpList = dropDisplay
  end
  for k, v in pairs(tmpList) do
    local info = PB.get("ItemInfo", v.id)
    if info and info.funcType == PB.enum.ItemFuncType.ActorChips then
      index = k
      if chipId and chipId ~= 0 then
        tmpList[k].id = chipId
      end
    end
  end
  return chipId, tmpList, index
end

function DU.GetCultivationDungeonId(dungeonId)
  if PB.get("DungeonReward", dungeonId).enterTimes ~= 0 then
    return PB.get("ChipDungeonToCultivationDungeon", dungeonId) and PB.get("ChipDungeonToCultivationDungeon", dungeonId).cultivationPVPDungeonId
  else
    return dungeonId
  end
end

function DU.ResetFlagExitGame()
  local flagPar = DB:GetData("ExitGame/ResetFlag")
  if flagPar then
    for k, v in pairs(flagPar) do
      DB:SetData(k, v.resetState)
    end
  end
end

function DU.AddToResetListExitGame(databinding, resetState)
  local parent = fif(DB:GetData("ExitGame/ResetFlag") ~= nil, DB:GetData("ExitGame/ResetFlag"), {})
  if parent[databinding] == nil then
    parent[databinding] = {resetState = resetState}
  elseif resetState ~= parent[databinding].resetState then
    parent[databinding].resetState = resetState
  end
  DB:SetData("ExitGame/ResetFlag", parent)
end

function DU.GetDungeonPrice(dungeonId)
  local dungeonPrice
  if dungeonId then
    local dungeonReward = PB.get("DungeonReward", dungeonId)
    if dungeonReward then
      local price = dungeonReward.cost[1] or {count = 0}
      local priceWin = dungeonReward.costWin[1] or {count = 0}
      dungeonPrice = {
        type = price.type or priceWin.type,
        id = price.id or priceWin.id,
        count = price.count + priceWin.count
      }
    else
      warning("DungeonReward.xlsx", "Can't find dungeonId : " .. tostring(dungeonId))
    end
  end
  return dungeonPrice
end

function DU.IsPriceLegal(price)
  return price and price.count > 0 and price.type
end

function DU.IsSpecialTreasureDengeon(activityId, difficultyDungeonId)
  local m_difficultyTable = PB.get("ActivityDungeon", activityId).dungeonId
  local category = PB.get("ActivityDungeon", activityId).category
  return category == 2 and table.last(m_difficultyTable) == difficultyDungeonId
end

function DU.GetBalanceDungeon(dungeonId)
  local dungeon = PB.get("DungeonMonster", dungeonId)
  local balanceDungeon = dungeonId
  while dungeon.nextDungeonId and dungeon.nextDungeonId ~= 0 and dungeon.nextDungeonId ~= -1 do
    balanceDungeon = dungeon.nextDungeonId
    dungeon = PB.get("DungeonMonster", dungeon.nextDungeonId)
  end
  return balanceDungeon
end

function DU.SaveAutoFightCommands(dungeonId, commands)
  if dungeonId and commands and (not (table.empty(commands.seat1) and table.empty(commands.seat2)) or not table.empty(commands.seat3)) then
    local configPrefix = DB:GetData("playerId") or ""
    WU.SetGameDataCache(configPrefix .. "/Fight/AutoFightMode" .. dungeonId, commands.mode)
    WU.SetGameDataCache(configPrefix .. "/Fight/CommandSequences" .. dungeonId, commands)
  end
end

function DU.GetDungeonWinTypeText(winParam)
  local result = {}
  local paramTypeStr = winParam[1] or ""
  if string.trim(paramTypeStr) == "" then
    table.insert(result, WU.GetString("WinType_1"))
  else
    local paramTypes = string.split(paramTypeStr, "_")
    local params2 = string.split(winParam[2] or "", "_")
    local params3 = string.split(winParam[3] or "", "_")
    for pi = 1, #paramTypes do
      local paramType = math.floor(tonumber(paramTypes[pi]))
      local p2 = math.floor(tonumber(params2[pi] or 0))
      local p3 = math.floor(tonumber(params3[pi] or 0))
      if paramType == PB.enum.WinType.KillSingle or paramType == PB.enum.WinType.KillSingleInRound or paramType == PB.enum.WinType.NoDeadSingle or paramType == PB.enum.WinType.NoDeadSingleInRound then
        table.insert(result, WU.GetString("WinType_" .. paramType .. "_" .. p2, p2, p3))
      else
        table.insert(result, WU.GetString("WinType_" .. paramType, p2, p3))
      end
    end
  end
  return result
end

function DU.PlayReplay(dungeonUid, dungeonType, windowParam)
  if dungeonUid == nil or dungeonUid == 0 then
    return
  end
  DB:GameRequest(string.format("fci/fight-replay/%d/", dungeonUid)):Get(function(res)
    local fightActorInfo = {}
    local fightLuaTable = {}
    fightLuaTable.winTeam = res.winTeam
    fightLuaTable.initSeed = res.initSeed
    fightLuaTable.teamList = {}
    for i, v in ipairs(res.teamList) do
      local player = v.playerList[1]
      local fixActor = {}
      local playerInfo = {}
      for i = 1, 6 do
        fixActor[i] = res.actorInfos[player.playerId].actorList[i] or {}
      end
      playerInfo.playerId = player.playerId
      playerInfo.actors = fixActor
      playerInfo.members = fixActor
      playerInfo.headPhoto = player.headPhoto
      playerInfo.score = 0
      if player.score then
        playerInfo.score = player.score
      end
      playerInfo.socialPicture = player.socialPicture
      playerInfo.name = player.name
      playerInfo.isWin = i == res.winTeam
      fightActorInfo[#fightActorInfo + 1] = playerInfo
      local team = {}
      team.statistic = {}
      team.team = i
      team.statistic.inputList = v.inputList
      team.statistic.recordHpList = {}
      fightLuaTable.teamList[#fightLuaTable.teamList + 1] = team
    end
    DB:SetData("FightRecordMode", {})
    DB:SetData("FightDataRecord", fightLuaTable)
    DB:SetData("FightActorInfo", fightActorInfo)
    DB:SetData("FightActorInfoSynced", true)
    DB:SetData("AsyncPvpNewWindowParam", windowParam)
    WU.EnterGameLevel(0, nil, res.dungeonId, dungeonType, 1, false)
  end, function()
    WU.ShowHintText(WU.GetString("NASyncPvp_VideoExpired"))
    return true
  end)
end

function DU.IsSemifixedDungeon(dungeonId)
  local dun = PB.get("NPCDungeonInfo", dungeonId)
  return dun ~= nil
end

return DU
