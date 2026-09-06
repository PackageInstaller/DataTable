local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local NewPropertyTipsCell = class("NewPropertyTipsCell", Dialog)
NewPropertyTipsCell.AssetBundleName = "ui/layouts.basecharacterinfo"
NewPropertyTipsCell.AssetName = "PropDetailCell"

function NewPropertyTipsCell:Ctor(...)
  NewPropertyTipsCell.super.Ctor(self, ...)
end

function NewPropertyTipsCell:OnCreate()
  self._proImg = self:GetChild("Image")
  self._proName = self:GetChild("Txt")
  self._proValue = self:GetChild("Num")
end

function NewPropertyTipsCell:OnDestroy()
end

function NewPropertyTipsCell:RefreshCell(data)
  local record = CAttrNameTable:GetRecorder(data.attrId)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._proImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._proName:SetText(TextManager.GetText(record.classnameTextID))
  if record.isDecimal == 1 then
    self._proValue:SetText(tostring(data.value / 10) .. "%")
  else
    self._proValue:SetText(data.value)
  end
end

return NewPropertyTipsCell
