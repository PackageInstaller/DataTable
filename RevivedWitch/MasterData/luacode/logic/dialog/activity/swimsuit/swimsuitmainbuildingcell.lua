-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitmainbuildingcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CHexagonLand = (BeanManager.GetTableByName)("activity.chexagonland")
local SwimSuitMainBuildingCell = class("SwimSuitMainBuildingCell", Dialog)
SwimSuitMainBuildingCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitMainBuildingCell.AssetName = "ActivitySummerMainBuyCell"
SwimSuitMainBuildingCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitMainBuildingCell
  ((SwimSuitMainBuildingCell.super).Ctor)(self, ...)
end

SwimSuitMainBuildingCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Back")
  self._itemIcon = self:GetChild("Back/Item")
  self._name = self:GetChild("Back/Name")
  self._num = self:GetChild("Back/Num")
  ;
  (self._num):SetActive(false)
  self._usingPanel = self:GetChild("Using")
  self._select = self:GetChild("Select")
  self._reduceBtn = self:GetChild("Using/Using/Reduce")
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(self.OnReduceClick, self)
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnCellClick, self)
  ;
  (self._itemIcon):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

SwimSuitMainBuildingCell.OnDestroy = function(self)
  -- function num : 0_2
end

SwimSuitMainBuildingCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CHexagonLand, CImagePathTable, _ENV
  (self._select):SetActive(false)
  local recorder = CHexagonLand:GetRecorder(data.id)
  if not CImagePathTable:GetRecorder(recorder.image) then
    local image = DataCommon.DefaultImageAsset
  end
  ;
  (self._itemIcon):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(recorder.name))
  if data.tag == "DIY" then
    (self._usingPanel):SetActive(data.used)
  else
    if data.tag == "SHOP" then
      (self._usingPanel):SetActive(false)
    end
  end
end

SwimSuitMainBuildingCell.OnCellClick = function(self)
  -- function num : 0_4
  if not (self._cellData).used then
    (self._delegate):OnBuildingCellClick((self._cellData).id)
  end
end

SwimSuitMainBuildingCell.OnReduceClick = function(self)
  -- function num : 0_5
  (self._delegate):OnBuildingCellReduceClick((self._cellData).id)
end

SwimSuitMainBuildingCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_6
  if (self._cellData).id ~= arg then
    (self._select):SetActive(eventName ~= "ChangedSelected")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return SwimSuitMainBuildingCell

