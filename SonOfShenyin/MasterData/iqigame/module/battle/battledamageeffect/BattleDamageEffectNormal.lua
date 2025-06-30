-- chunkname: @IQIGame\\Module\\Battle\\BattleDamageEffect\\BattleDamageEffectNormal.lua

BattleDamageEffectNormal = class(nil, BaseBattleDamageEffect)

function BattleDamageEffectNormal:SetTMPProperties(isCure, elementType)
	if self.textMeshProUGUI ~= nil then
		local colorString, materialID = self:GetSpecialEffectConfigData(isCure, elementType)

		UGUIUtil.SetHtmlColor(self.textMeshProUGUI, colorString)

		local fontMaterial = BattleResourceManager.GetBattleDamageTMPMaterial(materialID)

		if fontMaterial ~= nil then
			self.textMeshProUGUI.fontSharedMaterial = fontMaterial
		end
	end
end

function BattleDamageEffectNormal:SetShowInfo(damageNumber, elementType)
	if damageNumber < 0 then
		damageNumber = -damageNumber

		self:SetTMPProperties(true, elementType)
	else
		self:SetTMPProperties(false, elementType)
	end

	if self.EffectHelper ~= nil then
		self.DamageStr = self.EffectHelper.PrefixTags .. tostring(damageNumber)
	else
		self.DamageStr = tostring(damageNumber)
	end
end
