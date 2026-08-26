-- chunkname: @modules/logic/explore/model/mo/unit/ExploreElevatorUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreElevatorUnitMO", package.seeall)

local ExploreElevatorUnitMO = pureTable("ExploreElevatorUnitMO", ExploreBaseUnitMO)

function ExploreElevatorUnitMO:initTypeData()
	local heightInfos = string.splitToNumber(self.specialDatas[1], "#")

	self.height1 = heightInfos[1]
	self.height2 = heightInfos[2]

	local intervalInfos = string.splitToNumber(self.specialDatas[2], "#")

	self.intervalTime = intervalInfos[1]
	self.keepTime = intervalInfos[2]
end

function ExploreElevatorUnitMO:getUnitClass()
	return ExploreElevatorUnit
end

function ExploreElevatorUnitMO:updateNodeHeight(height)
	for x = self.offsetSize[1], self.offsetSize[3] do
		for y = self.offsetSize[2], self.offsetSize[4] do
			local nodeKey = ExploreHelper.getKeyXY(self.nodePos.x + x, self.nodePos.y + y)

			ExploreMapModel.instance:updateNodeHeight(nodeKey, height)
		end
	end
end

return ExploreElevatorUnitMO
