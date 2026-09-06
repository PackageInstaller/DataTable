local CLightTrainingCourse = BeanManager.GetTableByName("courtyard.clighttrainingcourse")
local CLightTrainingLvl = BeanManager.GetTableByName("courtyard.clighttraininglvl")
local TrainStatus = LuaNetManager.GetBeanDef("protocol.yard.train")
local BM_TrainCamp = class("BM_TrainCamp")

function BM_TrainCamp:Ctor()
  self._trainCamp = NekoData.Data.trainCamp
end

function BM_TrainCamp:GetTrainTaskInfo(index)
  return self._trainCamp.trainInfo[index]
end

function BM_TrainCamp:GetAllTrainTaskInfo()
  local list = {}
  local lockMap = {}
  local lastLvMaxCourseNum = 0
  local allIds = CLightTrainingLvl:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CLightTrainingLvl:GetRecorder(allIds[i])
    if record.id > self._trainCamp.level then
      lockMap[record.id] = record.maxcoursenum - lastLvMaxCourseNum
    end
    lastLvMaxCourseNum = record.maxcoursenum
  end
  local unLockMap = {
    [TrainStatus.COMPLETE] = {},
    [TrainStatus.UN_START] = {},
    [TrainStatus.PROCESSING] = {}
  }
  for _, v in pairs(self._trainCamp.trainInfo) do
    table.insert(unLockMap[v.status], v)
  end
  for k, v in pairs(unLockMap) do
    table.sort(v, function(a, b)
      local a_record = CLightTrainingCourse:GetRecorder(a.taskId)
      local b_record = CLightTrainingCourse:GetRecorder(b.taskId)
      if a_record.trainingrarity == b_record.trainingrarity then
        return a.index < b.index
      else
        return a_record.trainingrarity < b_record.trainingrarity
      end
    end)
  end
  for i, v in ipairs(unLockMap[TrainStatus.COMPLETE]) do
    table.insert(list, {trainTaskInfo = v})
  end
  for i, v in ipairs(unLockMap[TrainStatus.UN_START]) do
    table.insert(list, {trainTaskInfo = v})
  end
  for i, v in ipairs(unLockMap[TrainStatus.PROCESSING]) do
    table.insert(list, {trainTaskInfo = v})
  end
  for k, v in pairs(lockMap) do
    for i = 1, v do
      table.insert(list, {unlockLv = k})
    end
  end
  return list
end

function BM_TrainCamp:GetLevel()
  return self._trainCamp.level
end

function BM_TrainCamp:GetPauseTaskNum()
  return self._trainCamp._pauseNum
end

function BM_TrainCamp:GetGetNum()
  return self._trainCamp._getNum
end

function BM_TrainCamp:GetWorkState()
  return self._trainCamp._workState
end

function BM_TrainCamp:GetDispatchMaxRoleNum()
  local allIds = CLightTrainingLvl:GetAllIds()
  return CLightTrainingLvl:GetRecorder(allIds[self._trainCamp.level]).maxcoursenum
end

function BM_TrainCamp:GetDispatchLimitRoleNum()
  return 1
end

function BM_TrainCamp:GetDispatchRoles(yardShow)
  local list = {}
  if yardShow then
    for k, v in pairs(self._trainCamp.trainInfo) do
      if v.roleId ~= 0 then
        table.insert(list, v.roleId)
      end
    end
  end
  return list
end

function BM_TrainCamp:GetRolesWithStatus()
  local map = {}
  for k, v in pairs(self._trainCamp.trainInfo) do
    if v.roleId ~= 0 then
      map[v.roleId] = v.status
    end
  end
  return map
end

return BM_TrainCamp
