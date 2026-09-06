local GridFrame = require("framework.ui.frame.grid.gridframe")
local CSelectItemCfg = BeanManager.GetTableByName("item.cselectitemcfg")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local CReturnBattlePassCfg = BeanManager.GetTableByName("welfare.creturnbattlepasscfg")
local SpecialRecord = CReturnBattlePassCfg:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnBattlePass)
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

function RoleOpstionDialog:SetData(data, canGet)
  self._data = data
  self._canGet = canGet
  self._cellDataList = CSelectItemCfg:GetRecorder(SpecialRecord.roleselectid).itemId
  self._frame:ReloadAllCell()
  self._confirmButton:SetInteractable(self._canGet)
end

function RoleOpstionDialog:OnBackBtnClicked()
  self:Destroy()
end

function RoleOpstionDialog:NumberOfCell(frame)
  return #self._cellDataList
end

function RoleOpstionDialog:CellAtIndex(frame, index)
  return "activity.springfestival.roleopstioncell"
end

function RoleOpstionDialog:DataAtIndex(frame, index)
  return self._cellDataList[index]
end

function RoleOpstionDialog:OnCellClicked(id)
  self._data.option = id
  self._frame:FireEvent(id)
end

function RoleOpstionDialog:OnConfirmButtonClick()
  if not self._canGet then
    return
  end
  if self._data.option ~= 0 then
    local roleId = CRoleItem:GetRecorder(self._data.option).roleid
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(149, nil, function()
      local cmd = LuaNetManager.CreateProtocol("protocol.activity.creceivereturncollection")
      cmd.CollectionType = self._data.CollectionType
      cmd.level = self._data.level
      cmd.roleId = roleId
      cmd:Send()
    end, {}, nil, {})
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100444)
  end
end

function RoleOpstionDialog:OnCancelButtonClick()
  self:Destroy()
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
