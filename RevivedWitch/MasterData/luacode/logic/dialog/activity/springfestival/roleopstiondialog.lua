-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/roleopstiondialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CSelectItemCfg = (BeanManager.GetTableByName)("item.cselectitemcfg")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RoleOpstionDialog = class("RoleOpstionDialog", Dialog)
RoleOpstionDialog.AssetBundleName = "ui/layouts.activitynewyear"
RoleOpstionDialog.AssetName = "ActivityNewYearRoleOptional"
RoleOpstionDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleOpstionDialog
  ((RoleOpstionDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

local ColumnNum = 6
RoleOpstionDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, ColumnNum
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton = self:GetChild("ConfirmButton")
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmButtonClick, self)
  self._scrollbar = self:GetChild("Scrollbar")
  self._cancelButton = self:GetChild("CancelButton")
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnCancelButtonClick, self)
  self._panel = self:GetChild("RecordFrame")
  self._frame = (GridFrame.Create)(self._panel, self, true, ColumnNum)
  self._scrollbar = self:GetChild("Scrollbar")
end

RoleOpstionDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

RoleOpstionDialog.SetData = function(self, data, delegate)
  -- function num : 0_3 , upvalues : CSelectItemCfg
  self._delegate = delegate
  self._data = data
  self._cellData = (CSelectItemCfg:GetRecorder(data.id)).itemId
  ;
  (self._frame):ReloadAllCell()
end

RoleOpstionDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

RoleOpstionDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._cellData
end

RoleOpstionDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.springfestival.roleopstioncell"
end

RoleOpstionDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._cellData)[index]
end

RoleOpstionDialog.OnCellClicked = function(self, id, imageID)
  -- function num : 0_8
  (self._delegate):OnSelect(id)
  ;
  (self._frame):FireEvent(id)
end

RoleOpstionDialog.OnConfirmButtonClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (self._data).option and (self._data).option > 0 then
    self:Destroy()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100444)
  end
end

RoleOpstionDialog.OnCancelButtonClick = function(self)
  -- function num : 0_10
  if (self._data).option and (self._data).option > 0 then
    (self._delegate):OnSelect(0)
    self:Destroy()
  else
    self:Destroy()
  end
end

RoleOpstionDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_11
  local width, height = (self._panel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollbar):SetActive(true)
    ;
    (self._scrollbar):SetScrollSize(height / total)
    ;
    (self._scrollbar):SetScrollValue(proportion)
  else
    ;
    (self._scrollbar):SetActive(false)
  end
end

return RoleOpstionDialog

