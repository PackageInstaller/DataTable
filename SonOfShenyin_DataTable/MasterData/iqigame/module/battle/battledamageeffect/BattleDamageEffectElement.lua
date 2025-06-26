-- chunkname: @IQIGame\\Module\\Battle\\BattleDamageEffect\\BattleDamageEffectElement.lua

BattleDamageEffectElement = class(nil, BaseBattleDamageEffect)

function BattleDamageEffectElement:SetTMPProperties(isCure, elementType)
	if self.textMeshProUGUI ~= nil then
		self.elementType = elementType

		local colorString, materialID = self:GetSpecialEffectConfigData(isCure, elementType)

		UGUIUtil.SetHtmlColor(self.textMeshProUGUI, colorString)

		local fontMaterial = BattleResourceManager.GetBattleDamageTMPMaterial(materialID)

		if fontMaterial ~= nil then
			self.textMeshProUGUI.fontSharedMaterial = fontMaterial
		end
	end
end

function BattleDamageEffectElement:SetShowInfo(damageNumber, elementType)
	if elementType == nil or type(elementType) ~= "number" or elementType < 1 or elementType > 5 then
		self.DamageStr = ""

		logError("战斗伤害数字组件 - SetShowInfo：元素反应类型传入参数 elementType={0} 非法", elementType)

		return
	end

	self:SetTMPProperties(damageNumber < 0, elementType)

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

function BattleDamageEffectElement:AddOffsetEffectTagToNum(isOdd, num)
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

function BattleDamageEffectElement:AddRotEffectTagToNum(num)
	local tb = {}

	table.insert(tb, "{rot}")
	table.insert(tb, num)
	table.insert(tb, "{/rot}")

	return table.concat(tb)
end
