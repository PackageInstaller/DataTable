local NoticeImageCell = class("NoticeDialog", Dialog)
NoticeImageCell.AssetBundleName = "ui/layouts.activeannouce"
NoticeImageCell.AssetName = "HeadImageCell"

function NoticeImageCell:Ctor(...)
  NoticeImageCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function NoticeImageCell:OnCreate()
  self._content = self:GetChild("Image")
  self._content:Subscribe_PointerClickEvent(self.OnPointerClick, self)
  self._initialHeightAnchor, self._initialHeightOffset = self:GetRootWindow():GetHeight()
end

function NoticeImageCell:OnDestroy()
end

function NoticeImageCell:RefreshCell(data)
  CS.PixelNeko.P1.Platform.ImageHttpHelperStaticFunctions.LoadImage(self._content:GetUIObject(), self._cellData.content)
  local height = self._cellData.attrs.height
  self._content:SetHeight(0, height)
  LogInfo("notice", height, self._initialHeightAnchor, self._initialHeightOffset)
  self:GetRootWindow():SetHeight(self._initialHeightAnchor, self._initialHeightOffset + height)
end

function NoticeImageCell:OnPointerClick()
  local link = self._cellData.attrs.link
  if link ~= nil then
    self._delegate:OnLinkClick(link)
  end
end

return NoticeImageCell
