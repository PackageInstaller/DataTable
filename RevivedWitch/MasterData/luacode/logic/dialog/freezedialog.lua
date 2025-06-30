-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/freezedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FreezeDialog = class("FreezeDialog", Dialog)
FreezeDialog.AssetBundleName = "ui/layouts"
FreezeDialog.AssetName = "PlayerControlFreeze"
FreezeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FreezeDialog
  ((FreezeDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

FreezeDialog.OnCreate = function(self)
  -- function num : 0_1
  self._count = 0
end

FreezeDialog.OnDestroy = function(self)
  -- function num : 0_2
end

FreezeDialog.AddCount = function(self, animated)
  -- function num : 0_3
  if animated and self._count <= 0 then
    (self:GetRootWindow()):SetAnimatorBool("onEnter", true)
    self._animated = true
  end
  self._count = self._count + 1
end

FreezeDialog.RemoveCount = function(self, animated)
  -- function num : 0_4 , upvalues : _ENV
  self._count = self._count - 1
  if self._count <= 0 then
    if animated then
      if self._animated then
        (self:GetRootWindow()):Subscribe_AnimationEvent("FadeOut", function()
    -- function num : 0_4_0 , upvalues : _ENV
    (DialogManager.DestroySingletonDialog)("freezedialog")
  end
)
        ;
        (self:GetRootWindow()):SetAnimatorBool("onExit", true)
      else
        ;
        (DialogManager.DestroySingletonDialog)("freezedialog")
        if global_var_debug then
          LogError("timeline", "")
        end
      end
    else
      ;
      (DialogManager.DestroySingletonDialog)("freezedialog")
    end
  end
end

return FreezeDialog

