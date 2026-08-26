-- chunkname: @modules/logic/explore/model/mo/unit/ExplorePipePotMO.lua

module("modules.logic.explore.model.mo.unit.ExplorePipePotMO", package.seeall)

local ExplorePipePotMO = class("ExplorePipePotMO", ExploreBaseUnitMO)

function ExplorePipePotMO:initTypeData()
	self.pipeColor = tonumber(self.specialDatas[1])
end

function ExplorePipePotMO:getBindPotId()
	local statusInfo = self:getInteractInfoMO().statusInfo

	return statusInfo.bindInteractId or 0
end

function ExplorePipePotMO:getColor()
	return self.pipeColor
end

function ExplorePipePotMO:getUnitClass()
	return ExplorePipePotUnit
end

return ExplorePipePotMO
