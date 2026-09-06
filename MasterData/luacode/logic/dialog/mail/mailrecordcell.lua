local TableFrame = require("framework.ui.frame.table.tableframe")
local MailRecordCell = class("MailRecordCell", Dialog)
MailRecordCell.AssetBundleName = "ui/layouts.mail"
MailRecordCell.AssetName = "MailRecordCell"

function MailRecordCell:Ctor(...)
  MailRecordCell.super.Ctor(self, ...)
end

function MailRecordCell:OnCreate()
  self._itemFrame = self:GetChild("Item")
  self._frame = TableFrame.Create(self._itemFrame, self, true, false)
end

function MailRecordCell:OnDestroy()
  self._frame:Destroy()
end

function MailRecordCell:RefreshCell(data)
  self._record = {}
  self._record.time = data.receivingTime
  self._record.list = {}
  for k, v in pairs(data.awards) do
    local item = {}
    item.nameId = k
    item.count = v
    table.insert(self._record.list, item)
  end
  self._frame:ReloadAllCell()
  local tw, th = self._itemFrame:GetRectSize()
  local totalLength = self._frame:GetTotalLength()
  self._itemFrame:SetSize(0, tw, 0, totalLength)
  self._itemFrame:SetPosition(0, 0, 0, 0)
  local rw, rh = self:GetRootWindow():GetRectSize()
  self:GetRootWindow():SetSize(0, rw, 0, rh + totalLength - th)
  self._frame:ReloadAllCell()
end

function MailRecordCell:ShouldLengthChange()
  return true
end

function MailRecordCell:NumberOfCell(frame)
  return #self._record.list
end

function MailRecordCell:CellAtIndex(frame)
  return "mail.mailrecorditemcell"
end

function MailRecordCell:DataAtIndex(frame, index)
  return self._record.list[index]
end

return MailRecordCell
