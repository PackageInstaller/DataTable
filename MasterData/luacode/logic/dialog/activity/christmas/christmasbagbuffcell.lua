local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ChristmasBagBuffCell = class("ChristmasBagBuffCell", Dialog)
ChristmasBagBuffCell.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasBagBuffCell.AssetName = "ActivityChristmasBagCell"

function ChristmasBagBuffCell:Ctor(...)
  ChristmasBagBuffCell.super.Ctor(self, ...)
end

function ChristmasBagBuffCell:OnCreate()
  self._icon = self:GetChild("Image")
  self._name = self:GetChild("Text")
  self._select = self:GetChild("Check")
  self._unlock = self:GetChild("Buttom")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ChristmasBagBuffCell:OnDestroy()
end

function ChristmasBagBuffCell:RefreshCell(data)
  self._name:SetText(data.item:GetName())
  local imageRecord
  if data.unlock then
    self._unlock:SetActive(true)
    imageRecord = CImagePathTable:GetRecorder(data.record.imagex) or DataCommon.DefaultImageAsset
  else
    self._unlock:SetActive(false)
    imageRecord = CImagePathTable:GetRecorder(data.record.imagey) or DataCommon.DefaultImageAsset
  end
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._select:SetActive(data.itemId == self._delegate._selectBuffItemId)
end

function ChristmasBagBuffCell:OnCellClicked()
  self._delegate:SelectedCell(self._cellData.itemId)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellData.item
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

function ChristmasBagBuffCell:OnEvent(eventName)
  if eventName == "SetItemSelectedState" then
    self._select:SetActive(self._cellData.itemId == self._delegate._selectBuffItemId)
  end
end

return ChristmasBagBuffCell
