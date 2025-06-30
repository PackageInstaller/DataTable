-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_traincamp.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CLightTrainingCourse = (BeanManager.GetTableByName)("courtyard.clighttrainingcourse")
local CLightTrainingLvl = (BeanManager.GetTableByName)("courtyard.clighttraininglvl")
local TrainStatus = (LuaNetManager.GetBeanDef)("protocol.yard.train")
local BM_TrainCamp = class("BM_TrainCamp")
BM_TrainCamp.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._trainCamp = (NekoData.Data).trainCamp
end

BM_TrainCamp.GetTrainTaskInfo = function(self, index)
  -- function num : 0_1
  return ((self._trainCamp).trainInfo)[index]
end

BM_TrainCamp.GetAllTrainTaskInfo = function(self)
  -- function num : 0_2 , upvalues : CLightTrainingLvl, TrainStatus, _ENV, CLightTrainingCourse
  local list = {}
  local lockMap = {}
  local lastLvMaxCourseNum = 0
  local allIds = CLightTrainingLvl:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CLightTrainingLvl:GetRecorder(allIds[i])
    if (self._trainCamp).level < record.id then
      lockMap[record.id] = record.maxcoursenum - lastLvMaxCourseNum
    end
    lastLvMaxCourseNum = record.maxcoursenum
  end
  local unLockMap = {
[TrainStatus.COMPLETE] = {}
, 
[TrainStatus.UN_START] = {}
, 
[TrainStatus.PROCESSING] = {}
}
  for _,v in pairs((self._trainCamp).trainInfo) do
    (table.insert)(unLockMap[v.status], v)
  end
  for k,v in pairs(unLockMap) do
    (table.sort)(v, function(a, b)
    -- function num : 0_2_0 , upvalues : CLightTrainingCourse
    local a_record = CLightTrainingCourse:GetRecorder(a.taskId)
    local b_record = CLightTrainingCourse:GetRecorder(b.taskId)
    if a.index >= b.index then
      do return a_record.trainingrarity ~= b_record.trainingrarity end
      do return a_record.trainingrarity < b_record.trainingrarity end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  end
  for i,v in ipairs(unLockMap[TrainStatus.COMPLETE]) do
    (table.insert)(list, {trainTaskInfo = v})
  end
  for i,v in ipairs(unLockMap[TrainStatus.UN_START]) do
    (table.insert)(list, {trainTaskInfo = v})
  end
  for i,v in ipairs(unLockMap[TrainStatus.PROCESSING]) do
    (table.insert)(list, {trainTaskInfo = v})
  end
  for k,v in pairs(lockMap) do
    for i = 1, v do
      (table.insert)(list, {unlockLv = k})
    end
  end
  return list
end

BM_TrainCamp.GetLevel = function(self)
  -- function num : 0_3
  return (self._trainCamp).level
end

BM_TrainCamp.GetPauseTaskNum = function(self)
  -- function num : 0_4
  return (self._trainCamp)._pauseNum
end

BM_TrainCamp.GetGetNum = function(self)
  -- function num : 0_5
  return (self._trainCamp)._getNum
end

BM_TrainCamp.GetWorkState = function(self)
  -- function num : 0_6
  return (self._trainCamp)._workState
end

BM_TrainCamp.GetDispatchMaxRoleNum = function(self)
  -- function num : 0_7 , upvalues : CLightTrainingLvl
  local allIds = CLightTrainingLvl:GetAllIds()
  return (CLightTrainingLvl:GetRecorder(allIds[(self._trainCamp).level])).maxcoursenum
end

BM_TrainCamp.GetDispatchLimitRoleNum = function(self)
  -- function num : 0_8
  return 1
end

BM_TrainCamp.GetDispatchRoles = function(self, yardShow)
  -- function num : 0_9 , upvalues : _ENV
  local list = {}
  if yardShow then
    for k,v in pairs((self._trainCamp).trainInfo) do
      if v.roleId ~= 0 then
        (table.insert)(list, v.roleId)
      end
    end
  end
  do
    return list
  end
end

BM_TrainCamp.GetRolesWithStatus = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local map = {}
  for k,v in pairs((self._trainCamp).trainInfo) do
    if v.roleId ~= 0 then
      map[v.roleId] = v.status
    end
  end
  return map
end

return BM_TrainCamp

