local PopUpGiftCell = class("PopUpGiftCell", Dialog)
PopUpGiftCell.AssetBundleName = "ui/layouts.welfare"
PopUpGiftCell.AssetName = "PromotionsItem"

function PopUpGiftCell:Ctor(...)
  PopUpGiftCell.super.Ctor(self, ...)
end

function PopUpGiftCell:OnCreate()
  self._back = self:GetChild("ItemCell/_BackGround")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._img = self:GetChild("ItemCell/_BackGround/Icon")
  self._num = self:GetChild("ItemCell/_Count")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function PopUpGiftCell:OnDestroy()
end

function PopUpGiftCell:RefreshCell(data)
  local imageRecord = data:GetIcon()
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._num:SetText(data:GetCount())
  local pinjiRecord = data:GetPinJiImage()
  self._frame:SetSprite(pinjiRecord.assetBundle, pinjiRecord.assetName)
end

function PopUpGiftCell:OnCellClicked()
  local width, height = self._rootWindow:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellData
    })
    tipsDialog:SetTipsPosition(width, height, self._rootWindow:GetLocalPointInUiRootPanel())
  end
end

return PopUpGiftCell
