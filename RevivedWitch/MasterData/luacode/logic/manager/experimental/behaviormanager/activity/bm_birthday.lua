-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_birthday.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CActivityTasksProtocolDef = (LuaNetManager.GetProtocolDef)("protocol.task.cactivitytasks")
local CLoginMissionAward = (BeanManager.GetTableByName)("mission.cloginmissionaward")
local CLoginWishCfg = (BeanManager.GetTableByName)("activity.cloginwishcfg")
local CLoginMission = (BeanManager.GetTableByName)("mission.cloginmission")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local BM_BirthDay = class("BM_BirthDay")
BM_BirthDay.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._birthday = ((NekoData.Data).activities).birthday
end

BM_BirthDay.GetIsOpen = function(self)
  -- function num : 0_1
  return (self._birthday).isOpen
end

BM_BirthDay.GetStartTime = function(self)
  -- function num : 0_2
  return (self._birthday).startTime
end

BM_BirthDay.GetEndTime = function(self)
  -- function num : 0_3
  return (self._birthday).endTime
end

BM_BirthDay.GetRemainTime = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return (self._birthday).endTime - (ServerGameTimer.GetServerTimeForecast)()
end

BM_BirthDay.GetRewardRecord = function(self)
  -- function num : 0_5
  return (self._birthday).rewardRecord
end

BM_BirthDay.GetShareRecord = function(self)
  -- function num : 0_6
  return (self._birthday).shareRecord
end

BM_BirthDay.GetWishRecord = function(self)
  -- function num : 0_7
  return (self._birthday).wishRecord
end

BM_BirthDay.GetMaxTaskID = function(self)
  -- function num : 0_8
  return (self._birthday).maxTaskID
end

BM_BirthDay.GetExtraItemIsLeft = function(self)
  -- function num : 0_9
  return (self._birthday).extraItemIsLeft
end

BM_BirthDay.GetWishRecordText = function(self)
  -- function num : 0_10 , upvalues : _ENV, CLoginWishCfg
  if (self._birthday).wishRecord == -1 then
    return ""
  else
    return (TextManager.GetText)((CLoginWishCfg:GetRecorder((self._birthday).wishRecord)).TextID)
  end
end

BM_BirthDay.HaveRedDot = function(self)
  -- function num : 0_11
  return false
end

BM_BirthDay.GetBoxReddot = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local remoteBoxData = self:GetRewardRecord()
  local allIDs = (self:GetCLoginMissionAwardCfg()):GetAllIds()
  for _,cfgID in ipairs(allIDs) do
    local record = (self:GetCLoginMissionAwardCfg()):GetRecorder(cfgID)
    if not remoteBoxData[cfgID] and self:GetBoxCanGetStatus(record.missionid) then
      return true
    end
  end
  return false
end

BM_BirthDay.ShowRedDot = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if not self:GetIsOpen() then
    return false
  end
  -- DECOMPILER ERROR at PC37: Unhandled construct in 'MakeBoolean' P3

  do return not self:HaveRedDot() and ((((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenBirthDayDialog) ~= nil or not self:GetBoxReddot()) and self:GetWishReddot()) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_BirthDay.SendCActivityTasks = function(self)
  -- function num : 0_14 , upvalues : _ENV, CActivityTasksProtocolDef
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.cactivitytasks")
  if protocol then
    protocol.activityID = CActivityTasksProtocolDef.BIRTH_DAY
    protocol:Send()
  end
  return CActivityTasksProtocolDef.BIRTH_DAY
end

BM_BirthDay.SendCAcceptActivityTask = function(self, taskID)
  -- function num : 0_15 , upvalues : _ENV, CActivityTasksProtocolDef
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.cacceptactivitytask")
  if protocol then
    protocol.activityID = CActivityTasksProtocolDef.BIRTH_DAY
    protocol.taskID = taskID
    protocol:Send()
  end
  return CActivityTasksProtocolDef.BIRTH_DAY
end

BM_BirthDay.SendCCommitActivityTask = function(self, taskID)
  -- function num : 0_16 , upvalues : _ENV, CActivityTasksProtocolDef
  local protocol = (LuaNetManager.CreateProtocol)("protocol.task.ccommitactivitytask")
  if protocol then
    protocol.activityID = CActivityTasksProtocolDef.BIRTH_DAY
    protocol.taskID = taskID
    protocol:Send()
  end
  return CActivityTasksProtocolDef.BIRTH_DAY
end

BM_BirthDay.SendCChangeWish = function(self, index)
  -- function num : 0_17 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cchangewish")
  if protocol then
    protocol.index = index
    protocol:Send()
  end
end

BM_BirthDay.SendCOpenBirthReward = function(self, rewardId)
  -- function num : 0_18 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.copenbirthreward")
  if protocol then
    protocol.rewardId = rewardId
    protocol:Send()
  end
end

BM_BirthDay.SendCBirthShare = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cbirthshare")
  if protocol then
    protocol:Send()
  end
end

BM_BirthDay.SendCGetShopInfo = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = DataCommon.BirtDayShopID
    protocol:Send()
  end
end

BM_BirthDay.GetCLoginMissionAwardCfg = function(self)
  -- function num : 0_21 , upvalues : CLoginMissionAward
  return CLoginMissionAward
end

BM_BirthDay.GetCLoginWishCfg = function(self)
  -- function num : 0_22 , upvalues : CLoginWishCfg
  return CLoginWishCfg
end

BM_BirthDay.GetCLoginMission = function(self)
  -- function num : 0_23 , upvalues : CLoginMission
  return CLoginMission
end

BM_BirthDay.GetBoxCanGetStatus = function(self, missionID)
  -- function num : 0_24 , upvalues : _ENV, TaskStatus
  local tasks = ((NekoData.BehaviorManager).BM_ActivityTasks):GetBirthDayTasks()
  if tasks == nil then
    return false
  end
  if not tasks[missionID] then
    LogErrorFormat("BM_BirthDay", "Cannot find missionID %d!", missionID)
    return false
  end
  do return (tasks[missionID]):GetStatus() == TaskStatus.FINISHED end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_BirthDay.GetNowTaskState = function(self)
  -- function num : 0_25 , upvalues : _ENV, CLoginMission, TaskStatus
  local remoteTaskData = ((NekoData.BehaviorManager).BM_ActivityTasks):GetBirthDayTasks()
  local localTaskData = CLoginMission
  local allIDs = localTaskData:GetAllIds()
  if remoteTaskData == nil then
    return nil, nil, false
  end
  local firstProcessingTask, firstAcceptedTask = nil, nil
  for _,cfgID in ipairs(allIDs) do
    local record = localTaskData:GetRecorder(cfgID)
    local theTask = remoteTaskData[record.id]
    -- DECOMPILER ERROR at PC32: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC32: Unhandled construct in 'MakeBoolean' P1

    if theTask and theTask:GetStatus() == TaskStatus.PROCESSING and firstProcessingTask == nil then
      firstProcessingTask = theTask
    end
    if theTask:GetStatus() == TaskStatus.ACCEPTED and firstAcceptedTask == nil then
      firstAcceptedTask = theTask
    end
    LogErrorFormat("BM_BirthDay", "Unknown task id %d", record.id)
  end
  do
    if not firstProcessingTask or not firstAcceptedTask then
      local haveRedotFunc = function()
    -- function num : 0_25_0 , upvalues : remoteTaskData, _ENV, firstAcceptedTask, firstProcessingTask, self
    if remoteTaskData == nil or next(remoteTaskData) == nil then
      return false
    end
    if firstAcceptedTask == nil then
      return false
    end
    if firstProcessingTask ~= nil then
      return false
    end
    if firstAcceptedTask:GetID() <= self:GetMaxTaskID() then
      return true
    end
    return false
  end

      local canAcceptTask = haveRedotFunc()
      return firstProcessingTask, firstAcceptedTask, canAcceptTask
    end
  end
end

BM_BirthDay.GetWishReddot = function(self)
  -- function num : 0_26
  local allIDs = (self:GetCLoginMissionAwardCfg()):GetAllIds()
  if (self:GetRewardRecord())[#allIDs] and self:GetWishRecord() == -1 then
    return true
  end
  return false
end

BM_BirthDay.GetTaskReddot = function(self)
  -- function num : 0_27
  local _, _, canAcceptTask = self:GetNowTaskState()
  return canAcceptTask
end

local boxProgressNumTbl = {[0] = 0, [1] = 0.125, [2] = 0.375, [3] = 0.625, [4] = 0.875, [5] = 1}
BM_BirthDay.GetBoxProgressNum = function(self, boxID)
  -- function num : 0_28 , upvalues : boxProgressNumTbl
  return boxProgressNumTbl[boxID] or 0
end

return BM_BirthDay

