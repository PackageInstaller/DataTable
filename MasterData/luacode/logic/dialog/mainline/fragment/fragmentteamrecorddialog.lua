local TableFrame = require("framework.ui.frame.table.tableframe")
local FragmentTeamRecordDialog = class("FragmentTeamRecordDialog", Dialog)
FragmentTeamRecordDialog.AssetBundleName = "ui/layouts.fragment"
FragmentTeamRecordDialog.AssetName = "FragmentTeamRecord"

function FragmentTeamRecordDialog:Ctor(...)
  FragmentTeamRecordDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

function FragmentTeamRecordDialog:OnCreate()
  self._empty = self:GetChild("Back/Empty")
  self._frameUI = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._frameUI, self, true, false)
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function FragmentTeamRecordDialog:OnDestroy()
  self._frame:Destroy()
end

function FragmentTeamRecordDialog:SetData(data)
  self._data = data
  if self._data == nil or #self._data == 0 then
    return
  end
  self._empty:SetActive(false)
  self._frame:ReloadAllCell()
end

function FragmentTeamRecordDialog:OnBackBtnClicked()
  self:Destroy()
end

function FragmentTeamRecordDialog:NumberOfCell(frame, index)
  return #self._data
end

function FragmentTeamRecordDialog:CellAtIndex(frame, index)
  return "mainline.fragment.teamrecordcell"
end

function FragmentTeamRecordDialog:DataAtIndex(frame, index)
  return self._data[index]
end

return FragmentTeamRecordDialog
