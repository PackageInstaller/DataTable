local TimelineBlackDialog = class("TimelineBlackDialog", Dialog)
TimelineBlackDialog.AssetBundleName = "ui/layouts.dramadialog"
TimelineBlackDialog.AssetName = "DramaBlackNarrator"

function TimelineBlackDialog:Ctor(...)
  TimelineBlackDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TimelineBlackDialog:SetData(value)
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

function TimelineBlackDialog:OnCreate()
  self:GetRootWindow():Subscribe_StateEnterEvent(self.OnAnimatorStateEnter, self)
end

function TimelineBlackDialog:OnAnimatorStateEnter(handle, stateName, normalizedTime)
  DialogManager.DestroySingletonDialog("timeline.timelineblackdialog")
end

function TimelineBlackDialog:AddNewModal()
end

return TimelineBlackDialog
