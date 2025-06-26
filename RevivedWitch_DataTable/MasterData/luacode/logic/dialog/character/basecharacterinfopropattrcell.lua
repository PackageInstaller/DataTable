-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharacterinfopropattrcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BaseCharacterInfoPropAttrCell = class("BaseCharacterInfoPropAttrCell", Dialog)
BaseCharacterInfoPropAttrCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterInfoPropAttrCell.AssetName = "BaseCharacterInfoPropCell"
BaseCharacterInfoPropAttrCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterInfoPropAttrCell
  ((BaseCharacterInfoPropAttrCell.super).Ctor)(self, ...)
end

BaseCharacterInfoPropAttrCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

BaseCharacterInfoPropAttrCell.OnDestroy = function(self)
  -- function num : 0_2
end

BaseCharacterInfoPropAttrCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, CImagePathTable, _ENV
  local record = CAttrNameTable:GetRecorder(data.attrId)
  if not CImagePathTable:GetRecorder(record.classIcon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(record.classnameTextID))
  if record.isDecimal == 1 then
    (self._num):SetText(tostring(data.value / 10) .. "%")
  else
    ;
    (self._num):SetText(data.value)
  end
  local xx = (self._num):GetPreferredSize()
  local x = (self._num):GetRectSize()
  local sx, ox, sy, oy = (self._num):GetSize()
  local px, pox, py, poy = (self._num):GetPosition()
  if x < xx then
    (self._num):SetSize(sx, xx, sy, oy)
    ;
    (self._num):SetPosition(px, pox - (xx - x), py, poy)
  end
end

return BaseCharacterInfoPropAttrCell

