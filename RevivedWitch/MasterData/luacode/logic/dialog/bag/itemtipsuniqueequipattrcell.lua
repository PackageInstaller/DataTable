-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemtipsuniqueequipattrcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ItemTipsUniqueEquipAttrCell = class("ItemTipsUniqueEquipAttrCell", Dialog)
ItemTipsUniqueEquipAttrCell.AssetBundleName = "ui/layouts.bag"
ItemTipsUniqueEquipAttrCell.AssetName = "ItemTipsNewEquipAttributeCell"
ItemTipsUniqueEquipAttrCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemTipsUniqueEquipAttrCell
  ((ItemTipsUniqueEquipAttrCell.super).Ctor)(self, ...)
end

ItemTipsUniqueEquipAttrCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Image")
  self._name = self:GetChild("Txt")
  self._num = self:GetChild("Num")
end

ItemTipsUniqueEquipAttrCell.OnDestroy = function(self)
  -- function num : 0_2
end

ItemTipsUniqueEquipAttrCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, CImagePathTable, _ENV
  local record = CAttrNameTable:GetRecorder(data.attrId)
  if not CImagePathTable:GetRecorder(record.classIcon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(record.classnameTextID))
  ;
  (self._num):SetText(data.attrValue)
end

return ItemTipsUniqueEquipAttrCell

