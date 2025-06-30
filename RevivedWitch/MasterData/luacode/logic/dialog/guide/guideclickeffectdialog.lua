-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guide/guideclickeffectdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideClickEffectDialog = class("GuideClickEffectDialog", Dialog)
GuideClickEffectDialog.AssetBundleName = "ui/layouts.guide"
GuideClickEffectDialog.AssetName = "GuideEmpty"
GuideClickEffectDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuideClickEffectDialog
  ((GuideClickEffectDialog.super).Ctor)(self, ...)
  self._effectHandler = nil
end

GuideClickEffectDialog.OnCreate = function(self)
  -- function num : 0_1
  self._effect = self:GetChild("Effect")
end

GuideClickEffectDialog.SetEffectId = function(self, effectId)
  -- function num : 0_2 , upvalues : _ENV
  (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(effectId))
end

GuideClickEffectDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

return GuideClickEffectDialog

