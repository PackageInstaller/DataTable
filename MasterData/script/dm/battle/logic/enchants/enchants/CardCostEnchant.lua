-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/enchants/enchants/CardCostEnchant.lua

CardCostEnchant = class("CardCostEnchant", EnchantEffect, _M)

CardCostEnchant:has("_effectType", {
	is = "r"
})

function CardCostEnchant:initialize(config)
	super.initialize(self, config)

	self._effectType = config.type
	self._priority = config.priority
end

function CardCostEnchant:takeEnchant(card)
	return true, card:applyCostEnchant(self, self._effectType, self._enchantValue, self._priority > 1)
end

function CardCostEnchant:cancelEnchant(card)
	return true, card:cancelCostEnchant(self, self._priority > 1)
end

function CardCostEnchant:stack(ehchant, card, enchantObject)
	super.stack(self, ehchant, card, enchantObject)
	card:cancelCostEnchant(self, self._priority > 1)

	local enchantValue = enchantObject:getEffectValue(self, "enchantValue") or self._enchantValue

	return true, card:applyCostEnchant(self, self._effectType, enchantValue, self._priority > 1)
end

function CardCostEnchant:remove(ehchant, card, enchantObject)
	super.remove(self, ehchant, card, enchantObject)
	card:cancelCostEnchant(self, self._priority > 1)

	local enchantValue = enchantObject:getEffectValue(self, "enchantValue") or self._enchantValue

	return true, card:applyCostEnchant(self, self._effectType, enchantValue, self._priority > 1)
end
