-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/roleopstiondialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CSelectItemCfg = (BeanManager.GetTableByName)("item.cselectitemcfg")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CReturnBattlePassCfg = (BeanManager.GetTableByName)("welfare.creturnbattlepasscfg")
local SpecialRecord = CReturnBattlePassCfg:GetRecorder((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnBattlePass)
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

RoleOpstionDialog.SetData = function(self, data, canGet)
  -- function num : 0_3 , upvalues : CSelectItemCfg, SpecialRecord
  self._data = data
  self._canGet = canGet
  self._cellDataList = (CSelectItemCfg:GetRecorder(SpecialRecord.roleselectid)).itemId
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._confirmButton):SetInteractable(self._canGet)
end

RoleOpstionDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

RoleOpstionDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._cellDataList
end

RoleOpstionDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.springfestival.roleopstioncell"
end

RoleOpstionDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._cellDataList)[index]
end

RoleOpstionDialog.OnCellClicked = function(self, id)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).option = id
  ;
  (self._frame):FireEvent(id)
end

RoleOpstionDialog.OnConfirmButtonClick = function(self)
  -- function num : 0_9 , upvalues : CRoleItem, _ENV
  if not self._canGet then
    return 
  end
  if (self._data).option ~= 0 then
    local roleId = (CRoleItem:GetRecorder((self._data).option)).roleid
    do
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(149, nil, function()
    -- function num : 0_9_0 , upvalues : _ENV, self, roleId
    local cmd = (LuaNetManager.CreateProtocol)("protocol.activity.creceivereturncollection")
    cmd.CollectionType = (self._data).CollectionType
    cmd.level = (self._data).level
    cmd.roleId = roleId
    cmd:Send()
  end
, {}, nil, {})
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100444)
    end
  end
end

RoleOpstionDialog.OnCancelButtonClick = function(self)
  -- function num : 0_10
  self:Destroy()
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

