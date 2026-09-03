-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/BuffGroup.lua

BuffGroup = class("BuffGroup", BuffObject)

BuffGroup:has("_groupId", {
	is = "rw"
})
BuffGroup:has("_stackingCounts", {
	is = "rw"
})

local function deepCopy(desc, src)
	local d = desc or {}

	for k, v in pairs(src) do
		d[k] = type(v) == "table" and deepCopy({}, v) or v
	end

	return d
end

function BuffGroup:initialize(buffObject)
	local effects = buffObject:cloneEffects()

	assert(effects ~= nil and #effects > 0, "Invalid arguments")

	self._effects = effects
	self._tagset = {}
	self._duration = buffObject:getDuration()
	self._timing = buffObject:getTiming()
	self._display = buffObject:getDisplay()

	local tags = buffObject:getConfig().tags

	if tags ~= nil then
		local tagset = self._tagset

		for i = 1, #tags do
			tagset[tags[i]] = 1
		end
	end

	self._stackingCounts = 1
	self._stackedObjects = {
		buffObject
	}
	self._stackedTimers = {
		self._duration
	}
end

function BuffGroup:isGroup()
	return true
end

function BuffGroup:clone()
	local cloneInstance = {}

	for k, v in pairs(self._stackedObjects) do
		local config = {}

		deepCopy(config, v:getConfig())

		config.duration = self._lifespans[k]
		config.timing = self._timing
		cloneInstance[#cloneInstance + 1] = BuffObject:new(config, v:cloneEffects())
	end

	return cloneInstance
end

function BuffGroup:stack(buffObject, groupLimit)
	if self:_findBuffObject(buffObject) then
		return false, "exists"
	end

	if groupLimit and groupLimit <= self._stackingCounts then
		for i = 1, self._stackingCounts - groupLimit + 1 do
			self:remove(self._stackedObjects[1], 1)
		end
	end

	self._stackingCounts = self._stackingCounts + 1
	self._stackedObjects[self._stackingCounts] = buffObject

	local buffDuration = buffObject:getDuration()

	self:setupDuration(buffDuration)
	self:setupLifespan(buffDuration)

	local eftdetails

	for index, effect in ipairs(self._effects) do
		local effectToStack = buffObject:getEffect(index)
		local _, detail = effect:stack(effectToStack, self)

		if detail ~= nil then
			if eftdetails == nil then
				eftdetails = {}
			end

			eftdetails[#eftdetails + 1] = detail
		end
	end

	return true, {
		buffId = self._groupId,
		times = self._stackingCounts,
		disp = self._display,
		dur = self:getLifespan(),
		eft = eftdetails
	}
end

function BuffGroup:_findBuffObject(buffObject)
	if self._stackedObjects then
		for index, bObject in ipairs(self._stackedObjects) do
			if bObject == buffObject then
				return index
			end
		end

		return nil
	end
end

function BuffGroup:remove(buffObject, index)
	local index = index or self:_findBuffObject(buffObject)

	if index then
		self._stackingCounts = self._stackingCounts - 1

		table.remove(self._stackedObjects, index)
		table.remove(self._stackedTimers, index)
		table.remove(self._lifespans, index)

		local eftdetails

		for i, effect in ipairs(self._effects) do
			local effectToRemove = buffObject:getEffect(i)
			local _, detail = effect:remove(effectToRemove, self)

			if detail ~= nil then
				if eftdetails == nil then
					eftdetails = {}
				end

				eftdetails[#eftdetails + 1] = detail
			end
		end

		return true, {
			buffId = self._groupId,
			times = self._stackingCounts,
			disp = self._display,
			dur = self:getLifespan(),
			eft = eftdetails
		}
	end
end

function BuffGroup:setupDuration(duration)
	self._stackedTimers[#self._stackedTimers + 1] = duration
end

function BuffGroup:setupLifespan(lifespan)
	self._lifespan = lifespan
	self._lifespans = self._lifespans or {}
	self._lifespans[#self._lifespans + 1] = lifespan
end

function BuffGroup:getLifespan()
	local max = 0

	if self._lifespans then
		for _, lifespan in ipairs(self._lifespans) do
			max = lifespan < max and max or lifespan
		end
	end

	return max
end

function BuffGroup:decreaseLifespan(delta, battleContext)
	if self._lifespans == nil or #self._lifespans == 0 then
		return true
	end

	local max = -delta

	for i, lifespan in ipairs(self._lifespans) do
		lifespan = lifespan - delta
		self._lifespans[i] = lifespan
		max = lifespan < max and max or lifespan
	end

	if max <= -delta then
		return true
	end

	local usedup = max <= 0

	for _, effect in ipairs(self._effects) do
		effect:tick(battleContext, self)
	end

	return usedup
end

function BuffGroup:resetLifespan()
	for index, duration in ipairs(self._stackedTimers) do
		self._lifespans[index] = duration
	end
end
