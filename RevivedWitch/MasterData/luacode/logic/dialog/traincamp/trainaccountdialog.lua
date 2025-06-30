-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/traincamp/trainaccountdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TrainAccountDialog = class("TrainAccountDialog", Dialog)
TrainAccountDialog.AssetBundleName = "ui/layouts.yard"
TrainAccountDialog.AssetName = "TrainFinish"
TrainAccountDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TrainAccountDialog
  ((TrainAccountDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._data = {}
end

TrainAccountDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, false, false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

TrainAccountDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

TrainAccountDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (table.insert)(self._data, {type = (data.protocol).resultType, award = (data.protocol).result, roleId = data.roleId})
  ;
  (self._frame):ReloadAllCell()
  local width, height = (self._panel):GetRectSize()
  local cellPanelWidth = width / 3 * #self._data
  ;
  (self._panel):SetDeltaSize(cellPanelWidth, height)
  ;
  (self._frame):ReloadAllCell()
end

TrainAccountDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return 1
end

TrainAccountDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "traincamp.trainaccountcell"
end

TrainAccountDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

TrainAccountDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

return TrainAccountDialog

