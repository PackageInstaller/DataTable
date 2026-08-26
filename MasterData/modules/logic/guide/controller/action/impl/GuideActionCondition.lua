-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionCondition.lua

module("modules.logic.guide.controller.action.impl.GuideActionCondition", package.seeall)

local GuideActionCondition = class("GuideActionCondition", BaseGuideAction)

function GuideActionCondition:onStart(context)
	GuideActionCondition.super.onStart(self, context)

	local param = string.split(self.actionParam, "#")
	local funcName = param[1]
	local step1 = tonumber(param[2])
	local step2 = tonumber(param[3])
	local funcParam = param[4]
	local func = self[funcName]
	local guideMO = GuideModel.instance:getById(self.guideId)

	if func and func(self, funcParam) then
		if guideMO then
			guideMO.currStepId = step2 - 1
		end
	elseif guideMO then
		guideMO.currStepId = step1 - 1
	end

	self:onDone(true)
end

function GuideActionCondition:checkRoomTransport()
	local flag = false
	local list = RoomModel.instance:getBuildingInfoList()

	for i, v in ipairs(list) do
		local config = RoomConfig.instance:getBuildingConfig(v.buildingId)

		if config and config.buildingType == RoomBuildingEnum.BuildingType.Collect and v.use then
			flag = true

			break
		end
	end

	if not flag then
		return false
	end

	flag = false

	for i, v in ipairs(list) do
		local config = RoomConfig.instance:getBuildingConfig(v.buildingId)

		if config and config.buildingType == RoomBuildingEnum.BuildingType.Process and v.use then
			flag = true

			break
		end
	end

	return flag
end

function GuideActionCondition:checkRoomTaskHasFinished()
	local hasFinish, taskIds = RoomSceneTaskController.instance:isFirstTaskFinished()

	return hasFinish
end

function GuideActionCondition:checkSurvivalWeekDay()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	return weekMo.day > 1
end

function GuideActionCondition:checkArcadeHaveRefund()
	local strReturnReward = ArcadeOutSizeModel.instance:getStrReturnRewardData()

	if string.nilorempty(strReturnReward) then
		return false
	else
		return true
	end
end

return GuideActionCondition
