-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiSeatMO.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiSeatMO", package.seeall)

local V3a6YaMiSeatMO = class("V3a6YaMiSeatMO")

function V3a6YaMiSeatMO:init(index)
	self.index = index
	self.co = V3a6YaMiConfig.instance:getSeatCo(index)
end

function V3a6YaMiSeatMO:refreshUnlock(isUnlock)
	self._isUnlock = isUnlock
end

function V3a6YaMiSeatMO:isUnlock()
	if self.co.preId == 0 and self.co.cost == 0 then
		return true
	end

	return self._isUnlock
end

function V3a6YaMiSeatMO:setHeroId(heroId)
	self.heroId = heroId
end

return V3a6YaMiSeatMO
