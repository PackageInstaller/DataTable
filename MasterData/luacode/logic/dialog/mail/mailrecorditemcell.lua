-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mail/mailrecorditemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local MailRecordItemCell = class("MailRecordItemCell", Dialog)
MailRecordItemCell.AssetBundleName = "ui/layouts.mail"
MailRecordItemCell.AssetName = "MailRecordItemCell"
MailRecordItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MailRecordItemCell
  ((MailRecordItemCell.super).Ctor)(self, ...)
end

MailRecordItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._item = self:GetChild("Item/Item")
  self._num = self:GetChild("Item/Num")
  self._date = self:GetChild("Time/Date")
  self._time = self:GetChild("Time/Time")
end

MailRecordItemCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : Item, _ENV
  local item = (Item.Create)(data.nameId)
  ;
  (self._item):SetText(item:GetName())
  ;
  (self._num):SetText(tostring(data.count))
  local time = ((self._delegate)._cellData).receivingTime
  local stime = (os.date)("%Y-%m-%d", time // 1000)
  ;
  (self._date):SetText(stime)
  stime = (os.date)("%H:%M:%S", time // 1000)
  ;
  (self._time):SetText(stime)
end

return MailRecordItemCell

