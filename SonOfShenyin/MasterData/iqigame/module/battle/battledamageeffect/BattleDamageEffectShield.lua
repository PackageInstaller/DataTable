-- chunkname: @IQIGame\\Module\\Battle\\BattleDamageEffect\\BattleDamageEffectShield.lua

BattleDamageEffectShield = class(nil, BaseBattleDamageEffect)

function BattleDamageEffectShield:SetTMPProperties()
	if self.textMeshProUGUI ~= nil then
		UGUIUtil.SetHtmlColor(self.textMeshProUGUI, ColorCfg.BattleDamageNumber.Shield_Reduce_Text)

		local fontMaterial = BattleResourceManager.GetBattleDamageTMPMaterial(Constant.BattleDamageTMPMaterialID.ShieldReduce)

		if fontMaterial ~= nil then
			self.textMeshProUGUI.fontSharedMaterial = fontMaterial
		end
	end
end

function BattleDamageEffectShield:SetShowInfo(damageNumber, userData)
	if damageNumber < 0 then
		-- block empty
	else
		damageNumber = -damageNumber
	end

	self:SetTMPProperties()

	if self.EffectHelper ~= nil then
		self.DamageStr = self.EffectHelper.PrefixTags .. tostring(damageNumber)
	else
		self.DamageStr = tostring(damageNumber)
	end
end
