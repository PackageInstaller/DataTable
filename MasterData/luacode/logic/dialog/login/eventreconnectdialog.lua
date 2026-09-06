local EventReconnectDialog = class("EventReconnectDialog", Dialog)
EventReconnectDialog.AssetBundleName = "ui/layouts.loading"
EventReconnectDialog.AssetName = "Reconnection"

function EventReconnectDialog:Ctor(...)
  EventReconnectDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function EventReconnectDialog:OnCreate()
  local dlg = DialogManager.GetDialog("dungeon.touchlayer")
  if dlg then
    dlg:Mute()
  end
  self._timer = GameTimer.AddTask(0.2, 0, function()
    dlg = DialogManager.GetDialog("dungeon.rockerdialog")
    if dlg then
      dlg:Mute()
    end
    self._timer = nil
  end)
end

function EventReconnectDialog:OnDestroy()
  local dlg = DialogManager.GetDialog("dungeon.touchlayer")
  if dlg then
    dlg:UnMute()
  end
  if self._timer then
    self._timer = GameTimer.RemoveTask(self._timer)
  else
    dlg = DialogManager.GetDialog("dungeon.rockerdialog")
    if dlg then
      dlg:UnMute()
    end
  end
end

return EventReconnectDialog
