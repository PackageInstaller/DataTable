local Item = require("logic.manager.experimental.types.item")
local MailRecordItemCell = class("MailRecordItemCell", Dialog)
MailRecordItemCell.AssetBundleName = "ui/layouts.mail"
MailRecordItemCell.AssetName = "MailRecordItemCell"

function MailRecordItemCell:Ctor(...)
  MailRecordItemCell.super.Ctor(self, ...)
end

function MailRecordItemCell:OnCreate()
  self._item = self:GetChild("Item/Item")
  self._num = self:GetChild("Item/Num")
  self._date = self:GetChild("Time/Date")
  self._time = self:GetChild("Time/Time")
end

function MailRecordItemCell:RefreshCell(data)
  local item = Item.Create(data.nameId)
  self._item:SetText(item:GetName())
  self._num:SetText(tostring(data.count))
  local time = self._delegate._cellData.receivingTime
  local stime = os.date("%Y-%m-%d", time // 1000)
  self._date:SetText(stime)
  stime = os.date("%H:%M:%S", time // 1000)
  self._time:SetText(stime)
end

return MailRecordItemCell
