local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local BaseCharacterInfoPropAttrCell = class("BaseCharacterInfoPropAttrCell", Dialog)
BaseCharacterInfoPropAttrCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterInfoPropAttrCell.AssetName = "BaseCharacterInfoPropCell"

function BaseCharacterInfoPropAttrCell:Ctor(...)
  BaseCharacterInfoPropAttrCell.super.Ctor(self, ...)
end

function BaseCharacterInfoPropAttrCell:OnCreate()
  self._image = self:GetChild("Image")
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

function BaseCharacterInfoPropAttrCell:OnDestroy()
end

function BaseCharacterInfoPropAttrCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(record.classnameTextID))
  if record.isDecimal == 1 then
    self._num:SetText(tostring(data.value / 10) .. "%")
  else
    self._num:SetText(data.value)
  end
  local xx = self._num:GetPreferredSize()
  local x = self._num:GetRectSize()
  local sx, ox, sy, oy = self._num:GetSize()
  local px, pox, py, poy = self._num:GetPosition()
  if xx > x then
    self._num:SetSize(sx, xx, sy, oy)
    self._num:SetPosition(px, pox - (xx - x), py, poy)
  end
end

return BaseCharacterInfoPropAttrCell
