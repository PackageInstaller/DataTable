-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/equipbooksuitinfocell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local EquipBookSuitInfoCell = class("EquipBookSuitInfoCell", Dialog)
EquipBookSuitInfoCell.AssetBundleName = "ui/layouts.tujian"
EquipBookSuitInfoCell.AssetName = "EquipBookSuitTitle"
EquipBookSuitInfoCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBookSuitInfoCell
  ((EquipBookSuitInfoCell.super).Ctor)(self, ...)
end

EquipBookSuitInfoCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Suit")
  self._imageGrey = self:GetChild("SuitGrey")
  ;
  (self._imageGrey):SetActive(false)
  self._text = self:GetChild("Txt")
end

EquipBookSuitInfoCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipBookSuitInfoCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder(data.suitImg) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = nil
  str = (TextManager.GetText)(data.suitName)
  ;
  (self._text):SetText(str)
end

return EquipBookSuitInfoCell

