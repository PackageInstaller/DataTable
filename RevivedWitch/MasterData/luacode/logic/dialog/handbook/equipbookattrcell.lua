-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/equipbookattrcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local EquipBookAttrCell = class("EquipBookAttrCell", Dialog)
EquipBookAttrCell.AssetBundleName = "ui/layouts.tujian"
EquipBookAttrCell.AssetName = "EquipBookPropertyCell"
EquipBookAttrCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBookAttrCell
  ((EquipBookAttrCell.super).Ctor)(self, ...)
end

EquipBookAttrCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

EquipBookAttrCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipBookAttrCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, CImagePathTable, _ENV
  local record = CAttrNameTable:GetRecorder(data.attrId)
  if not CImagePathTable:GetRecorder(record.classIcon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.attrValue then
    (self._name):SetText((TextManager.GetText)(record.classnameTextID))
    ;
    (self._num):SetText(data.attrValue)
  else
    if data.attrGrowthValue then
      (self._name):SetText((TextManager.GetText)(record.classgrowthnameTextID))
      ;
      (self._num):SetText(data.attrGrowthValue)
    end
  end
end

return EquipBookAttrCell

