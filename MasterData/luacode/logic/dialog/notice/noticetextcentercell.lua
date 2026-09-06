local NoticeTextCenterCell = class("NoticeDialog", Dialog)
NoticeTextCenterCell.AssetBundleName = "ui/layouts.activeannouce"
NoticeTextCenterCell.AssetName = "TextMainCenterCell"

function NoticeTextCenterCell:Ctor(...)
  NoticeTextCenterCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function NoticeTextCenterCell:OnCreate()
  self._content = self:GetChild("TextMainCell")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnLinkClick, self)
end

function NoticeTextCenterCell:OnDestroy()
end

function NoticeTextCenterCell:RefreshCell(data)
  self._content:SetText(self._cellData.content)
  _, self._total = self._content:GetPreferredSize()
  self._content:SetYPosition(0, 0)
  self._content:SetHeight(0, self._total)
  self:GetRootWindow():SetHeight(0, self._total)
end

function NoticeTextCenterCell:OnLinkClick()
  if self._cellData.attr == "link" then
    self._delegate:OnLinkClick(self._cellData.value)
  end
end

return NoticeTextCenterCell
