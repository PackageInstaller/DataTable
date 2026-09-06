local MidAutumnItemCell = class("MidAutumnItemCell", Dialog)
MidAutumnItemCell.AssetBundleName = "ui/layouts.activitymidautumn"
MidAutumnItemCell.AssetName = "ActivityMidAutumnMainItemCell"

function MidAutumnItemCell:Ctor(...)
  MidAutumnItemCell.super.Ctor(self, ...)
end

function MidAutumnItemCell:OnCreate()
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function MidAutumnItemCell:OnDestroy()
end

function MidAutumnItemCell:RefreshCell(data)
  self._item = data
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function MidAutumnItemCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return MidAutumnItemCell
