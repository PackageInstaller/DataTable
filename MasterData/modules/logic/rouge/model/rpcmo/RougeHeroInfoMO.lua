-- chunkname: @modules/logic/rouge/model/rpcmo/RougeHeroInfoMO.lua

module("modules.logic.rouge.model.rpcmo.RougeHeroInfoMO", package.seeall)

local RougeHeroInfoMO = pureTable("RougeHeroInfoMO")

function RougeHeroInfoMO:init(info)
	self:update(info)
end

function RougeHeroInfoMO:update(info)
	self.heroId = info.heroId
	self.stressValue = info.stressValue
	self.stressValueLimit = info.stressValueLimit
end

function RougeHeroInfoMO:getStressValue()
	return self.stressValue or 0
end

function RougeHeroInfoMO:getStressRange()
	local stressLimitValue = self:getStressValueLimit()

	return 0, stressLimitValue
end

function RougeHeroInfoMO:getStressValueLimit()
	return self.stressValueLimit or 0
end

return RougeHeroInfoMO
