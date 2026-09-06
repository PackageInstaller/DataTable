local TimelineCoverDialog = class("TimelineCoverDialog", Dialog)
TimelineCoverDialog.AssetBundleName = "ui/layouts.dramadialog"
TimelineCoverDialog.AssetName = "TimeLineTransit"

function TimelineCoverDialog:Ctor(...)
  TimelineCoverDialog.super.Ctor(self, ...)
  self._groupName = "Message"
end

function TimelineCoverDialog:SetData(value)
  local param = string.split(value, ";")
  if #param == 1 then
    if tonumber(value) then
      self:GetRootWindow():SetAnimatorInteger("curtainStyle", tonumber(value))
    elseif value == "unscale" then
      CS.PixelNeko.UI.UIManager.SetAnimatorAndParticleUseUnscaleTime(self:GetRootWindow()._uiObject)
    end
  elseif #param == 2 then
    self:GetRootWindow():SetAnimatorInteger("curtainStyle", tonumber(param[1]))
    if param[2] == "unscale" then
      CS.PixelNeko.UI.UIManager.SetAnimatorAndParticleUseUnscaleTime(self:GetRootWindow()._uiObject)
    end
  else
    self:GetRootWindow():SetAnimatorInteger("curtainStyle", tonumber(value))
  end
end

function TimelineCoverDialog:OnCreate()
  self:GetRootWindow():Subscribe_StateEnterEvent(self.OnAnimatorStateEnter, self)
end

function TimelineCoverDialog:OnAnimatorStateEnter(handle, stateName, normalizedTime)
  DialogManager.DestroySingletonDialog("timeline.timelinecoverdialog")
end

return TimelineCoverDialog
