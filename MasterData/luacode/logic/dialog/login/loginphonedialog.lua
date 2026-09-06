local GridFrame = require("framework.ui.frame.grid.gridframe")
local LoginPhoneDialog = class("LoginPhoneDialog", Dialog)
LoginPhoneDialog.AssetBundleName = "ui/layouts.login"
LoginPhoneDialog.AssetName = "LoginDialogPhone"
local columnNums = 6

function LoginPhoneDialog:Ctor(...)
  LoginPhoneDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function LoginPhoneDialog:OnCreate()
  self._panel = self:GetChild("Frame")
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(1)
  self._data = client_server_list
  local canSlide = true
  if #self._data <= columnNums * 2 then
    canSlide = false
  end
  self._frame = GridFrame.Create(self._panel, self, true, columnNums, canSlide)
  self._frame:ReloadAllCell()
end

function LoginPhoneDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  UIBackManager.SetUIBackShow(false)
end

function LoginPhoneDialog:Init(delegate)
  self._delegate = delegate
end

function LoginPhoneDialog:NumberOfCell(frame)
  return #self._data
end

function LoginPhoneDialog:CellAtIndex(frame)
  return "login.logindialogcell"
end

function LoginPhoneDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function LoginPhoneDialog:OnCellClicked(data)
  self:Destroy()
  self._delegate:OnServerCellClicked(data)
end

return LoginPhoneDialog
