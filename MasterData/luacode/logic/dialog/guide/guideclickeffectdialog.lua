local GuideClickEffectDialog = class("GuideClickEffectDialog", Dialog)
GuideClickEffectDialog.AssetBundleName = "ui/layouts.guide"
GuideClickEffectDialog.AssetName = "GuideEmpty"

function GuideClickEffectDialog:Ctor(...)
  GuideClickEffectDialog.super.Ctor(self, ...)
  self._effectHandler = nil
end

function GuideClickEffectDialog:OnCreate()
  self._effect = self:GetChild("Effect")
end

function GuideClickEffectDialog:SetEffectId(effectId)
  self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(effectId))
end

function GuideClickEffectDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

return GuideClickEffectDialog
