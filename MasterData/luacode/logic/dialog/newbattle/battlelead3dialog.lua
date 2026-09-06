local BattleLead3Dialog = class("BattleLead3Dialog", Dialog)
BattleLead3Dialog.AssetBundleName = "ui/layouts.battlenew"
BattleLead3Dialog.AssetName = "BattleNewTutorial3"

function BattleLead3Dialog:Ctor(...)
  BattleLead3Dialog.super.Ctor(self, ...)
  self._groupName = "Default"
end

function BattleLead3Dialog:OnCreate()
  self._powerEffect = self:GetChild("Effect1")
  self._skillEffect = self:GetChild("Effect2")
  self._handlePower = self._powerEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1036))
  self._handleSkill = self._skillEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1037))
  self._powerEffect:Subscribe_UIEffectEndEvent(function()
    self:Destroy()
  end)
end

function BattleLead3Dialog:OnDestroy()
  self._battleword:AddFirstBattleIndex(1)
  if self._handleSkill then
    self._skillEffect:ReleaseEffect(self._handleSkill)
    self._handleSkill = nil
  end
  if self._handlePower then
    self._skillEffect:ReleaseEffect(self._handlePower)
    self._handlePower = nil
  end
end

function BattleLead3Dialog:SetData(world)
  self._battleword = world
end

return BattleLead3Dialog
