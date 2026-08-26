-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterMapCo.lua

module("modules.logic.survival.model.shelter.SurvivalShelterMapCo", package.seeall)

local SurvivalShelterMapCo = pureTable("SurvivalShelterMapCo")
local sqrt3 = math.sqrt(3)

function SurvivalShelterMapCo:init(data)
	self.allBlocks = {}
	self.allBlockPaths = data[2]
	self.walkables = {}
	self.allBuildings = {}
	self.buildingDict = {}
	self.allBuildingPaths = data[4]

	for _, block in ipairs(data[1]) do
		local blockCo = SurvivalBlockCo.New()

		blockCo:init(block, self.allBlockPaths)
		table.insert(self.allBlocks, blockCo)

		if blockCo.walkable then
			SurvivalHelper.instance:addNodeToDict(self.walkables, blockCo.pos)
		end

		self.minX, self.maxX, self.minY, self.maxY = blockCo:getRange(self.minX, self.maxX, self.minY, self.maxY)
	end

	if not self.minX then
		self.minX, self.maxX, self.minY, self.maxY = 0, 0, 0, 0
	end

	self.minX = self.minX * sqrt3 / 2
	self.maxX = self.maxX * sqrt3 / 2
	self.minY = self.minY * 3 / 4
	self.maxY = self.maxY * 3 / 4

	for _, building in ipairs(data[3]) do
		local buildingCo = SurvivalShelterBuildingCo.New()

		buildingCo:init(building, self.allBuildingPaths)
		table.insert(self.allBuildings, buildingCo)

		self.buildingDict[buildingCo.id] = buildingCo
	end
end

function SurvivalShelterMapCo:getBuildingById(id)
	return self.buildingDict[id]
end

function SurvivalShelterMapCo:getMainBuild()
	if self.buildingDict == nil then
		return nil
	end

	for _, build in pairs(self.buildingDict) do
		if build then
			local allLevelBuilding = lua_survival_building.configDict[build.cfgId]

			if allLevelBuilding then
				for _, buildCo in pairs(allLevelBuilding) do
					if buildCo and buildCo.type == SurvivalEnum.BuildingType.Base then
						return build
					end
				end
			end
		end
	end

	return nil
end

return SurvivalShelterMapCo
