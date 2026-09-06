-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingRestaurantMO.lua

module("logic.extensions.zoo.model.building.ZooBuildingRestaurantMO", package.seeall)

local ZooBuildingRestaurantMO = class("ZooBuildingRestaurantMO", ZooWorkingBuildingMO)

function ZooBuildingRestaurantMO:getMaxWorkerNum()
	local buildingCo = ZooConfig.instance:getRestaurantBuildingCo(self.buildingLevel)

	if buildingCo then
		return buildingCo.workerNum
	end

	return 0
end

function ZooBuildingRestaurantMO:getWorkGeneBenefitKey()
	return "restaurantBenefit"
end

function ZooBuildingRestaurantMO:getMaxScore()
	local buildingCo = ZooConfig.instance:getRestaurantBuildingCo(self.buildingLevel)

	if buildingCo then
		return buildingCo.maxScore
	end

	return 0
end

function ZooBuildingRestaurantMO:getRateFactor()
	local buildingCo = ZooConfig.instance:getRestaurantBuildingCo(self.buildingLevel)

	if buildingCo then
		return buildingCo.rateFactor
	end

	return 0
end

function ZooBuildingRestaurantMO:getUpgradeCost()
	local buildingCo = ZooConfig.instance:getRestaurantBuildingCo(self.buildingLevel + 1)

	if buildingCo then
		return buildingCo.upgradeCost
	end
end

function ZooBuildingRestaurantMO:getMaxLevel()
	return #ZooConfig.instance:getAllRestaurantBuildingCos()
end

function ZooBuildingRestaurantMO:getNeedMainBuildingLv()
	local buildingCo = ZooConfig.instance:getRestaurantBuildingCo(self.buildingLevel + 1)

	if buildingCo then
		return buildingCo.needMainBuildingLv
	end

	return 0
end

function ZooBuildingRestaurantMO:getBuildingOpTypes()
	return {
		ZooBuildingOpType.Infomation,
		ZooBuildingOpType.Upgrade,
		ZooBuildingOpType.Deployment,
		ZooBuildingOpType.Get
	}
end

function ZooBuildingRestaurantMO:getBuildingLvInstructions()
	local buildingCos = ZooConfig.instance:getAllRestaurantBuildingCos()
	local instructions = {}

	for i = 1, #buildingCos do
		local instruction = BuildingInstructionMO.New()

		instruction.level = buildingCos[i].level
		instruction.instruction = string.format(lang("petzoo_amusementpark_lvdesc"), buildingCos[i].workerNum, buildingCos[i].rateFactor, buildingCos[i].maxScore)

		table.insert(instructions, instruction)
	end

	return instructions
end

function ZooBuildingRestaurantMO:getBuildingAttrDescs(level)
	local buildingCo = ZooConfig.instance:getRestaurantBuildingCo(level)

	if not buildingCo then
		return
	end

	local attrsDesc = {}
	local workerNumMo = ZooBuildingAttrDescMO.New()

	workerNumMo.attrName = lang("petzoo_building_workernum")
	workerNumMo.attrDesc = tostring(buildingCo.workerNum)

	table.insert(attrsDesc, workerNumMo)

	local rateFactorMo = ZooBuildingAttrDescMO.New()

	rateFactorMo.attrName = lang("petzoo_building_worker_ratefactor")
	rateFactorMo.attrDesc = tostring(buildingCo.rateFactor)

	table.insert(attrsDesc, rateFactorMo)

	local maxScoreMo = ZooBuildingAttrDescMO.New()

	maxScoreMo.attrName = lang("petzoo_building_worker_maxscore")
	maxScoreMo.attrDesc = tostring(buildingCo.maxScore)

	table.insert(attrsDesc, maxScoreMo)

	return attrsDesc
end

function ZooBuildingRestaurantMO:_requestLevelup()
	ZooAgent.instance:sendPM_ZooUpgradeWorkBuildingReq(self:getBuildingId())
end

return ZooBuildingRestaurantMO
