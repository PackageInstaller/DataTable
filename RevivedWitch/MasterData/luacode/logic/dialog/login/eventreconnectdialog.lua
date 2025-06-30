-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/eventreconnectdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EventReconnectDialog = class("EventReconnectDialog", Dialog)
EventReconnectDialog.AssetBundleName = "ui/layouts.loading"
EventReconnectDialog.AssetName = "Reconnection"
EventReconnectDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EventReconnectDialog
  ((EventReconnectDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

EventReconnectDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local dlg = (DialogManager.GetDialog)("dungeon.touchlayer")
  if dlg then
    dlg:Mute()
  end
  self._timer = (GameTimer.AddTask)(0.2, 0, function()
    -- function num : 0_1_0 , upvalues : dlg, _ENV, self
    dlg = (DialogManager.GetDialog)("dungeon.rockerdialog")
    if dlg then
      dlg:Mute()
    end
    self._timer = nil
  end
)
end

EventReconnectDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local dlg = (DialogManager.GetDialog)("dungeon.touchlayer")
  if dlg then
    dlg:UnMute()
  end
  if self._timer then
    self._timer = (GameTimer.RemoveTask)(self._timer)
  else
    dlg = (DialogManager.GetDialog)("dungeon.rockerdialog")
    if dlg then
      dlg:UnMute()
    end
  end
end

return EventReconnectDialog

