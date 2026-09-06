local NoticePageCell = class("NoticeDialog", Dialog)
NoticePageCell.AssetBundleName = "ui/layouts.activeannouce"
NoticePageCell.AssetName = "PageGroupButton"

function NoticePageCell:Ctor(...)
  NoticePageCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function NoticePageCell:OnCreate()
  self._button = self:GetChild("GroupBtn")
  self._title = self:GetChild("GroupBtn/Txt")
  self._day = self:GetChild("GroupBtn/dateDay")
  self._month = self:GetChild("GroupBtn/dateMonth")
  self._button:Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function NoticePageCell:OnDestroy()
end

function NoticePageCell:RefreshCell(data)
  self._title:SetText(self._cellData.data.title)
  self._day:SetText(string.format("%02d", self._cellData.data.time.day))
  self._month:SetText(string.format("%02d", self._cellData.data.time.month))
end

function NoticePageCell:OnCellClick()
  self._delegate:OnPageClick(self._cellData.index)
end

function NoticePageCell:OnEvent(name, args)
  if name == "selected" then
    self._button:SetSelected(args == self._cellData.index)
  end
end

return NoticePageCell
