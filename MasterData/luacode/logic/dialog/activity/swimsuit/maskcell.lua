local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MaskCell = class("MaskCell", Dialog)
MaskCell.AssetBundleName = "ui/layouts.activitysummer"
MaskCell.AssetName = "ActivitySummerMaskCell"

function MaskCell:Ctor(...)
  MaskCell.super.Ctor(self, ...)
end

function MaskCell:OnCreate()
  self._maskIcon = self:GetChild("Image")
  self._maskName = self:GetChild("Text")
  self._maskStateText = self:GetChild("Buttom/Text")
  self._checkBorder = self:GetChild("Check")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function MaskCell:OnDestroy()
end

function MaskCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    if arg == self._index then
      self._checkBorder:SetActive(true)
    else
      self._checkBorder:SetActive(false)
    end
  end
end

function MaskCell:RefreshCell(data)
  self._index = data.index
  self._data = data.data
  local imageRecord = CImagePathTable:GetRecorder(self._data.image) or DataCommon.DefaultImageAsset
  self._maskIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._maskName:SetText(TextManager.GetText(self._data.name))
  if self._data.isUnlock == 0 then
    self._maskStateText:SetText(TextManager.GetText(CStringRes:GetRecorder(1607).msgTextID))
  elseif self._data.isUnlock == 1 then
    self._maskStateText:SetText(TextManager.GetText(CStringRes:GetRecorder(1609).msgTextID))
  elseif self._data.isUnlock == 2 then
    self._maskStateText:SetText(TextManager.GetText(CStringRes:GetRecorder(1608).msgTextID))
  end
end

function MaskCell:OnCellClicked()
  self._delegate:ShowOneMaskDetail(self._index)
end

return MaskCell
