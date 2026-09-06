local NoticeTitle2Cell = class("NoticeDialog", Dialog)
NoticeTitle2Cell.AssetBundleName = "ui/layouts.activeannouce"
NoticeTitle2Cell.AssetName = "SubTitleCell"

function NoticeTitle2Cell:Ctor(...)
  NoticeTitle2Cell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function NoticeTitle2Cell:OnCreate()
  self._content = self:GetChild("Text")
end

function NoticeTitle2Cell:OnDestroy()
end

function NoticeTitle2Cell:RefreshCell(data)
  self._content:SetText(self._cellData.content)
end

return NoticeTitle2Cell
