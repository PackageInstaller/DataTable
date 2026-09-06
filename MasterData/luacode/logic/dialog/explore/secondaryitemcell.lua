local SecondaryItemCell = class("SecondaryItemCell", Dialog)
SecondaryItemCell.AssetBundleName = "ui/layouts.yard"
SecondaryItemCell.AssetName = "YardExploreDetailCellItem"

function SecondaryItemCell:Ctor(...)
  SecondaryItemCell.super.Ctor(self, ...)
end

function SecondaryItemCell:OnCreate()
  self._backIcon = self:GetChild("ItemBack")
  self._icon = self:GetChild("ItemBack/Item")
  self._rootWindow:Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function SecondaryItemCell:OnDestroy()
end

function SecondaryItemCell:RefreshCell(data)
  local imageRecord = data:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetPinJiImage()
  self._backIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function SecondaryItemCell:OnCellClick()
  local width, height = self._rootWindow:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellData
    })
    tipsDialog:SetTipsPosition(width, height, self._rootWindow:GetLocalPointInUiRootPanel())
  end
end

return SecondaryItemCell
