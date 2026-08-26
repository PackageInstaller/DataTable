-- chunkname: @modules/logic/explore/model/mo/unit/ExplorePipeEntranceMO.lua

module("modules.logic.explore.model.mo.unit.ExplorePipeEntranceMO", package.seeall)

local ExplorePipeEntranceMO = class("ExplorePipeEntranceMO", ExplorePipeBaseMO)

function ExplorePipeEntranceMO:initTypeData()
	return
end

function ExplorePipeEntranceMO:getBindPotId()
	local statusInfo = self:getInteractInfoMO().statusInfo

	return statusInfo.bindInteractId or 0
end

function ExplorePipeEntranceMO:getPipeOutDir()
	return self.unitDir
end

function ExplorePipeEntranceMO:isOutDir(dir)
	return ExploreHelper.getDir(dir - self.unitDir) == 0
end

function ExplorePipeEntranceMO:getDirType(dir)
	if dir == 0 then
		return ExploreEnum.PipeGoNode.Pipe1
	end
end

function ExplorePipeEntranceMO:getColor()
	local bindPotId = self:getBindPotId()
	local pot = ExploreController.instance:getMap():getUnit(bindPotId, true)

	if pot then
		return pot.mo:getColor()
	end

	return ExploreEnum.PipeColor.None
end

function ExplorePipeEntranceMO:getUnitClass()
	return ExplorePipeEntranceUnit
end

return ExplorePipeEntranceMO
