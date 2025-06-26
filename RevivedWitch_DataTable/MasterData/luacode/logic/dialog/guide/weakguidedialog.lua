-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guide/weakguidedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local WeakGuideDialog = class("WeakGuideDialog", Dialog)
WeakGuideDialog.AssetBundleName = "ui/layouts.guide"
WeakGuideDialog.AssetName = "GuideEmpty"
WeakGuideDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : WeakGuideDialog
  ((WeakGuideDialog.super).Ctor)(self, ...)
  self._effectHandler = nil
end

WeakGuideDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._effect = self:GetChild("Effect")
  ;
  (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1058))
end

WeakGuideDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

WeakGuideDialog.SetEffectPos = function(self, pos)
  -- function num : 0_3
  (self._effect):SetAnchoredPosition(pos.posX, pos.posY)
end

return WeakGuideDialog

