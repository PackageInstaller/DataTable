-- chunkname: @modules/logic/survival/model/map/SurvivalMapCo.lua

module("modules.logic.survival.model.map.SurvivalMapCo", package.seeall)

local SurvivalMapCo = pureTable("SurvivalMapCo")
local sqrt3 = math.sqrt(3)

function SurvivalMapCo:init(data)
	self.allBlocks = {}
	self.allPaths = data[2]
	self.rawWalkables = {}

	for _, block in ipairs(data[1]) do
		local blockCo = SurvivalBlockCo.New()

		blockCo:init(block, self.allPaths)
		table.insert(self.allBlocks, blockCo)
		SurvivalHelper.instance:addNodeToDict(self.rawWalkables, blockCo.pos)

		self.minX, self.maxX, self.minY, self.maxY = blockCo:getRange(self.minX, self.maxX, self.minY, self.maxY)
	end

	if not self.minX then
		self.minX, self.maxX, self.minY, self.maxY = 0, 0, 0, 0
	end

	self.minX = self.minX * sqrt3 / 2
	self.maxX = self.maxX * sqrt3 / 2
	self.minY = self.minY * 3 / 4
	self.maxY = self.maxY * 3 / 4
	self.allHightValueNode = {}

	for _, v in ipairs(data[3]) do
		table.insert(self.allHightValueNode, SurvivalHexNode.New(v[1], v[2]))
	end

	self.exitPos = data[4] and SurvivalHexNode.New(data[4][1], data[4][2]) or SurvivalHexNode.New()

	self:resetWalkables()
end

function SurvivalMapCo:resetWalkables()
	self.walkables = LuaUtil.deepCopySimple(self.rawWalkables)
end

function SurvivalMapCo:setWalkByUnitMo(unitMo, isWalkable)
	if isWalkable then
		SurvivalHelper.instance:addNodeToDict(self.walkables, unitMo.pos)
	else
		SurvivalHelper.instance:removeNodeToDict(self.walkables, unitMo.pos)
	end

	if unitMo.exPoints then
		if isWalkable then
			for k, v in pairs(unitMo.exPoints) do
				SurvivalHelper.instance:addNodeToDict(self.walkables, v)
			end
		else
			for k, v in pairs(unitMo.exPoints) do
				SurvivalHelper.instance:removeNodeToDict(self.walkables, v)
			end
		end
	end
end

return SurvivalMapCo
