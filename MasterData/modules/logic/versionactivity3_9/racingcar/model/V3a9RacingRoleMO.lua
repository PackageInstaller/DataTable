-- chunkname: @modules/logic/versionactivity3_9/racingcar/model/V3a9RacingRoleMO.lua

module("modules.logic.versionactivity3_9.racingcar.model.V3a9RacingRoleMO", package.seeall)

local V3a9RacingRoleMO = pureTable("V3a9RacingRoleMO")

function V3a9RacingRoleMO:init(co)
	self.config = co
	self._co = co
	self._id = co.id
	self._isUnlock = co.cost == 0
end

function V3a9RacingRoleMO:getId()
	return self._id
end

function V3a9RacingRoleMO:getConfig()
	return self._co
end

function V3a9RacingRoleMO:isUnlock()
	return self._isUnlock
end

function V3a9RacingRoleMO:setUnlock(isUnlock)
	self._isUnlock = isUnlock
end

function V3a9RacingRoleMO:getPowerSpeed()
	return self._co.powerSpeed or 0
end

return V3a9RacingRoleMO
