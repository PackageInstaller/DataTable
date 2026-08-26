-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterBuildingCo.lua

module("modules.logic.survival.model.shelter.SurvivalShelterBuildingCo", package.seeall)

local SurvivalShelterBuildingCo = pureTable("SurvivalShelterBuildingCo")

function SurvivalShelterBuildingCo:init(data, allPaths)
	self.ponitRange = {}
	self.pointRangeList = {}
	self.pos = SurvivalHexNode.New(data[1], data[2])
	self.id = data[3]
	self.cfgId = data[4]
	self.cfg = lua_survival_building.configDict[self.cfgId][1]
	self.dir = data[5]
	self.assetPath = allPaths[data[6]]
	self.exPoints = {}

	if data[7] then
		for _, v in ipairs(data[7]) do
			local point = SurvivalHexNode.New(v[1], v[2])

			table.insert(self.exPoints, point)
			table.insert(self.pointRangeList, point)
			SurvivalHelper.instance:addNodeToDict(self.ponitRange, point)
		end
	end

	SurvivalHelper.instance:addNodeToDict(self.ponitRange, self.pos)
	table.insert(self.pointRangeList, self.pos)
end

function SurvivalShelterBuildingCo:isInRange(ponit)
	return SurvivalHelper.instance:getValueFromDict(self.ponitRange, ponit)
end

function SurvivalShelterBuildingCo:isCollection()
	return self.cfg.type == SurvivalEnum.BuildingType.Collection
end

return SurvivalShelterBuildingCo
