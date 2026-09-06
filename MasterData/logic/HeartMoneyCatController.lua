-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartmoneycat/controller/HeartMoneyCatController.lua

module("logic.extensions.heartmoneycat.controller.HeartMoneyCatController", package.seeall)

local HeartMoneyCatController = class("HeartMoneyCatController", BaseController)

HeartMoneyCatController.PM_TreasureBasinGetInfoRes = "HeartMoneyCatController.PM_TreasureBasinGetInfoRes"
HeartMoneyCatController.PM_TreasureBasinMakeMoneyRes = "HeartMoneyCatController.PM_TreasureBasinMakeMoneyRes"

function HeartMoneyCatController:ctor()
	HeartMoneyCatController.super.ctor(self)
end

function HeartMoneyCatController:onInit()
	HeartMoneyCatController.super.onInit(self)
end

function HeartMoneyCatController:onReset()
	HeartMoneyCatController.super.onReset(self)
end

function HeartMoneyCatController:handlePM_TreasureBasinGetInfoRes(msg)
	HeartMoneyCatModel.instance:setTimes(msg.times)
	GlobalDispatcher:dispatch(HeartMoneyCatController.PM_TreasureBasinGetInfoRes)
end

function HeartMoneyCatController:handlePM_TreasureBasinMakeMoneyRes(msg)
	HeartMoneyCatModel.instance:setTimes(msg.times)

	local items = MaterialModel.instance:getMaterialMos(msg.changeSetId)

	HeartMoneyCatModel.instance:setNum(items[1]:GetCount())
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	HeartMoneyCatModel.instance:setChangeSetId(msg.changeSetId)
	GlobalDispatcher:dispatch(HeartMoneyCatController.PM_TreasureBasinMakeMoneyRes)
end

function HeartMoneyCatController:getActivityInfo()
	local activity = HeartMoneyCatConfig.instance:getActivity()

	for i, activityCfg in ipairs(activity) do
		if ActivityDefineController.instance:isInActivityTimeById(73, activityCfg.activityId) then
			local activityInfo = clone(activityCfg)
			local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(73, activityInfo.activityId)

			activityInfo.startTime = startTime
			activityInfo.endTime = endTime

			return activityInfo
		end
	end
end

function HeartMoneyCatController:getPrizeRange(planId, times)
	local prizePlan = HeartMoneyCatConfig.instance:getPrizeByPlanId(planId)
	local min, max = 1000000, 0

	for i, v in ipairs(prizePlan) do
		if times == v.lotteryTimes then
			local left, right = v.range[1], v.range[2]

			min = math.min(min, left)
			max = math.max(max, right)
		end
	end

	return min, max
end

function HeartMoneyCatController:isCanMoney(consumeId)
	local consumePlan = HeartMoneyCatConfig.instance:getConsumeByPlanId(consumeId)

	if HeartMoneyCatModel.instance:getTimes() == nil then
		return false
	end

	local times = math.min(HeartMoneyCatModel.instance:getTimes() + 1, #consumePlan)
	local itemConsume = consumePlan[times].itemConsume
	local matType, id, matNum = MaterialMgr.getMatParams(itemConsume)

	return matNum <= MaterialModel.instance:getMaterialsNumber(matType, id)
end

HeartMoneyCatController.instance = HeartMoneyCatController.New()

return HeartMoneyCatController
