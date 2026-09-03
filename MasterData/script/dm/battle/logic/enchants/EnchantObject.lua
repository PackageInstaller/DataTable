-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/enchants/EnchantObject.lua

EnchantObject = class("EnchantObject")

EnchantObject:has("_config", {
	is = "r"
})
EnchantObject:has("_duration", {
	is = "r"
})
EnchantObject:has("_display", {
	is = "r"
})
EnchantObject:has("_timing", {
	is = "r"
})
EnchantObject:has("_event", {
	is = "r"
})
EnchantObject:has("_listener", {
	is = "rw"
})
EnchantObject:has("_source", {
	is = "rw"
})

function EnchantObject:initialize(config, enchants)
	super.initialize(self)

	self._id = string.sub(tostring(self), 7)

	assert(enchants ~= nil and #enchants > 0, "Invalid arguments")

	self._config = config
	self._enchants = enchants
	self._tagset = {}

	if config then
		self._duration = config.duration
		self._timing = config.timing
		self._display = config.display

		if self._timing and self._timing ~= 0 then
			self._event = EVT_BATTLE_CARD_USED
		end

		local tags = config.tags

		if tags ~= nil then
			local tagset = self._tagset

			for i = 1, #tags do
				tagset[tags[i]] = 1
			end
		end
	end
end

function EnchantObject:cloneEnchants()
	return self._enchants
end

function EnchantObject:getEnchant(index)
	return self._enchants and self._enchants[index]
end

function EnchantObject:isMatched(enchantTag)
	return self._tagset ~= nil and self._tagset[enchantTag]
end

function EnchantObject:addTag(tag)
	if tag ~= nil then
		local counter = self._tagset[tag]

		self._tagset[tag] = (counter or 0) + 1
	end
end

function EnchantObject:removeTag(tag)
	local counter = self._tagset[tag]

	self._tagset[tag] = counter > 1 and counter - 1 or nil
end

function EnchantObject:takeEnchant(targetCard)
	if self._lifespan == nil then
		self:setupLifespan(self._duration)
	end

	self._targetCard = targetCard

	local rawCard = targetCard:getCard()
	local enchants = self._enchants
	local eftdetails

	for i = 1, #enchants do
		local _, detail = enchants[i]:takeEnchant(rawCard, self)

		if detail ~= nil then
			if eftdetails == nil then
				eftdetails = {}
			end

			eftdetails[#eftdetails + 1] = detail
		end
	end

	local detail

	return targetCard, (self._display ~= nil or eftdetails ~= nil or nil) and {
		enchantId = self._id,
		cardId = targetCard:getId(),
		disp = self._display,
		eft = eftdetails,
		dur = self._duration
	}
end

function EnchantObject:cancelEnchant()
	local targetCard = self._targetCard

	if targetCard == nil then
		return nil
	end

	local rawCard = targetCard:getCard()
	local enchants = self._enchants
	local eftdetails

	for i = #enchants, 1, -1 do
		local _, detail = enchants[i]:cancelEnchant(rawCard, self)

		if detail ~= nil then
			if eftdetails == nil then
				eftdetails = {}
			end

			eftdetails[#eftdetails + 1] = detail
		end
	end

	self._targetCard = nil

	local detail

	return targetCard, (self._display ~= nil or eftdetails ~= nil or nil) and {
		enchantId = self._id,
		cardId = targetCard:getId(),
		disp = self._display,
		eft = eftdetails
	}
end

function EnchantObject:getTargetCard()
	return self._targetCard
end

function EnchantObject:updateTiming(battleContext)
	if not self:decreaseLifespan(1, battleContext) then
		if self._display then
			return {
				enchantId = self._id,
				cardId = self._targetCard:getId(),
				disp = self._display,
				dur = self:getLifespan()
			}
		end

		return
	end
end

function EnchantObject:isUsedUp()
	if self:getLifespan() <= 0 then
		return true
	end
end

function EnchantObject:setupLifespan(lifespan)
	self._lifespan = lifespan
end

function EnchantObject:getLifespan()
	return self._lifespan or 0
end

function EnchantObject:decreaseLifespan(delta, battleContext)
	local lifespan = self._lifespan

	if lifespan == nil or lifespan <= 0 then
		return true
	end

	lifespan = lifespan - delta

	local usedup = lifespan <= 0

	self._lifespan = usedup and 0 or lifespan

	for _, effect in ipairs(self._enchants) do
		effect:tick(battleContext, self)
	end

	return usedup
end

function EnchantObject:resetLifespan()
	self._lifespan = self._duration
end

function EnchantObject:setEffectValue(effect, name, value)
	local values = self[effect]

	if values == nil then
		if value == nil then
			return
		end

		self[effect] = {
			[name] = value
		}
	else
		values[name] = value
	end
end

function EnchantObject:getEffectValue(effect, name)
	local values = self[effect]

	return values and values[name]
end

function EnchantObject:isGroup()
	return false
end
