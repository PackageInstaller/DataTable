local TaskStateEnum = LuaNetManager.GetBeanDef("protocol.yard.task")
local CTreeLvUp = BeanManager.GetTableByName("courtyard.ctreelvup")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CMagictreePanelStringCfg = BeanManager.GetTableByName("courtyard.cmagictreepanelstring")
local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")
local BM_MagicTree = class("BM_MagicTree")

function BM_MagicTree:Ctor()
  self._magicTree = NekoData.Data.magicTree
end

function BM_MagicTree:GetTasksInfo()
  local list = {}
  for i, v in ipairs(self._magicTree.tasks) do
    table.insert(list, v)
  end
  return list
end

function BM_MagicTree:GetTasksInfoMap()
  local map = {}
  for i, v in ipairs(self._magicTree.tasks) do
    map[v.buildingId] = v
  end
  return map
end

function BM_MagicTree:GetTaskInfoByBuildingId(buildingId)
  for i, v in ipairs(self._magicTree.tasks) do
    if v.buildingId == buildingId then
      return v
    end
  end
end

function BM_MagicTree:GetWorkingTaskNum()
  local workingNum = 0
  for i, v in ipairs(self._magicTree.tasks) do
    if v.taskId ~= 0 and (v.taskState == TaskStateEnum.PROCESSING or v.taskState == TaskStateEnum.UnReceive) then
      workingNum = workingNum + 1
    end
  end
  return workingNum
end

function BM_MagicTree:GetMaxTaskNum()
  return CTreeLvUp:GetRecorder(self._magicTree.level).lvUpNum
end

function BM_MagicTree:GetWorkState()
  return self._magicTree._workState
end

function BM_MagicTree:GetPauseTaskNum()
  return 0
end

function BM_MagicTree:GetGetNum()
  return self._magicTree._getNum
end

function BM_MagicTree:GetDispatchRoles()
  local list = {}
  return list
end

function BM_MagicTree:GetDispatchMaxRoleNum()
  return 0
end

function BM_MagicTree:GetLevel()
  return self._magicTree.level
end

function BM_MagicTree:GetMaxLevel()
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
  return level
end

function BM_MagicTree:GetSpeed()
  return self._magicTree.levelUpSpeed
end

function BM_MagicTree:GetTreeImage()
  return CImagePathTable:GetRecorder(CTreeLvUp:GetRecorder(self._magicTree.level).image) or DataCommon.DefaultImageAsset
end

function BM_MagicTree:GetPlotIdByBuildingId(buildingId)
  local plots = self._magicTree.buildingPlots[buildingId]
  if not plots or #plots == 0 then
    if not plots then
      self._magicTree.buildingPlots[buildingId] = {}
      plots = self._magicTree.buildingPlots[buildingId]
    end
    local record = CMagictreePanelStringCfg:GetRecorder(buildingId)
    for _, v in ipairs(record.scenariostring) do
      table.insert(plots, v)
    end
  else
    plots = self._magicTree.buildingPlots[buildingId]
  end
  local index = 1
  local plotId = plots[index]
  self._magicTree.buildingPlotMap[buildingId] = true
  return plotId
end

function BM_MagicTree:RefreshPlot()
  for k, v in pairs(self._magicTree.buildingPlotMap) do
    self._magicTree.buildingPlotMap[k] = nil
    local plots = self._magicTree.buildingPlots[k]
    if plots then
      table.remove(plots, 1)
    end
  end
end

return BM_MagicTree
