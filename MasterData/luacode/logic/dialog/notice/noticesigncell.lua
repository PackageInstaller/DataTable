local NoticeSignCell = class("NoticeDialog", Dialog)
NoticeSignCell.AssetBundleName = "ui/layouts.activeannouce"
NoticeSignCell.AssetName = "FootCell"

function NoticeSignCell:Ctor(...)
  NoticeSignCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function NoticeSignCell:OnCreate()
  self._content = self:GetChild("Text")
end

function NoticeSignCell:OnDestroy()
end

function NoticeSignCell:RefreshCell(data)
  self._content:SetText(self._cellData.content)
  _, self._total = self._content:GetPreferredSize()
  self._content:SetHeight(0, self._total)
end

return NoticeSignCell
