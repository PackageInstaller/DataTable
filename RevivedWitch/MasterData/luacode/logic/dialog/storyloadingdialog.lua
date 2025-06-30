-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/storyloadingdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StoryLoadingDialog = class("StoryLoadingDialog", Dialog)
StoryLoadingDialog.AssetBundleName = "ui/layouts.basemainhud"
StoryLoadingDialog.AssetName = "BaseCartain"
StoryLoadingDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : StoryLoadingDialog
  ((StoryLoadingDialog.super).Ctor)(self, ...)
  self._groupName = "Loading"
  self._isCover = false
end

StoryLoadingDialog.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

StoryLoadingDialog.OnDestroy = function(self)
  -- function num : 0_2
end

StoryLoadingDialog.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_3
  if stateName == "BaseCartainStart" then
    self._isCover = true
    ;
    (self:GetRootWindow()):PlayAnimation("BaseCartainOver")
  else
    if stateName == "BaseCartainOver" then
      self:Destroy()
    end
  end
end

StoryLoadingDialog.IsCover = function(self)
  -- function num : 0_4
  return self._isCover
end

StoryLoadingDialog.PlayAnimation = function(self, arg)
  -- function num : 0_5
  (self:GetRootWindow()):PlayAnimation(arg)
end

StoryLoadingDialog.SetUnScaleTime = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((((CS.PixelNeko).UI).UIManager).SetAnimatorAndParticleUseUnscaleTime)((self:GetRootWindow())._uiObject)
end

return StoryLoadingDialog

