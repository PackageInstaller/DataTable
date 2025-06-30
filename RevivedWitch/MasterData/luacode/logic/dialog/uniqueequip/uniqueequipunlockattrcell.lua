-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/uniqueequip/uniqueequipunlockattrcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local UniqueEquipUnlockAttrCell = class("UniqueEquipUnlockAttrCell", Dialog)
UniqueEquipUnlockAttrCell.AssetBundleName = "ui/layouts.baseshop"
UniqueEquipUnlockAttrCell.AssetName = "ExclusiveEquipGetCell"
UniqueEquipUnlockAttrCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UniqueEquipUnlockAttrCell
  ((UniqueEquipUnlockAttrCell.super).Ctor)(self, ...)
end

UniqueEquipUnlockAttrCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Prop/Image")
  self._name = self:GetChild("Prop/Name")
  self._num = self:GetChild("Prop/Num")
end

UniqueEquipUnlockAttrCell.OnDestroy = function(self)
  -- function num : 0_2
end

UniqueEquipUnlockAttrCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, CImagePathTable, _ENV
  local record = CAttrNameTable:GetRecorder(data.attrId)
  if not CImagePathTable:GetRecorder(record.classIcon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(record.classnameTextID))
  if record.isDecimal == 1 then
    local str = data.attrValue / 1000 * 100
    ;
    (self._num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1286, {str}))
  else
    do
      ;
      (self._num):SetText(data.attrValue)
    end
  end
end

return UniqueEquipUnlockAttrCell

