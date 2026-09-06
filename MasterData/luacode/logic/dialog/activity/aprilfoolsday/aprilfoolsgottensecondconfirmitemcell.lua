local AprilFoolsGottenSecondConfirmItemCell = class("AprilFoolsGottenSecondConfirmItemCell", Dialog)
AprilFoolsGottenSecondConfirmItemCell.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsGottenSecondConfirmItemCell.AssetName = "ActivityAprilFoolsCellItem"

function AprilFoolsGottenSecondConfirmItemCell:Ctor(...)
  AprilFoolsGottenSecondConfirmItemCell.super.Ctor(self, ...)
end

function AprilFoolsGottenSecondConfirmItemCell:OnCreate()
  self._frameBackImg = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._iconImg = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._num = self:GetChild("Panel/ItemCell/_Count")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function AprilFoolsGottenSecondConfirmItemCell:OnDestroy()
end

function AprilFoolsGottenSecondConfirmItemCell:RefreshCell(data)
  local imageRecord = data.item:GetIcon()
  self._iconImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.item:GetPinJiImage()
  self._frameBackImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._num:SetNumber(data.num)
end

function AprilFoolsGottenSecondConfirmItemCell:OnCellClick()
  local width, height = self:GetRootWindow():GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init(self._cellData)
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return AprilFoolsGottenSecondConfirmItemCell
