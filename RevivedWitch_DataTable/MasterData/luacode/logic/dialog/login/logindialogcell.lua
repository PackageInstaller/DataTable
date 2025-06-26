-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/logindialogcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoginDialogCell = class("LoginDialogCell", Dialog)
LoginDialogCell.AssetBundleName = "ui/layouts.login"
LoginDialogCell.AssetName = "LoginDialogCell"
LoginDialogCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoginDialogCell
  ((LoginDialogCell.super).Ctor)(self, ...)
end

LoginDialogCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("_Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

LoginDialogCell.OnDestroy = function(self)
  -- function num : 0_2
end

LoginDialogCell.RefreshCell = function(self, data)
  -- function num : 0_3
  (self._name):SetText(data.name)
end

LoginDialogCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):OnCellClicked(self._cellData)
end

return LoginDialogCell

