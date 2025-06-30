-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mail/mailrecordcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local MailRecordCell = class("MailRecordCell", Dialog)
MailRecordCell.AssetBundleName = "ui/layouts.mail"
MailRecordCell.AssetName = "MailRecordCell"
MailRecordCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MailRecordCell
  ((MailRecordCell.super).Ctor)(self, ...)
end

MailRecordCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._itemFrame = self:GetChild("Item")
  self._frame = (TableFrame.Create)(self._itemFrame, self, true, false)
end

MailRecordCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

MailRecordCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._record = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._record).time = data.receivingTime
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._record).list = {}
  for k,v in pairs(data.awards) do
    local item = {}
    item.nameId = k
    item.count = v
    ;
    (table.insert)((self._record).list, item)
  end
  ;
  (self._frame):ReloadAllCell()
  local tw, th = (self._itemFrame):GetRectSize()
  local totalLength = (self._frame):GetTotalLength()
  ;
  (self._itemFrame):SetSize(0, tw, 0, totalLength)
  ;
  (self._itemFrame):SetPosition(0, 0, 0, 0)
  local rw, rh = (self:GetRootWindow()):GetRectSize()
  ;
  (self:GetRootWindow()):SetSize(0, rw, 0, rh + totalLength - th)
  ;
  (self._frame):ReloadAllCell()
end

MailRecordCell.ShouldLengthChange = function(self)
  -- function num : 0_4
  return true
end

MailRecordCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #(self._record).list
end

MailRecordCell.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "mail.mailrecorditemcell"
end

MailRecordCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return ((self._record).list)[index]
end

return MailRecordCell

