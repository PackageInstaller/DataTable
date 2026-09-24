-- chunkname: @modules/logic/college/controller/helper/CollegeAttrHelper.lua

module("modules.logic.college.controller.helper.CollegeAttrHelper", package.seeall)

local CollegeAttrHelper = class("CollegeAttrHelper")

function CollegeAttrHelper.getBuildingProduce(itemId)
	local sceneMo = CollegeModel.instance:getSceneMo()
	local sum = 0
	local attrSuffix = CollegeEnum.ItemIdToAttrSuffix[itemId]
	local attrId = CollegeEnum.AttrId[string.format("BuildingItem%s", attrSuffix)]

	for i, v in ipairs(sceneMo.buildingBox.buildings) do
		if v:canProduceItem() then
			sum = sum + math.floor(v.attributeContainer:getAttrVal(attrId))
		end
	end

	return sum
end

function CollegeAttrHelper.getAreaProduce(itemId)
	local sceneMo = CollegeModel.instance:getSceneMo()
	local sum = 0
	local attrSuffix = CollegeEnum.ItemIdToAttrSuffix[itemId]
	local attrId = CollegeEnum.AttrId[string.format("AreaItem%s", attrSuffix)]

	for i, v in ipairs(sceneMo.worldMap.areas) do
		if v:canProduceItem() then
			sum = sum + math.floor(v.attributeContainer:getAttrVal(attrId))
		end
	end

	return sum
end

function CollegeAttrHelper.getOtherProduce(itemId)
	local sceneMo = CollegeModel.instance:getSceneMo()
	local sum = 0
	local attrSuffix = CollegeEnum.ItemIdToAttrSuffix[itemId]
	local playerAttrId = CollegeEnum.AttrId[string.format("PlayerBaseItem%s", attrSuffix)]
	local playerAttrVal = sceneMo.player.attributeContainer:getAttrVal(playerAttrId) / 1000
	local buildingBaseAttrId = CollegeEnum.AttrId[string.format("BuildingBaseItem%s", attrSuffix)]

	for i, v in ipairs(sceneMo.buildingBox.buildings) do
		if v:canProduceItem() then
			sum = sum + math.floor(v.attributeContainer:getAttrVal(buildingBaseAttrId) * playerAttrVal)
		end
	end

	local areaBaseAttrId = CollegeEnum.AttrId[string.format("AreaBaseItem%s", attrSuffix)]

	for i, v in ipairs(sceneMo.worldMap.areas) do
		if v:canProduceItem() then
			sum = sum + math.floor(v.attributeContainer:getAttrVal(areaBaseAttrId) * playerAttrVal)
		end
	end

	return sum
end

function CollegeAttrHelper.getAllProduceInfo(itemId)
	local list = {}
	local allValue = 0
	local value = CollegeAttrHelper.getBuildingProduce(itemId)

	if value > 0 then
		allValue = allValue + value

		table.insert(list, {
			value = value,
			name = luaLang("college_producedesc_building")
		})
	end

	value = CollegeAttrHelper.getAreaProduce(itemId)

	if value > 0 then
		allValue = allValue + value

		table.insert(list, {
			value = value,
			name = luaLang("college_producedesc_area")
		})
	end

	value = CollegeAttrHelper.getOtherProduce(itemId)

	if value > 0 then
		allValue = allValue + value

		table.insert(list, {
			value = value,
			name = luaLang("college_producedesc_other")
		})
	end

	return allValue, list
end

function CollegeAttrHelper.getRefineCostAndRate(lockNum)
	lockNum = lockNum or 0

	local refinedBuildingMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.TrainCharacter)

	if not refinedBuildingMo then
		return {}, 1
	end

	local rate1 = 1 + refinedBuildingMo.attributeContainer:getAttrVal(CollegeEnum.AttrId.BuildingRefineCostFix) / 1000
	local rate2 = refinedBuildingMo.attributeContainer:getAttrVal(CollegeEnum.AttrId.RoleRefineCostFix) / 1000
	local rate3 = CollegeModel.instance:getSceneMo().player.attributeContainer:getAttrVal(CollegeEnum.AttrId.PlayerRefineCostFix) / 1000

	return refinedBuildingMo.refineCostDict[lockNum] or {}, rate1 + rate2 + rate3
end

function CollegeAttrHelper.getRecruitCostAndRate()
	local recruitBuildingMo = CollegeModel.instance:getBuildingMoByType(CollegeEnum.BuildingType.RecruitCharacter)

	if not recruitBuildingMo then
		return {}, 1
	end

	local rate1 = 1 + recruitBuildingMo.attributeContainer:getAttrVal(CollegeEnum.AttrId.BuildingRecruitCostFix) / 1000
	local rate2 = recruitBuildingMo.attributeContainer:getAttrVal(CollegeEnum.AttrId.RoleRecruitCostFix) / 1000
	local rate3 = CollegeModel.instance:getSceneMo().player.attributeContainer:getAttrVal(CollegeEnum.AttrId.PlayerRecruitCostFix) / 1000

	return recruitBuildingMo.recruitCost, rate1 + rate2 + rate3
end

return CollegeAttrHelper
