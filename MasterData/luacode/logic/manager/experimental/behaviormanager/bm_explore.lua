local CExploreLvUpCfg = BeanManager.GetTableByName("courtyard.cexplorelvup")
local SlotStateEnum = LuaNetManager.GetBeanDef("protocol.yard.caverntask")
local BM_Explore = class("BM_Explore")

function BM_Explore:Ctor()
  self._explore = NekoData.Data.explore
end

function BM_Explore:GetSlotsInfo()
  return self._explore.slots
end

function BM_Explore:GetSlotInfoBySlotId(slotId)
  for i, v in ipairs(self._explore.slots) do
    if v.slotId == slotId then
      return v
    end
  end
end

function BM_Explore:GetWorkingTaskNum()
  local workingNum = 0
  for i, v in ipairs(self._explore.slots) do
    if v.taskState ~= SlotStateEnum.LOCK and v.taskState ~= SlotStateEnum.UNLOCKING then
      workingNum = workingNum + 1
    end
  end
  return workingNum
end

function BM_Explore:GetMaxTaskNum()
  return CExploreLvUpCfg:GetRecorder(self._explore.level).teamNum
end

function BM_Explore:GetLevel()
  return self._explore.level
end

function BM_Explore:GetRefreshTimes()
  return self._explore.refreshTimes
end

function BM_Explore:GetMaxRefreshTimes()
  return CExploreLvUpCfg:GetRecorder(self._explore.level).refreshTimes
end

function BM_Explore:GetRefreshLeftTime()
  return self._explore.refreshLeftTime
end

function BM_Explore:GetRefreshRate()
  return CExploreLvUpCfg:GetRecorder(self._explore.level).refreshRate
end

function BM_Explore:GetWorkState()
  return self._explore._workState
end

function BM_Explore:GetGetNum()
  return self._explore._getNum
end

function BM_Explore:GetPauseTaskNum()
  return self._explore._pauseNum
end

function BM_Explore:GetDispatchRoles()
  local list = {}
  for i, v in ipairs(self._explore.slots) do
    for index, roleKey in ipairs(v.roles) do
      table.insert(list, roleKey)
    end
  end
  return list
end

function BM_Explore:GetDispatchMaxRoleNum()
  local num = 0
  for i, v in ipairs(self._explore.slots) do
    if v.taskState ~= SlotStateEnum.LOCK then
      num = num + 1
    end
  end
  return num * CExploreLvUpCfg:GetRecorder(self._explore.level).roleNum
end

function BM_Explore:GetRoles()
  return self._explore.roles
end

return BM_Explore
