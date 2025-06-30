-- chunkname: @IQIGame\\Module\\Battle\\BattleDamageEffect\\BattleDamageEffectIndirect.lua

BattleDamageEffectIndirect = class(nil, BaseBattleDamageEffect)

function BattleDamageEffectIndirect:SetTMPProperties(isCure)
	if self.textMeshProUGUI ~= nil then
		UGUIUtil.SetHtmlColor(self.textMeshProUGUI, isCure and ColorCfg.BattleDamageNumber.Cure_Text or ColorCfg.BattleDamageNumber.Normal_Text)

		local fontMaterial = BattleResourceManager.GetBattleDamageTMPMaterial(isCure and Constant.BattleDamageTMPMaterialID.Cure or Constant.BattleDamageTMPMaterialID.Physical)

		if fontMaterial ~= nil then
			self.textMeshProUGUI.fontSharedMaterial = fontMaterial
		end
	end
end

function BattleDamageEffectIndirect:SetShowInfo(damageNumber, userData)
	if damageNumber < 0 then
		damageNumber = -damageNumber

		self:SetTMPProperties(true)
	else
		self:SetTMPProperties(false)
	end

	if self.EffectHelper ~= nil then
		self.DamageStr = self.EffectHelper.PrefixTags .. tostring(damageNumber)
	else
		self.DamageStr = tostring(damageNumber)
	end
end
