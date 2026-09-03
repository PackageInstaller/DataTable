-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/components/FlagComponent.lua

kBEDazed = "DAZED"
kBEMuted = "MUTED"
kBENumbed = "NUMBED"
kBEFrozen = "FROZEN"
kBETaunt = "TAUNT"
kBEMad = "MAD"
kBEShield = "SHIELD"
kBEImmune = "IMMUNE"
kBELinked = "LINKED"
kBEProvoked = "PROVOKED"
kBEStealth = "STEALTH"
kBEDiligent = "DILIGENT"
kBECurse = "CURSE"
kBEOffline = "OFFLINE"
FlagComponent = class("FlagComponent", BaseComponent, _M)

function FlagComponent:initialize()
	super.initialize(self)

	self._flags = {}
	self._statuses = {}
end

function FlagComponent:initWithRawData(data)
	super.initWithRawData(self, data)
	self:setFlags(data.flags)
end

function FlagComponent:setEntity(entity)
	super.setEntity(self, entity)

	self._userFlagCheckers = entity ~= nil and entity.getFlagCheckers ~= nil and entity:getFlagCheckers() or nil
end

function FlagComponent:addStatus(status)
	local counter = (self._statuses[status] or 0) + 1

	self._statuses[status] = counter

	return counter
end

function FlagComponent:removeStatus(status)
	local counter = self._statuses[status]

	if counter and counter > 0 then
		counter = counter - 1

		if counter <= 0 then
			self._statuses[status] = nil
		else
			self._statuses[status] = counter
		end
	end

	return counter
end

function FlagComponent:hasStatus(status)
	return not not self._statuses[status]
end

function FlagComponent:hasAnyStatus(statusArray)
	if statusArray then
		local statuses = self._statuses

		for i = 1, #statusArray do
			local s = statusArray[i]

			if statuses[s] then
				return s
			end
		end
	end

	return nil
end

function FlagComponent:setFlags(flags)
	if flags == nil then
		return
	end

	for i = 1, #flags do
		self._flags[flags[i]] = true
	end
end

function FlagComponent:getFlags()
	if self._flags == nil then
		return nil
	end

	local flags, i = {}, 1

	for flag, _ in pairs(self._flags) do
		i = i + 1
		flags[i] = flag
	end

	return flags
end

function FlagComponent:clearFlags(flags)
	if flags == nil then
		if next(self._flags) ~= nil then
			self._flags = {}
		end
	else
		for i = 1, #flags do
			self._flags[flags[i]] = nil
		end
	end
end

function FlagComponent:hasFlag(flag)
	return self._flags[flag]
end

function FlagComponent:hasGeneralFlag(flag)
	if self._flags[flag] or self._statuses and self._statuses[flag] then
		return true
	end

	if flag ~= nil and flag:sub(1, 1) == "$" and self._userFlagCheckers ~= nil then
		local flagChecker = self._userFlagCheckers[flag]

		if flagChecker ~= nil then
			return flagChecker(self._entity)
		end
	end

	return false
end

function FlagComponent:copyComponent(srcComp, ratio)
	self:setFlags(srcComp:getFlags())
end
