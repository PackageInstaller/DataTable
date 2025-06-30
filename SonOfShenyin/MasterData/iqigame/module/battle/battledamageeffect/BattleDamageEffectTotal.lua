-- chunkname: @IQIGame\\Module\\Battle\\BattleDamageEffect\\BattleDamageEffectTotal.lua

BattleDamageEffectTotal = class(nil, BaseBattleDamageEffect)

function BattleDamageEffectTotal:SetTMPProperties()
	if self.textMeshProUGUI ~= nil then
		UGUIUtil.SetHtmlColor(self.textMeshProUGUI, ColorCfg.BattleDamageNumber.Normal_Text)

		local fontMaterial = BattleResourceManager.GetBattleDamageTMPMaterial(Constant.BattleDamageTMPMaterialID.Physical)

		if fontMaterial ~= nil then
			self.textMeshProUGUI.fontSharedMaterial = fontMaterial
		end
	end
end

function BattleDamageEffectTotal:SetShowInfo(damageNumber, userData)
	if damageNumber < 0 then
		damageNumber = -damageNumber
	end

	self:SetFinalDamageStr(damageNumber)
end

function BattleDamageEffectTotal:SetFinalDamageStr(damageNumber)
	local numStr = tostring(damageNumber)
	local finalInfoTb = {}

	table.insert(finalInfoTb, self.EffectHelper.PrefixTags)

	local richStr

	for i = 1, #numStr do
		richStr = string.sub(numStr, i, i)

		if i == 1 then
			richStr = self:AddRotEffectTagToNum(richStr)
		end

		richStr = self:AddOffsetEffectTagToNum(i % 2 ~= 0, richStr)

		table.insert(finalInfoTb, richStr)
	end

	self.DamageStr = table.concat(finalInfoTb)
end

function BattleDamageEffectTotal:AddOffsetEffectTagToNum(isOdd, num)
	local tb = {}

	if isOdd then
		table.insert(tb, "{offset a=-1}")
	else
		table.insert(tb, "{offset a=1}")
	end

	table.insert(tb, num)
	table.insert(tb, "{/offset}")

	return table.concat(tb)
end

function BattleDamageEffectTotal:AddRotEffectTagToNum(num)
	local tb = {}

	table.insert(tb, "{rot}")
	table.insert(tb, num)
	table.insert(tb, "{/rot}")

	return table.concat(tb)
end
