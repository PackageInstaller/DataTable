local NoticeTextCell = class("NoticeDialog", Dialog)
NoticeTextCell.AssetBundleName = "ui/layouts.activeannouce"
NoticeTextCell.AssetName = "TextMainCell"

function NoticeTextCell:Ctor(...)
  NoticeTextCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function NoticeTextCell:OnCreate()
  self._content = self:GetChild("TextMainCell")
  self._content:Subscribe_ClickLinkEvent(self.OnLinkClick, self)
  self._initialHeightAnchor, self._initialHeightOffset = self:GetRootWindow():GetHeight()
end

function NoticeTextCell:OnDestroy()
end

function NoticeTextCell:RefreshCell(data)
  self._content:SetText(self._cellData.content)
  self._total = self._content:GetPreferredValues().y
  self._content:SetHeight(0, self._total)
  self:GetRootWindow():SetHeight(self._initialHeightAnchor, self._initialHeightOffset + self._total)
end

function NoticeTextCell:OnLinkClick(link)
  self._delegate:OnLinkClick(link)
end

return NoticeTextCell
