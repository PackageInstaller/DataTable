local TableFrame = require("framework.ui.frame.table.tableframe")
local MailRecordDialog = class("MailRecordDialog", Dialog)
MailRecordDialog.AssetBundleName = "ui/layouts.mail"
MailRecordDialog.AssetName = "MailRecord"
local TopToBottom = 3

function MailRecordDialog:Ctor(...)
  MailRecordDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._recordList = {}
end

function MailRecordDialog:OnCreate()
  self._empty = self:GetChild("Empty")
  self._backBtn = self:GetChild("BackBtn")
  self._scrollBar = self:GetChild("RecordFrame/Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._recordFrame = self:GetChild("RecordFrame/Record")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = TableFrame.Create(self._recordFrame, self, true)
end

function MailRecordDialog:OnDestroy()
  self._frame:Destroy()
end

function MailRecordDialog:OnSSendReceivingRecords(protocol)
  self._recordList = protocol.records
  self._empty:SetActive(#self._recordList <= 0)
  self._frame:ReloadAllCell()
end

function MailRecordDialog:OnCurPosChange(frame, proportion)
  local width, height = self._recordFrame:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function MailRecordDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("mail.mailrecorddialog")
end

function MailRecordDialog:ShouldLengthChange()
  return true
end

function MailRecordDialog:NumberOfCell(frame)
  return #self._recordList
end

function MailRecordDialog:CellAtIndex(frame)
  return "mail.mailrecordcell"
end

function MailRecordDialog:DataAtIndex(frame, index)
  return self._recordList[index]
end

return MailRecordDialog
