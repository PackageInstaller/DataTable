local CDormComfortLv = BeanManager.GetTableByName("courtyard.cdormcomfortlv")
local CDormComfortImage = BeanManager.GetTableByName("courtyard.cdormcomfortimage")
local CDormFurnitureGroup = BeanManager.GetTableByName("courtyard.cdormfurnituregroup")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CEmotionImageCfg = BeanManager.GetTableByName("courtyard.cemotionimage")
local CDormComfortRate = BeanManager.GetTableByName("courtyard.cdormcomfortrate")
local Rate = CDormComfortRate:GetRecorder(1).rate
local BagTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes")
local BM_Cabin = class("BM_Cabin")

function BM_Cabin:Ctor()
  self._cabin = NekoData.Data.cabin
  self._emotionRecorderList = {}
  local allIds = CEmotionImageCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CEmotionImageCfg:GetRecorder(allIds[i])
    table.insert(self._emotionRecorderList, recorder)
  end
  self._comfortLvRecorderList = {}
  allIds = CDormComfortLv:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormComfortLv:GetRecorder(allIds[i])
    table.insert(self._comfortLvRecorderList, recorder)
  end
  self._recommendThemeRecorderList = {}
  allIds = CDormFurnitureGroup:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormFurnitureGroup:GetRecorder(allIds[i])
    if recorder.showornot == 1 then
      table.insert(self._recommendThemeRecorderList, recorder)
    end
  end
end

function BM_Cabin:GetLevel()
  return self._cabin.level
end

function BM_Cabin:GetDispatchRoles(yardShow)
  local list = {}
  if yardShow then
    for k, v in pairs(self._cabin.roles) do
      table.insert(list, v.roleKey)
    end
  end
  return list
end

function BM_Cabin:GetDispatchMaxRoleNum()
  return 5 * self._cabin.level
end

function BM_Cabin:GetDispatchLimitRoleNum()
  return 5
end

function BM_Cabin:GetName()
  return self._cabin.name
end

function BM_Cabin:GetAllRoomInfo()
  return self._cabin.roomInfo
end

function BM_Cabin:GetRoomInfoById(roomId)
  return self._cabin.roomInfo[roomId]
end

function BM_Cabin:GetThemeList()
  local list = {}
  for i, v in ipairs(self._cabin.themes) do
    table.insert(list, v)
  end
  return list
end

function BM_Cabin:GetPauseTaskNum()
  return self._cabin.energyFullRoleNum
end

function BM_Cabin:GetGetNum()
  local bm_guide = NekoData.BehaviorManager.BM_Guide
  if not bm_guide:HasFinished(28) and self._cabin.level == 1 or not bm_guide:HasFinished(36) and self._cabin.level == 2 or not bm_guide:HasFinished(37) and self._cabin.level == 3 then
    return 1
  else
    return 0
  end
end

function BM_Cabin:GetRoles()
  return self._cabin.roles
end

function BM_Cabin:GetRate()
  return Rate
end

function BM_Cabin:GetRecordByComfortLv(comfortLv)
  return self._comfortLvRecorderList[comfortLv]
end

function BM_Cabin:GetImgRecordByEnergy(energy)
  for i, v in ipairs(self._emotionRecorderList) do
    if energy >= v.id and energy <= v.LvMax then
      return CImagePathTable:GetRecorder(v.imageID)
    end
  end
end

function BM_Cabin:GetCanUsedRecommendThemeList()
  return self._recommendThemeRecorderList
end

function BM_Cabin:GetComfortImageRecord()
  return CImagePathTable:GetRecorder(CDormComfortImage:GetRecorder(1).image)
end

return BM_Cabin
