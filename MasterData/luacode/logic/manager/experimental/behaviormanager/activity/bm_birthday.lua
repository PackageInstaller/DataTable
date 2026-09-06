local CActivityTasksProtocolDef = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")
local CLoginMissionAward = BeanManager.GetTableByName("mission.cloginmissionaward")
local CLoginWishCfg = BeanManager.GetTableByName("activity.cloginwishcfg")
local CLoginMission = BeanManager.GetTableByName("mission.cloginmission")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local BM_BirthDay = class("BM_BirthDay")

function BM_BirthDay:Ctor()
  self._birthday = NekoData.Data.activities.birthday
end

function BM_BirthDay:GetIsOpen()
  return self._birthday.isOpen
end

function BM_BirthDay:GetStartTime()
  return self._birthday.startTime
end

function BM_BirthDay:GetEndTime()
  return self._birthday.endTime
end

function BM_BirthDay:GetRemainTime()
  return self._birthday.endTime - ServerGameTimer.GetServerTimeForecast()
end

function BM_BirthDay:GetRewardRecord()
  return self._birthday.rewardRecord
end

function BM_BirthDay:GetShareRecord()
  return self._birthday.shareRecord
end

function BM_BirthDay:GetWishRecord()
  return self._birthday.wishRecord
end

function BM_BirthDay:GetMaxTaskID()
  return self._birthday.maxTaskID
end

function BM_BirthDay:GetExtraItemIsLeft()
  return self._birthday.extraItemIsLeft
end

function BM_BirthDay:GetWishRecordText()
  if self._birthday.wishRecord == -1 then
    return ""
  else
    return TextManager.GetText(CLoginWishCfg:GetRecorder(self._birthday.wishRecord).TextID)
  end
end

function BM_BirthDay:HaveRedDot()
  return false
end

function BM_BirthDay:GetBoxReddot()
  local remoteBoxData = self:GetRewardRecord()
  local allIDs = self:GetCLoginMissionAwardCfg():GetAllIds()
  for _, cfgID in ipairs(allIDs) do
    local record = self:GetCLoginMissionAwardCfg():GetRecorder(cfgID)
    if not remoteBoxData[cfgID] and self:GetBoxCanGetStatus(record.missionid) then
      return true
    end
  end
  return false
end

function BM_BirthDay:ShowRedDot()
  if not self:GetIsOpen() then
    return false
  end
  return self:HaveRedDot() or NekoData.BehaviorManager.BM_ActivityTasks:BirthDayShowRedDot() or NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenBirthDayDialog) ~= nil or self:GetBoxReddot() or self:GetTaskReddot()
end

function BM_BirthDay:SendCActivityTasks()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
  if protocol then
    protocol.activityID = CActivityTasksProtocolDef.BIRTH_DAY
    protocol:Send()
  end
  return CActivityTasksProtocolDef.BIRTH_DAY
end

function BM_BirthDay:SendCAcceptActivityTask(taskID)
  local protocol = LuaNetManager.CreateProtocol("protocol.task.cacceptactivitytask")
  if protocol then
    protocol.activityID = CActivityTasksProtocolDef.BIRTH_DAY
    protocol.taskID = taskID
    protocol:Send()
  end
  return CActivityTasksProtocolDef.BIRTH_DAY
end

function BM_BirthDay:SendCCommitActivityTask(taskID)
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommitactivitytask")
  if protocol then
    protocol.activityID = CActivityTasksProtocolDef.BIRTH_DAY
    protocol.taskID = taskID
    protocol:Send()
  end
  return CActivityTasksProtocolDef.BIRTH_DAY
end

function BM_BirthDay:SendCChangeWish(index)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cchangewish")
  if protocol then
    protocol.index = index
    protocol:Send()
  end
end

function BM_BirthDay:SendCOpenBirthReward(rewardId)
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.copenbirthreward")
  if protocol then
    protocol.rewardId = rewardId
    protocol:Send()
  end
end

function BM_BirthDay:SendCBirthShare()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cbirthshare")
  if protocol then
    protocol:Send()
  end
end

function BM_BirthDay:SendCGetShopInfo()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = DataCommon.BirtDayShopID
    protocol:Send()
  end
end

function BM_BirthDay:GetCLoginMissionAwardCfg()
  return CLoginMissionAward
end

function BM_BirthDay:GetCLoginWishCfg()
  return CLoginWishCfg
end

function BM_BirthDay:GetCLoginMission()
  return CLoginMission
end

function BM_BirthDay:GetBoxCanGetStatus(missionID)
  local tasks = NekoData.BehaviorManager.BM_ActivityTasks:GetBirthDayTasks()
  if tasks == nil then
    return false
  end
  if not tasks[missionID] then
    LogErrorFormat("BM_BirthDay", "Cannot find missionID %d!", missionID)
    return false
  end
  return tasks[missionID]:GetStatus() == TaskStatus.FINISHED
end

function BM_BirthDay:GetNowTaskState()
  local remoteTaskData = NekoData.BehaviorManager.BM_ActivityTasks:GetBirthDayTasks()
  local localTaskData = CLoginMission
  local allIDs = localTaskData:GetAllIds()
  if remoteTaskData == nil then
    return nil, nil, false
  end
  local firstProcessingTask, firstAcceptedTask
  for _, cfgID in ipairs(allIDs) do
    local record = localTaskData:GetRecorder(cfgID)
    local theTask = remoteTaskData[record.id]
    if theTask then
      if theTask:GetStatus() == TaskStatus.PROCESSING then
        if firstProcessingTask == nil then
          firstProcessingTask = theTask
        end
      elseif theTask:GetStatus() == TaskStatus.ACCEPTED and firstAcceptedTask == nil then
        firstAcceptedTask = theTask
      end
    else
      LogErrorFormat("BM_BirthDay", "Unknown task id %d", record.id)
    end
    if firstProcessingTask and firstAcceptedTask then
      break
    end
  end
  
  local function haveRedotFunc()
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

function BM_BirthDay:GetWishReddot()
  local allIDs = self:GetCLoginMissionAwardCfg():GetAllIds()
  if self:GetRewardRecord()[#allIDs] and self:GetWishRecord() == -1 then
    return true
  end
  return false
end

function BM_BirthDay:GetTaskReddot()
  local _, _, canAcceptTask = self:GetNowTaskState()
  return canAcceptTask
end

local boxProgressNumTbl = {
  [0] = 0,
  [1] = 0.125,
  [2] = 0.375,
  [3] = 0.625,
  [4] = 0.875,
  [5] = 1
}

function BM_BirthDay:GetBoxProgressNum(boxID)
  return boxProgressNumTbl[boxID] or 0
end

return BM_BirthDay
