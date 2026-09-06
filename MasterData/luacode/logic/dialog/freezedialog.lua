local FreezeDialog = class("FreezeDialog", Dialog)
FreezeDialog.AssetBundleName = "ui/layouts"
FreezeDialog.AssetName = "PlayerControlFreeze"

function FreezeDialog:Ctor(...)
  FreezeDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function FreezeDialog:OnCreate()
  self._count = 0
end

function FreezeDialog:OnDestroy()
end

function FreezeDialog:AddCount(animated)
  if animated and self._count <= 0 then
    self:GetRootWindow():SetAnimatorBool("onEnter", true)
    self._animated = true
  end
  self._count = self._count + 1
end

function FreezeDialog:RemoveCount(animated)
  self._count = self._count - 1
  if self._count <= 0 then
    if animated then
      if self._animated then
        self:GetRootWindow():Subscribe_AnimationEvent("FadeOut", function()
          DialogManager.DestroySingletonDialog("freezedialog")
        end)
        self:GetRootWindow():SetAnimatorBool("onExit", true)
      else
        DialogManager.DestroySingletonDialog("freezedialog")
        if global_var_debug then
          LogError("timeline", "")
        end
      end
    else
      DialogManager.DestroySingletonDialog("freezedialog")
    end
  end
end

return FreezeDialog
