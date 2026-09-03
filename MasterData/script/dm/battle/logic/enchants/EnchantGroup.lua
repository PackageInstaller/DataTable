-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/enchants/EnchantGroup.lua

EnchantGroup = class("EnchantGroup", EnchantObject)

EnchantGroup:has("_groupId", {
	is = "rw"
})
EnchantGroup:has("_stackingCounts", {
	is = "rw"
})

function EnchantGroup:initialize(enchantObject)
	local enchants = enchantObject:cloneEnchants()

	assert(enchants ~= nil and #enchants > 0, "Invalid arguments")

	self._enchants = enchants
	self._tagset = {}
	self._duration = enchantObject:getDuration()
	self._timing = enchantObject:getTiming()
	self._display = enchantObject:getDisplay()

	local tags = enchantObject:getConfig().tags

	if tags ~= nil then
		local tagset = self._tagset

		for i = 1, #tags do
			tagset[tags[i]] = 1
		end
	end

	self._event = enchantObject:getEvent()
	self._stackingCounts = 1
	self._stackedObjects = {
		enchantObject
	}
end

function EnchantGroup:isGroup()
	return true
end

function EnchantGroup:clone()
	assert(false, "EnchantGroup can't clone")
end

function EnchantGroup:stack(enchantObject, groupLimit)
	if self:_findEnchantObject(enchantObject) then
		return false, "exists"
	end

	if groupLimit and groupLimit <= self._stackingCounts then
		for i = 1, self._stackingCounts - groupLimit + 1 do
			self:remove(self._stackedObjects[1], 1)
		end
	end

	self._stackingCounts = self._stackingCounts + 1
	self._stackedObjects[self._stackingCounts] = enchantObject

	local rawCard = self._targetCard:getCard()
	local eftdetails

	for index, enchant in ipairs(self._enchants) do
		local enchantToStack = enchantObject:getEnchant(index)
		local _, detail = enchant:stack(enchantToStack, rawCard, self)

		if detail ~= nil then
			if eftdetails == nil then
				eftdetails = {}
			end

			eftdetails[#eftdetails + 1] = detail
		end
	end

	return true, {
		enchantId = self._groupId,
		cardId = self._targetCard:getId(),
		times = self._stackingCounts,
		disp = self._display,
		dur = self:getLifespan(),
		eft = eftdetails
	}
end

function EnchantGroup:_findEnchantObject(enchantObject)
	if self._stackedObjects then
		for index, bObject in ipairs(self._stackedObjects) do
			if bObject == enchantObject then
				return index
			end
		end

		return nil
	end
end

function EnchantGroup:remove(enchantObject, index)
	local index = index or self:_findEnchantObject(enchantObject)

	if index then
		local rawCard = self._targetCard:getCard()

		self._stackingCounts = self._stackingCounts - 1

		table.remove(self._stackedObjects, index)

		local eftdetails

		for i, enchant in ipairs(self._enchants) do
			local enchantToRemove = enchantObject:getEnchant(i)
			local _, detail = enchant:remove(enchantToRemove, rawCard, self)

			if detail ~= nil then
				if eftdetails == nil then
					eftdetails = {}
				end

				eftdetails[#eftdetails + 1] = detail
			end
		end

		return true, {
			enchantId = self._groupId,
			cardId = self._targetCard:getId(),
			times = self._stackingCounts,
			disp = self._display,
			dur = self:getLifespan(),
			eft = eftdetails
		}
	end
end
