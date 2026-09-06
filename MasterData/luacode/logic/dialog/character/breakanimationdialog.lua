local BreakAnimationDialog = class("BreakAnimationDialog", Dialog)
BreakAnimationDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
BreakAnimationDialog.AssetName = "BaseCharacterInfoBreakAni"

function BreakAnimationDialog:Ctor(...)
  BreakAnimationDialog.super.Ctor(self, ...)
end

function BreakAnimationDialog:OnCreate()
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

function BreakAnimationDialog:OnAnimationStateExit()
  self:Destroy()
end

return BreakAnimationDialog
