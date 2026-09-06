local NoticeTitle1Cell = class("NoticeDialog", Dialog)
NoticeTitle1Cell.AssetBundleName = "ui/layouts.activeannouce"
NoticeTitle1Cell.AssetName = "HeadTitleCell"

function NoticeTitle1Cell:Ctor(...)
  NoticeTitle1Cell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function NoticeTitle1Cell:OnCreate()
  self._content = self:GetChild("Text")
end

function NoticeTitle1Cell:OnDestroy()
end

function NoticeTitle1Cell:RefreshCell(data)
  self._content:SetText(self._cellData.content)
end

return NoticeTitle1Cell
