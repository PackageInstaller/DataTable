local ResolveItemCell = class("ResolveItemCell", Dialog)
ResolveItemCell.AssetBundleName = "ui/layouts.bag"
ResolveItemCell.AssetName = "ItemCell"

function ResolveItemCell:Ctor(...)
  ResolveItemCell.super.Ctor(self, ...)
end

function ResolveItemCell:OnCreate()
  self._icon = self:GetChild("_BackGround/Icon")
  self._frame = self:GetChild("_BackGround/Frame")
  self._select = self:GetChild("_BackGround/Select")
  self._count = self:GetChild("_Count")
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ResolveItemCell:OnDestroy()
end

function ResolveItemCell:RefreshCell(data)
  local imageRecord = data:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetNumber(data:GetCount())
end

function ResolveItemCell:OnCellClicked()
  local width, height = self:GetRootWindow():GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellData
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return ResolveItemCell
