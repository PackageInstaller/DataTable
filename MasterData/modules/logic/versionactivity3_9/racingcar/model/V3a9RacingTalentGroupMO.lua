-- chunkname: @modules/logic/versionactivity3_9/racingcar/model/V3a9RacingTalentGroupMO.lua

module("modules.logic.versionactivity3_9.racingcar.model.V3a9RacingTalentGroupMO", package.seeall)

local V3a9RacingTalentGroupMO = pureTable("V3a9RacingTalentGroupMO")

function V3a9RacingTalentGroupMO:init(group)
	self._group = group
	self._talentMos = {}
	self._co = lua_racing_gift_group.configDict[group]
	self._unlockOrder = 0
end

function V3a9RacingTalentGroupMO:addTalentMo(mo)
	self._talentMos[mo:getOrder()] = mo
end

function V3a9RacingTalentGroupMO:checkCanUnlockTalent(order)
	self._unlockOrder = 0

	for _, mo in ipairs(self._talentMos) do
		mo:setCanUnlock(order + 1 == mo:getOrder())

		if not mo:isLock() or mo:isWaitActive() then
			self._unlockOrder = mo:getOrder()
		end
	end
end

function V3a9RacingTalentGroupMO:getGroup()
	return self._group
end

function V3a9RacingTalentGroupMO:getConfig()
	return self._co
end

function V3a9RacingTalentGroupMO:getTalentMos()
	return self._talentMos
end

function V3a9RacingTalentGroupMO:getUnlockOrder()
	return self._unlockOrder
end

return V3a9RacingTalentGroupMO
