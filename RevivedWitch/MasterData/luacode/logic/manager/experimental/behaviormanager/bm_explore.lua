-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_explore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CExploreLvUpCfg = (BeanManager.GetTableByName)("courtyard.cexplorelvup")
local SlotStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.caverntask")
local BM_Explore = class("BM_Explore")
BM_Explore.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._explore = (NekoData.Data).explore
end

BM_Explore.GetSlotsInfo = function(self)
  -- function num : 0_1
  return (self._explore).slots
end

BM_Explore.GetSlotInfoBySlotId = function(self, slotId)
  -- function num : 0_2 , upvalues : _ENV
  for i,v in ipairs((self._explore).slots) do
    if v.slotId == slotId then
      return v
    end
  end
end

BM_Explore.GetWorkingTaskNum = function(self)
  -- function num : 0_3 , upvalues : _ENV, SlotStateEnum
  local workingNum = 0
  for i,v in ipairs((self._explore).slots) do
    if v.taskState ~= SlotStateEnum.LOCK and v.taskState ~= SlotStateEnum.UNLOCKING then
      workingNum = workingNum + 1
    end
  end
  return workingNum
end

BM_Explore.GetMaxTaskNum = function(self)
  -- function num : 0_4 , upvalues : CExploreLvUpCfg
  return (CExploreLvUpCfg:GetRecorder((self._explore).level)).teamNum
end

BM_Explore.GetLevel = function(self)
  -- function num : 0_5
  return (self._explore).level
end

BM_Explore.GetRefreshTimes = function(self)
  -- function num : 0_6
  return (self._explore).refreshTimes
end

BM_Explore.GetMaxRefreshTimes = function(self)
  -- function num : 0_7 , upvalues : CExploreLvUpCfg
  return (CExploreLvUpCfg:GetRecorder((self._explore).level)).refreshTimes
end

BM_Explore.GetRefreshLeftTime = function(self)
  -- function num : 0_8
  return (self._explore).refreshLeftTime
end

BM_Explore.GetRefreshRate = function(self)
  -- function num : 0_9 , upvalues : CExploreLvUpCfg
  return (CExploreLvUpCfg:GetRecorder((self._explore).level)).refreshRate
end

BM_Explore.GetWorkState = function(self)
  -- function num : 0_10
  return (self._explore)._workState
end

BM_Explore.GetGetNum = function(self)
  -- function num : 0_11
  return (self._explore)._getNum
end

BM_Explore.GetPauseTaskNum = function(self)
  -- function num : 0_12
  return (self._explore)._pauseNum
end

BM_Explore.GetDispatchRoles = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local list = {}
  for i,v in ipairs((self._explore).slots) do
    for index,roleKey in ipairs(v.roles) do
      (table.insert)(list, roleKey)
    end
  end
  return list
end

BM_Explore.GetDispatchMaxRoleNum = function(self)
  -- function num : 0_14 , upvalues : _ENV, SlotStateEnum, CExploreLvUpCfg
  local num = 0
  for i,v in ipairs((self._explore).slots) do
    if v.taskState ~= SlotStateEnum.LOCK then
      num = num + 1
    end
  end
  return (num) * (CExploreLvUpCfg:GetRecorder((self._explore).level)).roleNum
end

BM_Explore.GetRoles = function(self)
  -- function num : 0_15
  return (self._explore).roles
end

return BM_Explore

