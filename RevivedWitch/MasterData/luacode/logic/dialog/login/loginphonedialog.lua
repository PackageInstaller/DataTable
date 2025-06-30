-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/loginphonedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local LoginPhoneDialog = class("LoginPhoneDialog", Dialog)
LoginPhoneDialog.AssetBundleName = "ui/layouts.login"
LoginPhoneDialog.AssetName = "LoginDialogPhone"
local columnNums = 6
LoginPhoneDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoginPhoneDialog
  ((LoginPhoneDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

LoginPhoneDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, columnNums, GridFrame
  self._panel = self:GetChild("Frame")
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(1)
  self._data = client_server_list
  local canSlide = true
  if #self._data <= columnNums * 2 then
    canSlide = false
  end
  self._frame = (GridFrame.Create)(self._panel, self, true, columnNums, canSlide)
  ;
  (self._frame):ReloadAllCell()
end

LoginPhoneDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (UIBackManager.SetUIBackShow)(false)
end

LoginPhoneDialog.Init = function(self, delegate)
  -- function num : 0_3
  self._delegate = delegate
end

LoginPhoneDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

LoginPhoneDialog.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "login.logindialogcell"
end

LoginPhoneDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

LoginPhoneDialog.OnCellClicked = function(self, data)
  -- function num : 0_7
  self:Destroy()
  ;
  (self._delegate):OnServerCellClicked(data)
end

return LoginPhoneDialog

