-- chunkname: @IQIGame\\Module\\Battle\\BattleDamageEffect\\BattleDamageEffectDot.lua

BattleDamageEffectDot = class(nil, BaseBattleDamageEffect)

function BattleDamageEffectDot:SetTMPProperties(isCure)
	if self.textMeshProUGUI ~= nil then
		UGUIUtil.SetHtmlColor(self.textMeshProUGUI, isCure and ColorCfg.BattleDamageNumber.Cure_Text or ColorCfg.BattleDamageNumber.Dot_Text)

		local fontMaterial = BattleResourceManager.GetBattleDamageTMPMaterial(isCure and ColorCfg.BattleDamageNumber.Cure_Text or Constant.BattleDamageTMPMaterialID.DOT)

		if fontMaterial ~= nil then
			self.textMeshProUGUI.fontSharedMaterial = fontMaterial
		end
	end
end

function BattleDamageEffectDot:SetShowInfo(damageNumber, userData)
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
