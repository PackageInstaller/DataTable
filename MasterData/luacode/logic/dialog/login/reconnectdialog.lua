local ReconnectDialog = class("ReconnectDialog", Dialog)
ReconnectDialog.AssetBundleName = "ui/layouts.loading"
ReconnectDialog.AssetName = "Reconnection2"

function ReconnectDialog:Ctor(...)
  ReconnectDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function ReconnectDialog:OnCreate()
  self._timer = GameTimer.AddTask(0.5, 0, function()
    local dlg = DialogManager.GetDialog("dungeon.rockerdialog")
    if dlg then
      dlg:Mute()
    end
    dlg = DialogManager.GetDialog("dungeon.touchlayer")
    if dlg then
      dlg:Mute()
    end
    self._timer = nil
  end)
end

function ReconnectDialog:OnDestroy()
  if self._timer then
    self._timer = GameTimer.RemoveTask(self._timer)
  else
    local dlg = DialogManager.GetDialog("dungeon.rockerdialog")
    if dlg then
      dlg:UnMute()
    end
    dlg = DialogManager.GetDialog("dungeon.touchlayer")
    if dlg then
      dlg:UnMute()
    end
  end
end

return ReconnectDialog
