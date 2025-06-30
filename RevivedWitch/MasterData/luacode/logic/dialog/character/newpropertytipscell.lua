-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newpropertytipscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local NewPropertyTipsCell = class("NewPropertyTipsCell", Dialog)
NewPropertyTipsCell.AssetBundleName = "ui/layouts.basecharacterinfo"
NewPropertyTipsCell.AssetName = "PropDetailCell"
NewPropertyTipsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewPropertyTipsCell
  ((NewPropertyTipsCell.super).Ctor)(self, ...)
end

NewPropertyTipsCell.OnCreate = function(self)
  -- function num : 0_1
  self._proImg = self:GetChild("Image")
  self._proName = self:GetChild("Txt")
  self._proValue = self:GetChild("Num")
end

NewPropertyTipsCell.OnDestroy = function(self)
  -- function num : 0_2
end

NewPropertyTipsCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, CImagePathTable, _ENV
  local record = CAttrNameTable:GetRecorder(data.attrId)
  if not CImagePathTable:GetRecorder(record.classIcon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._proImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._proName):SetText((TextManager.GetText)(record.classnameTextID))
  if record.isDecimal == 1 then
    (self._proValue):SetText(tostring(data.value / 10) .. "%")
  else
    ;
    (self._proValue):SetText(data.value)
  end
end

return NewPropertyTipsCell

