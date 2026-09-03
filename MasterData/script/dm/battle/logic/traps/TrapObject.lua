-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/traps/TrapObject.lua

TrapObject = class("TrapObject")

TrapObject:has("_config", {
	is = "r"
})
TrapObject:has("_duration", {
	is = "r"
})
TrapObject:has("_display", {
	is = "r"
})
TrapObject:has("_source", {
	is = "rw"
})
TrapObject:has("_triggerLife", {
	is = "r"
})

function TrapObject:initialize(config, traps)
	super.initialize(self)

	self._id = string.sub(tostring(self), 7)

	assert(traps ~= nil and #traps > 0, "Invalid arguments")

	self._config = config
	self._traps = traps
	self._tagset = {}

	if config then
		self._duration = config.duration
		self._display = config.display
		self._triggerLife = config.triggerLife

		local tags = config.tags

		if tags ~= nil then
			local tagset = self._tagset

			for i = 1, #tags do
				tagset[tags[i]] = 1
			end
		end
	end
end

function TrapObject:isScrapped()
	if self._triggerLife and self._triggerLife <= 0 then
		return true
	end

	local lifespan = self._lifespan

	if lifespan == nil or lifespan <= 0 then
		return true
	end

	return false
end

function TrapObject:isMatched(trapTag)
	return self._tagset ~= nil and self._tagset[trapTag]
end

function TrapObject:addTag(tag)
	if tag ~= nil then
		local counter = self._tagset[tag]

		self._tagset[tag] = (counter or 0) + 1
	end
end

function TrapObject:removeTag(tag)
	local counter = self._tagset[tag]

	self._tagset[tag] = counter > 1 and counter - 1 or nil
end

function TrapObject:putTrap(targetCell)
	if self._lifespan == nil then
		self:setupLifespan(self._duration)
	end

	self._targetCell = targetCell

	local rawCell = targetCell:getCell()
	local traps = self._traps
	local eftdetails

	for i = 1, #traps do
		local _, detail = traps[i]:putTrap(rawCell, self)

		if detail ~= nil then
			if eftdetails == nil then
				eftdetails = {}
			end

			eftdetails[#eftdetails + 1] = detail
		end
	end

	local detail

	return targetCell, (self._display ~= nil or eftdetails ~= nil or nil) and {
		trapId = self._id,
		cellId = targetCell:getId(),
		disp = self._display,
		eft = eftdetails,
		dur = self._duration
	}
end

function TrapObject:cancelTrap()
	local targetCell = self._targetCell

	if targetCell == nil then
		return nil
	end

	local rawCell = targetCell:getCell()
	local traps = self._traps
	local eftdetails

	for i = #traps, 1, -1 do
		local _, detail = traps[i]:cancelTrap(rawCell, self)

		if detail ~= nil then
			if eftdetails == nil then
				eftdetails = {}
			end

			eftdetails[#eftdetails + 1] = detail
		end
	end

	self._targetCell = nil

	local detail

	return targetCell, (self._display ~= nil or eftdetails ~= nil or nil) and {
		trapId = self._id,
		cellId = targetCell:getId(),
		disp = self._display,
		eft = eftdetails
	}
end

function TrapObject:getTargetCell()
	return self._targetCell
end

function TrapObject:trigger(target, battleContext)
	if self._triggerLife then
		self._triggerLife = self._triggerLife - 1
	end

	local traps = self._traps
	local eftdetails

	for i = 1, #traps do
		local _, detail = traps[i]:trigger(target, battleContext, self)

		if detail ~= nil then
			if eftdetails == nil then
				eftdetails = {}
			end

			eftdetails[#eftdetails + 1] = detail
		end
	end

	local detail

	return target, (self._display ~= nil or eftdetails ~= nil or nil) and {
		trapId = self._id,
		cellId = self._targetCell:getId(),
		disp = self._display,
		eft = eftdetails
	}
end

function TrapObject:updateTiming(battleContext)
	if not self:decreaseLifespan(1, battleContext) then
		if self._display then
			return {
				trapId = self._id,
				cellId = self._targetCell:getId(),
				disp = self._display,
				dur = self:getLifespan()
			}
		end

		return
	end
end

function TrapObject:setupLifespan(lifespan)
	self._lifespan = lifespan
end

function TrapObject:getLifespan()
	return self._lifespan or 0
end

function TrapObject:decreaseLifespan(delta, battleContext)
	local lifespan = self._lifespan

	if lifespan == nil or lifespan <= 0 then
		return true
	end

	lifespan = lifespan - delta

	local usedup = lifespan <= 0

	self._lifespan = usedup and 0 or lifespan

	for _, effect in ipairs(self._traps) do
		effect:tick(battleContext, self)
	end

	return usedup
end

function TrapObject:resetLifespan()
	self._lifespan = self._duration
end

function TrapObject:setEffectValue(effect, name, value)
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

function TrapObject:getEffectValue(effect, name)
	local values = self[effect]

	return values and values[name]
end
