-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/fragment/fragmentteamrecorddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local FragmentTeamRecordDialog = class("FragmentTeamRecordDialog", Dialog)
FragmentTeamRecordDialog.AssetBundleName = "ui/layouts.fragment"
FragmentTeamRecordDialog.AssetName = "FragmentTeamRecord"
FragmentTeamRecordDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FragmentTeamRecordDialog
  ((FragmentTeamRecordDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

FragmentTeamRecordDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._empty = self:GetChild("Back/Empty")
  self._frameUI = self:GetChild("Back/Frame")
  self._frame = (TableFrame.Create)(self._frameUI, self, true, false)
  self._closeBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

FragmentTeamRecordDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

FragmentTeamRecordDialog.SetData = function(self, data)
  -- function num : 0_3
  self._data = data
  if self._data == nil or #self._data == 0 then
    return 
  end
  ;
  (self._empty):SetActive(false)
  ;
  (self._frame):ReloadAllCell()
end

FragmentTeamRecordDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

FragmentTeamRecordDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_5
  return #self._data
end

FragmentTeamRecordDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "mainline.fragment.teamrecordcell"
end

FragmentTeamRecordDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

return FragmentTeamRecordDialog

