-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingAmusementParkMO.lua

module("logic.extensions.zoo.model.building.ZooBuildingAmusementParkMO", package.seeall)

local ZooBuildingAmusementParkMO = class("ZooBuildingAmusementParkMO", ZooWorkingBuildingMO)

function ZooBuildingAmusementParkMO:getMaxWorkerNum()
	local buildingCo = ZooConfig.instance:getAmusementParkBuildingCo(self.buildingLevel)

	if buildingCo then
		return buildingCo.workerNum
	end

	return 0
end

function ZooBuildingAmusementParkMO:getWorkGeneBenefitKey()
	return "amusementBenefit"
end

function ZooBuildingAmusementParkMO:getMaxScore()
	local buildingCo = ZooConfig.instance:getAmusementParkBuildingCo(self.buildingLevel)

	if buildingCo then
		return buildingCo.maxScore
	end

	return 0
end

function ZooBuildingAmusementParkMO:getRateFactor()
	local buildingCo = ZooConfig.instance:getAmusementParkBuildingCo(self.buildingLevel)

	if buildingCo then
		return buildingCo.rateFactor
	end

	return 0
end

function ZooBuildingAmusementParkMO:getUpgradeCost()
	local buildingCo = ZooConfig.instance:getAmusementParkBuildingCo(self.buildingLevel + 1)

	if buildingCo then
		return buildingCo.upgradeCost
	end
end

function ZooBuildingAmusementParkMO:getMaxLevel()
	return #ZooConfig.instance:getAllAmusementParkBuildingCos()
end

function ZooBuildingAmusementParkMO:getNeedMainBuildingLv()
	local buildingCo = ZooConfig.instance:getAmusementParkBuildingCo(self.buildingLevel + 1)

	if buildingCo then
		return buildingCo.needMainBuildingLv
	end

	return 0
end

function ZooBuildingAmusementParkMO:getBuildingOpTypes()
	return {
		ZooBuildingOpType.Infomation,
		ZooBuildingOpType.Upgrade,
		ZooBuildingOpType.Deployment,
		ZooBuildingOpType.Get
	}
end

function ZooBuildingAmusementParkMO:getBuildingLvInstructions()
	local buildingCos = ZooConfig.instance:getAllAmusementParkBuildingCos()
	local instructions = {}

	for i = 1, #buildingCos do
		local instruction = BuildingInstructionMO.New()

		instruction.level = buildingCos[i].level
		instruction.instruction = string.format(lang("petzoo_amusementpark_lvdesc"), buildingCos[i].workerNum, buildingCos[i].rateFactor, buildingCos[i].maxScore)

		table.insert(instructions, instruction)
	end

	return instructions
end

function ZooBuildingAmusementParkMO:getBuildingAttrDescs(level)
	local buildingCo = ZooConfig.instance:getAmusementParkBuildingCo(level)

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

function ZooBuildingAmusementParkMO:_requestLevelup()
	ZooAgent.instance:sendPM_ZooUpgradeWorkBuildingReq(self:getBuildingId())
end

return ZooBuildingAmusementParkMO
