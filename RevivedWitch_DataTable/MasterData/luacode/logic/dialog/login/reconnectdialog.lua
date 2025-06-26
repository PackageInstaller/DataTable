-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/reconnectdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ReconnectDialog = class("ReconnectDialog", Dialog)
ReconnectDialog.AssetBundleName = "ui/layouts.loading"
ReconnectDialog.AssetName = "Reconnection2"
ReconnectDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReconnectDialog
  ((ReconnectDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

ReconnectDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._timer = (GameTimer.AddTask)(0.5, 0, function()
    -- function num : 0_1_0 , upvalues : _ENV, self
    local dlg = (DialogManager.GetDialog)("dungeon.rockerdialog")
    if dlg then
      dlg:Mute()
    end
    dlg = (DialogManager.GetDialog)("dungeon.touchlayer")
    if dlg then
      dlg:Mute()
    end
    self._timer = nil
  end
)
end

ReconnectDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._timer then
    self._timer = (GameTimer.RemoveTask)(self._timer)
  else
    local dlg = (DialogManager.GetDialog)("dungeon.rockerdialog")
    if dlg then
      dlg:UnMute()
    end
    dlg = (DialogManager.GetDialog)("dungeon.touchlayer")
    if dlg then
      dlg:UnMute()
    end
  end
end

return ReconnectDialog

