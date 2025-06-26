-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_magictree.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskStateEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local CTreeLvUp = (BeanManager.GetTableByName)("courtyard.ctreelvup")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CMagictreePanelStringCfg = (BeanManager.GetTableByName)("courtyard.cmagictreepanelstring")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local BM_MagicTree = class("BM_MagicTree")
BM_MagicTree.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._magicTree = (NekoData.Data).magicTree
end

BM_MagicTree.GetTasksInfo = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local list = {}
  for i,v in ipairs((self._magicTree).tasks) do
    (table.insert)(list, v)
  end
  return list
end

BM_MagicTree.GetTasksInfoMap = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local map = {}
  for i,v in ipairs((self._magicTree).tasks) do
    map[v.buildingId] = v
  end
  return map
end

BM_MagicTree.GetTaskInfoByBuildingId = function(self, buildingId)
  -- function num : 0_3 , upvalues : _ENV
  for i,v in ipairs((self._magicTree).tasks) do
    if v.buildingId == buildingId then
      return v
    end
  end
end

BM_MagicTree.GetWorkingTaskNum = function(self)
  -- function num : 0_4 , upvalues : _ENV, TaskStateEnum
  local workingNum = 0
  for i,v in ipairs((self._magicTree).tasks) do
    if v.taskId ~= 0 and (v.taskState == TaskStateEnum.PROCESSING or v.taskState == TaskStateEnum.UnReceive) then
      workingNum = workingNum + 1
    end
  end
  return workingNum
end

BM_MagicTree.GetMaxTaskNum = function(self)
  -- function num : 0_5 , upvalues : CTreeLvUp
  return (CTreeLvUp:GetRecorder((self._magicTree).level)).lvUpNum
end

BM_MagicTree.GetWorkState = function(self)
  -- function num : 0_6
  return (self._magicTree)._workState
end

BM_MagicTree.GetPauseTaskNum = function(self)
  -- function num : 0_7
  return 0
end

BM_MagicTree.GetGetNum = function(self)
  -- function num : 0_8
  return (self._magicTree)._getNum
end

BM_MagicTree.GetDispatchRoles = function(self)
  -- function num : 0_9
  local list = {}
  return list
end

BM_MagicTree.GetDispatchMaxRoleNum = function(self)
  -- function num : 0_10
  return 0
end

BM_MagicTree.GetLevel = function(self)
  -- function num : 0_11
  return (self._magicTree).level
end

BM_MagicTree.GetMaxLevel = function(self)
  -- function num : 0_12 , upvalues : CCourtyardLvUpCfg, _ENV
  local level = 0
  local allIds = CCourtyardLvUpCfg:GetAllIds()
  for i = 1, #allIds do
    local record = CCourtyardLvUpCfg:GetRecorder(allIds[i])
    if record.functionID == DataCommon.MagicTree then
      level = record.id - DataCommon.MagicTree
    else
      break
    end
  end
  do
    return level
  end
end

BM_MagicTree.GetSpeed = function(self)
  -- function num : 0_13
  return (self._magicTree).levelUpSpeed
end

BM_MagicTree.GetTreeImage = function(self)
  -- function num : 0_14 , upvalues : CImagePathTable, CTreeLvUp, _ENV
  if not CImagePathTable:GetRecorder((CTreeLvUp:GetRecorder((self._magicTree).level)).image) then
    return DataCommon.DefaultImageAsset
  end
end

BM_MagicTree.GetPlotIdByBuildingId = function(self, buildingId)
  -- function num : 0_15 , upvalues : CMagictreePanelStringCfg, _ENV
  local plots = ((self._magicTree).buildingPlots)[buildingId]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if not plots or #plots == 0 then
    if not plots then
      ((self._magicTree).buildingPlots)[buildingId] = {}
      plots = ((self._magicTree).buildingPlots)[buildingId]
    end
    local record = CMagictreePanelStringCfg:GetRecorder(buildingId)
    for _,v in ipairs(record.scenariostring) do
      (table.insert)(plots, v)
    end
  else
    do
      plots = ((self._magicTree).buildingPlots)[buildingId]
      local index = 1
      local plotId = plots[index]
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._magicTree).buildingPlotMap)[buildingId] = true
      return plotId
    end
  end
end

BM_MagicTree.RefreshPlot = function(self)
  -- function num : 0_16 , upvalues : _ENV
  for k,v in pairs((self._magicTree).buildingPlotMap) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._magicTree).buildingPlotMap)[k] = nil
    local plots = ((self._magicTree).buildingPlots)[k]
    if plots then
      (table.remove)(plots, 1)
    end
  end
end

return BM_MagicTree

