-- chunkname: @modules/logic/survival/model/map/SurvivalBlockCo.lua

module("modules.logic.survival.model.map.SurvivalBlockCo", package.seeall)

local SurvivalBlockCo = pureTable("SurvivalBlockCo")

function SurvivalBlockCo:init(data, allPaths)
	self.pos = SurvivalHexNode.New(data[1], data[2])
	self.walkable = data[3]
	self.dir = data[4]
	self.assetPath = allPaths[data[5]]
	self.exNodes = {}

	for _, data1 in ipairs(data[6]) do
		table.insert(self.exNodes, SurvivalHexNode.New(data1[1] + self.pos.q, data1[2] + self.pos.r))
	end
end

function SurvivalBlockCo:getRange(minX, maxX, minY, maxY)
	local selfMinX, selfMaxX, selfMinY, selfMaxY = self:getSelfRange()

	if not minX then
		return selfMinX, selfMaxX, selfMinY, selfMaxY
	else
		return math.min(minX, selfMinX), math.max(maxX, selfMaxX), math.min(minY, selfMinY), math.max(maxY, selfMaxY)
	end
end

function SurvivalBlockCo:getSelfRange()
	local x = self.pos.q + self.pos.r / 2
	local y = -self.pos.r
	local minX, maxX, minY, maxY = x, x, y, y

	for _, point in ipairs(self.exNodes) do
		local pointX = point.q + point.r / 2
		local pointY = -point.r

		minX = math.min(minX, pointX)
		maxX = math.max(maxX, pointX)
		minY = math.min(minY, pointY)
		maxY = math.max(maxY, pointY)
	end

	return minX, maxX, minY, maxY
end

return SurvivalBlockCo
