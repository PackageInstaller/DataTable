-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battleeditor/charactorinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CharactorInfoDialog = class("CharactorInfoDialog", Dialog)
CharactorInfoDialog.AssetBundleName = "ui/layouts.battleeditor"
CharactorInfoDialog.AssetName = "CharactorInfo"
CharactorInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharactorInfoDialog
  ((CharactorInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

CharactorInfoDialog.OnCreate = function(self, root)
  -- function num : 0_1 , upvalues : TableFrame
  self._charatorInfoFrame = self:GetChild("CharatorInfoFrame")
  self._exit = self:GetChild("BackBtn")
  ;
  (self._exit):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._frame = (TableFrame.Create)(self._charatorInfoFrame, self, false)
  ;
  (self._frame):ReloadAllCell()
end

CharactorInfoDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

CharactorInfoDialog.NumberOfCell = function(self, frame)
  -- function num : 0_3 , upvalues : RoleConfigTable
  return #RoleConfigTable:GetAllIds()
end

CharactorInfoDialog.CellAtIndex = function(self, frame)
  -- function num : 0_4
  return "battleeditor.charactorinfocell"
end

CharactorInfoDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_5 , upvalues : RoleConfigTable
  local ids = RoleConfigTable:GetAllIds()
  return RoleConfigTable:GetRecorder(ids[index])
end

CharactorInfoDialog.ShouldLengthChange = function(self, frame)
  -- function num : 0_6
  return false
end

CharactorInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("battleeditor.charactorinfodialog")
end

return CharactorInfoDialog

