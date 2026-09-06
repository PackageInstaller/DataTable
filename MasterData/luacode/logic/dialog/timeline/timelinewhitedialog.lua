local TimelineWhiteDialog = class("TimelineWhiteDialog", Dialog)
TimelineWhiteDialog.AssetBundleName = "ui/layouts.battlewin"
TimelineWhiteDialog.AssetName = "MemoryWhiteScreen"

function TimelineWhiteDialog:Ctor(...)
  TimelineWhiteDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TimelineWhiteDialog:OnCreate()
  self:GetRootWindow():Subscribe_AnimationEvent("MemoryWhiteScreen", self.OnStateUpdate, self)
end

function TimelineWhiteDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TimelineWhiteDialog:SetData(value)
  self._id = tonumber(value)
end

function TimelineWhiteDialog:OnStateUpdate(handle, stateName, normalizedTime)
  self._dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
  self._dialog:SetDialogLibraryId(self._id)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy)
end

function TimelineWhiteDialog:OnDialogDestroy(notification)
  if notification.userInfo._dialogKey ~= self._dialog._dialogKey then
    return
  end
  DialogManager.DestroySingletonDialog("timeline.timelinewhitedialog")
end

function TimelineWhiteDialog:AddNewModal(dialog)
end

return TimelineWhiteDialog
