local GridFrame = require("framework.ui.frame.grid.gridframe")
local CSelectItemCfg = BeanManager.GetTableByName("item.cselectitemcfg")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleOpstionDialog = class("RoleOpstionDialog", Dialog)
RoleOpstionDialog.AssetBundleName = "ui/layouts.activitynewyear"
RoleOpstionDialog.AssetName = "ActivityNewYearRoleOptional"

function RoleOpstionDialog:Ctor(...)
  RoleOpstionDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

local ColumnNum = 6

function RoleOpstionDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton = self:GetChild("ConfirmButton")
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmButtonClick, self)
  self._scrollbar = self:GetChild("Scrollbar")
  self._cancelButton = self:GetChild("CancelButton")
  self._cancelButton:Subscribe_PointerClickEvent(self.OnCancelButtonClick, self)
  self._panel = self:GetChild("RecordFrame")
  self._frame = GridFrame.Create(self._panel, self, true, ColumnNum)
  self._scrollbar = self:GetChild("Scrollbar")
end

function RoleOpstionDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function RoleOpstionDialog:SetData(data, delegate)
  self._delegate = delegate
  self._data = data
  self._cellData = CSelectItemCfg:GetRecorder(data.id).itemId
  self._frame:ReloadAllCell()
end

function RoleOpstionDialog:OnBackBtnClicked()
  self:Destroy()
end

function RoleOpstionDialog:NumberOfCell(frame)
  return #self._cellData
end

function RoleOpstionDialog:CellAtIndex(frame, index)
  return "activity.springfestival.roleopstioncell"
end

function RoleOpstionDialog:DataAtIndex(frame, index)
  return self._cellData[index]
end

function RoleOpstionDialog:OnCellClicked(id, imageID)
  self._delegate:OnSelect(id)
  self._frame:FireEvent(id)
end

function RoleOpstionDialog:OnConfirmButtonClick()
  if self._data.option and self._data.option > 0 then
    self:Destroy()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100444)
  end
end

function RoleOpstionDialog:OnCancelButtonClick()
  if self._data.option and self._data.option > 0 then
    self._delegate:OnSelect(0)
    self:Destroy()
  else
    self:Destroy()
  end
end

function RoleOpstionDialog:OnCurPosChange(frame, proportion)
  local width, height = self._panel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollbar:SetActive(true)
    self._scrollbar:SetScrollSize(height / total)
    self._scrollbar:SetScrollValue(proportion)
  else
    self._scrollbar:SetActive(false)
  end
end

return RoleOpstionDialog
