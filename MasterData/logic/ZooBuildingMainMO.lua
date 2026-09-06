-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingMainMO.lua

module("logic.extensions.zoo.model.building.ZooBuildingMainMO", package.seeall)

local ZooBuildingMainMO = class("ZooBuildingMainMO", ZooBuildingMO)

function ZooBuildingMainMO:getMaxHappyValue()
	local buildingCo = ZooConfig.instance:getMainBuildingCo(self.buildingLevel)

	if buildingCo then
		return buildingCo.maxHappyValue
	end

	return 0
end

function ZooBuildingMainMO:getAnimalNum()
	local buildingCo = ZooConfig.instance:getMainBuildingCo(self.buildingLevel)

	if buildingCo then
		return buildingCo.animalNum
	end

	return 0
end

function ZooBuildingMainMO:getMaxLevel()
	return #ZooConfig.instance:getAllMainBuildingCos()
end

function ZooBuildingMainMO:getUpgradeCost()
	local buildingCo = ZooConfig.instance:getMainBuildingCo(self.buildingLevel + 1)

	if buildingCo then
		return buildingCo.upgradeCost
	end
end

function ZooBuildingMainMO:getBuildingOpTypes()
	return {
		ZooBuildingOpType.Infomation,
		ZooBuildingOpType.Upgrade,
		ZooBuildingOpType.GetAll
	}
end

function ZooBuildingMainMO:getBuildingLvInstructions()
	local buildingCos = ZooConfig.instance:getAllMainBuildingCos()
	local instructions = {}

	for i = 1, #buildingCos do
		local instruction = BuildingInstructionMO.New()

		instruction.level = buildingCos[i].level
		instruction.instruction = string.format(lang("petzoo_maincity_lvdesc"), buildingCos[i].animalNum, buildingCos[i].maxHappyValue)

		table.insert(instructions, instruction)
	end

	return instructions
end

function ZooBuildingMainMO:getBuildingAttrDescs(level)
	local buildingCo = ZooConfig.instance:getMainBuildingCo(level)

	if not buildingCo then
		return
	end

	local attrsDesc = {}
	local descAnimMo = ZooBuildingAttrDescMO.New()

	descAnimMo.attrName = lang("petzoo_building_main_petnum")
	descAnimMo.attrDesc = tostring(buildingCo.animalNum)

	table.insert(attrsDesc, descAnimMo)

	local descHappyMo = ZooBuildingAttrDescMO.New()

	descHappyMo.attrName = lang("petzoo_building_main_happynum")
	descHappyMo.attrDesc = tostring(buildingCo.maxHappyValue)

	table.insert(attrsDesc, descHappyMo)

	return attrsDesc
end

function ZooBuildingMainMO:_requestLevelup()
	ZooAgent.instance:sendPM_ZooUpgradeMainBuildingReq()
end

function ZooBuildingMainMO:_onClickGetAll()
	ZooAgent.instance:sendPM_ZooGainBuildingProductionReq()
end

return ZooBuildingMainMO
