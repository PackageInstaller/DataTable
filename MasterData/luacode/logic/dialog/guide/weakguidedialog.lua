local WeakGuideDialog = class("WeakGuideDialog", Dialog)
WeakGuideDialog.AssetBundleName = "ui/layouts.guide"
WeakGuideDialog.AssetName = "GuideEmpty"

function WeakGuideDialog:Ctor(...)
  WeakGuideDialog.super.Ctor(self, ...)
  self._effectHandler = nil
end

function WeakGuideDialog:OnCreate()
  self._effect = self:GetChild("Effect")
  self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1058))
end

function WeakGuideDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function WeakGuideDialog:SetEffectPos(pos)
  self._effect:SetAnchoredPosition(pos.posX, pos.posY)
end

return WeakGuideDialog
