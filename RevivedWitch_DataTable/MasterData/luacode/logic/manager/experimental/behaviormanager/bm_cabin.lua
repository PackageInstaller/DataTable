-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_cabin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDormComfortLv = (BeanManager.GetTableByName)("courtyard.cdormcomfortlv")
local CDormComfortImage = (BeanManager.GetTableByName)("courtyard.cdormcomfortimage")
local CDormFurnitureGroup = (BeanManager.GetTableByName)("courtyard.cdormfurnituregroup")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CEmotionImageCfg = (BeanManager.GetTableByName)("courtyard.cemotionimage")
local CDormComfortRate = (BeanManager.GetTableByName)("courtyard.cdormcomfortrate")
local Rate = (CDormComfortRate:GetRecorder(1)).rate
local BagTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")
local BM_Cabin = class("BM_Cabin")
BM_Cabin.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, CEmotionImageCfg, CDormComfortLv, CDormFurnitureGroup
  self._cabin = (NekoData.Data).cabin
  self._emotionRecorderList = {}
  local allIds = CEmotionImageCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CEmotionImageCfg:GetRecorder(allIds[i])
    ;
    (table.insert)(self._emotionRecorderList, recorder)
  end
  self._comfortLvRecorderList = {}
  allIds = CDormComfortLv:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormComfortLv:GetRecorder(allIds[i])
    ;
    (table.insert)(self._comfortLvRecorderList, recorder)
  end
  self._recommendThemeRecorderList = {}
  allIds = CDormFurnitureGroup:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormFurnitureGroup:GetRecorder(allIds[i])
    if recorder.showornot == 1 then
      (table.insert)(self._recommendThemeRecorderList, recorder)
    end
  end
end

BM_Cabin.GetLevel = function(self)
  -- function num : 0_1
  return (self._cabin).level
end

BM_Cabin.GetDispatchRoles = function(self, yardShow)
  -- function num : 0_2 , upvalues : _ENV
  local list = {}
  if yardShow then
    for k,v in pairs((self._cabin).roles) do
      (table.insert)(list, v.roleKey)
    end
  end
  do
    return list
  end
end

BM_Cabin.GetDispatchMaxRoleNum = function(self)
  -- function num : 0_3
  return 5 * (self._cabin).level
end

BM_Cabin.GetDispatchLimitRoleNum = function(self)
  -- function num : 0_4
  return 5
end

BM_Cabin.GetName = function(self)
  -- function num : 0_5
  return (self._cabin).name
end

BM_Cabin.GetAllRoomInfo = function(self)
  -- function num : 0_6
  return (self._cabin).roomInfo
end

BM_Cabin.GetRoomInfoById = function(self, roomId)
  -- function num : 0_7
  return ((self._cabin).roomInfo)[roomId]
end

BM_Cabin.GetThemeList = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local list = {}
  for i,v in ipairs((self._cabin).themes) do
    (table.insert)(list, v)
  end
  return list
end

BM_Cabin.GetPauseTaskNum = function(self)
  -- function num : 0_9
  return (self._cabin).energyFullRoleNum
end

BM_Cabin.GetGetNum = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local bm_guide = (NekoData.BehaviorManager).BM_Guide
  -- DECOMPILER ERROR at PC31: Unhandled construct in 'MakeBoolean' P3

  if (not bm_guide:HasFinished(28) and (self._cabin).level == 1) or bm_guide:HasFinished(36) or not bm_guide:HasFinished(37) and (self._cabin).level == 3 then
    return 1
  else
    return 0
  end
end

BM_Cabin.GetRoles = function(self)
  -- function num : 0_11
  return (self._cabin).roles
end

BM_Cabin.GetRate = function(self)
  -- function num : 0_12 , upvalues : Rate
  return Rate
end

BM_Cabin.GetRecordByComfortLv = function(self, comfortLv)
  -- function num : 0_13
  return (self._comfortLvRecorderList)[comfortLv]
end

BM_Cabin.GetImgRecordByEnergy = function(self, energy)
  -- function num : 0_14 , upvalues : _ENV, CImagePathTable
  for i,v in ipairs(self._emotionRecorderList) do
    if v.id <= energy and energy <= v.LvMax then
      return CImagePathTable:GetRecorder(v.imageID)
    end
  end
end

BM_Cabin.GetCanUsedRecommendThemeList = function(self)
  -- function num : 0_15
  return self._recommendThemeRecorderList
end

BM_Cabin.GetComfortImageRecord = function(self)
  -- function num : 0_16 , upvalues : CImagePathTable, CDormComfortImage
  return CImagePathTable:GetRecorder((CDormComfortImage:GetRecorder(1)).image)
end

return BM_Cabin

