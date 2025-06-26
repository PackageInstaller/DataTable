-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equiptipssuitinfocell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local EquipTipsSuitInfoCell = class("EquipTipsSuitInfoCell", Dialog)
EquipTipsSuitInfoCell.AssetBundleName = "ui/layouts.equip"
EquipTipsSuitInfoCell.AssetName = "EquipTipsNewCellSuit1"
EquipTipsSuitInfoCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipTipsSuitInfoCell
  ((EquipTipsSuitInfoCell.super).Ctor)(self, ...)
end

EquipTipsSuitInfoCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Suit")
  self._imageGrey = self:GetChild("SuitGrey")
  ;
  (self._imageGrey):SetActive(false)
  self._text = self:GetChild("Txt")
end

EquipTipsSuitInfoCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipTipsSuitInfoCell.RefreshCell = function(self, data)
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

return EquipTipsSuitInfoCell

