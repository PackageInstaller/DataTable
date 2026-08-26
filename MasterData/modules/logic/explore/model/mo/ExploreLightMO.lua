-- chunkname: @modules/logic/explore/model/mo/ExploreLightMO.lua

module("modules.logic.explore.model.mo.ExploreLightMO", package.seeall)

local ExploreLightMO = pureTable("ExploreLightMO")

function ExploreLightMO:ctor()
	self.curEmitUnit = nil
	self.dir = nil
	self.endEmitUnit = nil
	self.crossNodes = {}
	self.lightLen = nil
end

function ExploreLightMO:init(curUnit, dir)
	self.curEmitUnit = curUnit
	self.dir = ExploreHelper.getDir(dir)

	self:updateData()
end

local dirs = {
	[0] = {
		x = 0,
		y = 1
	},
	[45] = {
		x = 1,
		y = 1
	},
	[90] = {
		x = 1,
		y = 0
	},
	[135] = {
		x = 1,
		y = -1
	},
	[180] = {
		x = 0,
		y = -1
	},
	[225] = {
		x = -1,
		y = -1
	},
	[270] = {
		x = -1,
		y = 0
	},
	[315] = {
		x = -1,
		y = 1
	}
}
local tempPos = {
	x = 0,
	y = 0
}
local sqrt2 = math.sqrt(2)

function ExploreLightMO:updateData()
	self.crossNodes = {}

	local map = ExploreController.instance:getMap()
	local mapLight = ExploreController.instance:getMapLight()
	local firstNode = self.curEmitUnit.nodePos

	tempPos.x, tempPos.y = firstNode.x, firstNode.y

	local endEmitUnit
	local len = 0
	local dir = dirs[self.dir]

	while true do
		local key = ExploreHelper.getKey(tempPos)

		if not map:haveNodeXY(key) then
			break
		end

		self.crossNodes[key] = true
		tempPos.x = tempPos.x + dir.x
		tempPos.y = tempPos.y + dir.y
		len = len + 1

		local units = map:getUnitByPos(tempPos)
		local isBarricade = false

		for _, unit in pairs(units) do
			if not unit:isPassLight() then
				isBarricade = true
				endEmitUnit = unit

				break
			end
		end

		if isBarricade then
			break
		end
	end

	if not endEmitUnit then
		len = len - 0.5
	end

	if (self.dir + 360) % 90 == 45 then
		len = len * sqrt2
	end

	if endEmitUnit and isTypeOf(endEmitUnit, ExploreBaseMoveUnit) and endEmitUnit:isMoving() then
		len = Vector3.Distance(self.curEmitUnit:getPos(), endEmitUnit:getPos())
	end

	self.lightLen = len

	if endEmitUnit ~= self.endEmitUnit then
		local preEndEmitUnit = self.endEmitUnit

		self.endEmitUnit = endEmitUnit

		if preEndEmitUnit then
			mapLight:removeUnitLight(preEndEmitUnit, self)
		end

		if endEmitUnit then
			local lightDirs = endEmitUnit:getLightRecvDirs()

			if not lightDirs or lightDirs[ExploreHelper.getDir(self.dir - 180)] then
				if not mapLight:haveLight(endEmitUnit, self) then
					endEmitUnit:onLightEnter(self)
				end

				endEmitUnit:onLightChange(self, true)
			end
		end
	end

	self.curEmitUnit:onLightDataChange(self)
end

function ExploreLightMO:isInLight(pos)
	local key = ExploreHelper.getKey(pos)
	local nodes = self:getCrossNode()

	return nodes[key] or false
end

function ExploreLightMO:getCrossNode()
	return self.crossNodes
end

return ExploreLightMO
