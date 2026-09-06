local Item = require("logic.manager.experimental.types.item")
local WishCell = class("WishCell", Dialog)
WishCell.AssetBundleName = "ui/layouts.activitylogin"
WishCell.AssetName = "ActivityLoginWishCell"

function WishCell:Ctor(...)
  WishCell.super.Ctor(self, ...)
end

function WishCell:OnCreate()
  self._text = self:GetChild("Select1/_Text")
  self._select = self:GetChild("Select1/Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnRootClicked, self)
end

function WishCell:OnDestroy()
end

function WishCell:RefreshCell()
  self._text:SetText(TextManager.GetText(self._cellData.textID))
  self._select:SetActive(self._cellData.select)
end

function WishCell:OnRootClicked()
  self._delegate:OnOneCellClicked(self._cellData.index)
end

return WishCell
