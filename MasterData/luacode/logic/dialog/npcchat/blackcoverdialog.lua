local BlackCoverDialog = class("BlackCoverDialog", Dialog)
BlackCoverDialog.AssetBundleName = "ui/layouts.dramadialog"
BlackCoverDialog.AssetName = "TimeLineTransit"

function BlackCoverDialog:Ctor(...)
  BlackCoverDialog.super.Ctor(self, ...)
end

function BlackCoverDialog:OnCreate()
  self:GetRootWindow():Subscribe_StateEnterEvent(self.OnAnimatorStateEnter, self)
end

function BlackCoverDialog:SetData(value)
  self:GetRootWindow():SetAnimatorInteger("curtainStyle", tonumber(value))
end

function BlackCoverDialog:OnAnimatorStateEnter(handle, stateName, normalizedTime)
  self:Destroy()
end

return BlackCoverDialog
