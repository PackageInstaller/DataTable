local StoryLoadingDialog = class("StoryLoadingDialog", Dialog)
StoryLoadingDialog.AssetBundleName = "ui/layouts.basemainhud"
StoryLoadingDialog.AssetName = "BaseCartain"

function StoryLoadingDialog:Ctor(...)
  StoryLoadingDialog.super.Ctor(self, ...)
  self._groupName = "Loading"
  self._isCover = false
end

function StoryLoadingDialog:OnCreate()
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

function StoryLoadingDialog:OnDestroy()
end

function StoryLoadingDialog:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "BaseCartainStart" then
    self._isCover = true
    self:GetRootWindow():PlayAnimation("BaseCartainOver")
  elseif stateName == "BaseCartainOver" then
    self:Destroy()
  end
end

function StoryLoadingDialog:IsCover()
  return self._isCover
end

function StoryLoadingDialog:PlayAnimation(arg)
  self:GetRootWindow():PlayAnimation(arg)
end

function StoryLoadingDialog:SetUnScaleTime()
  CS.PixelNeko.UI.UIManager.SetAnimatorAndParticleUseUnscaleTime(self:GetRootWindow()._uiObject)
end

return StoryLoadingDialog
