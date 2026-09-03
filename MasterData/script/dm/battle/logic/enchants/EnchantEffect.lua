-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/enchants/EnchantEffect.lua

EnchantEffect = class("EnchantEffect", objectlua.Object, _M)

EnchantEffect:has("_config", {
	is = "r"
})
EnchantEffect:has("_enchantValue", {
	is = "r"
})

function EnchantEffect:initialize(config)
	super.initialize(self)

	self._config = config
	self._enchantValue = config.value
end

function EnchantEffect:takeEnchant(card, enchantObject)
	enchantObject:setEffectValue(self, "targetCard", card)

	return true, nil
end

function EnchantEffect:cancelEnchant(card, enchantObject)
	enchantObject:setEffectValue(self, "targetCard", nil)

	return true, nil
end

function EnchantEffect:tick(battleContext, enchantObject)
	return
end

function EnchantEffect:stack(enchant, card, enchantObject)
	local stackingCounts = enchantObject:getEffectValue(self, "stackingCounts") or 1

	stackingCounts = stackingCounts + 1

	enchantObject:setEffectValue(self, "stackingCounts", stackingCounts)

	local enchantValue = enchantObject:getEffectValue(self, "enchantValue") or self._enchantValue

	if enchantValue then
		enchantValue = enchantValue + enchant:getEnchantValue()

		enchantObject:setEffectValue(self, "enchantValue", enchantValue)
	end

	return true, {
		times = stackingCounts
	}
end

function EnchantEffect:remove(enchant, card, enchantObject)
	local stackingCounts = enchantObject:getEffectValue(self, "stackingCounts") or 1

	stackingCounts = stackingCounts - 1

	enchantObject:setEffectValue(self, "stackingCounts", stackingCounts)

	local enchantValue = enchantObject:getEffectValue(self, "enchantValue") or self._enchantValue

	if enchantValue then
		enchantValue = enchantValue - enchant:getEnchantValue()

		enchantObject:setEffectValue(self, "enchantValue", enchantValue)
	end

	return true, {
		times = stackingCounts
	}
end
