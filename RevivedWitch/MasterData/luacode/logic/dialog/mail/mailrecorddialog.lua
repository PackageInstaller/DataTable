-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mail/mailrecorddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local MailRecordDialog = class("MailRecordDialog", Dialog)
MailRecordDialog.AssetBundleName = "ui/layouts.mail"
MailRecordDialog.AssetName = "MailRecord"
local TopToBottom = 3
MailRecordDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MailRecordDialog
  ((MailRecordDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._recordList = {}
end

MailRecordDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TopToBottom, TableFrame
  self._empty = self:GetChild("Empty")
  self._backBtn = self:GetChild("BackBtn")
  self._scrollBar = self:GetChild("RecordFrame/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(TopToBottom)
  self._recordFrame = self:GetChild("RecordFrame/Record")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = (TableFrame.Create)(self._recordFrame, self, true)
end

MailRecordDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

MailRecordDialog.OnSSendReceivingRecords = function(self, protocol)
  -- function num : 0_3
  self._recordList = protocol.records
  ;
  (self._empty):SetActive(#self._recordList <= 0)
  ;
  (self._frame):ReloadAllCell()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

MailRecordDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_4
  local width, height = (self._recordFrame):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

MailRecordDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("mail.mailrecorddialog")
end

MailRecordDialog.ShouldLengthChange = function(self)
  -- function num : 0_6
  return true
end

MailRecordDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._recordList
end

MailRecordDialog.CellAtIndex = function(self, frame)
  -- function num : 0_8
  return "mail.mailrecordcell"
end

MailRecordDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._recordList)[index]
end

return MailRecordDialog

