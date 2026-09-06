-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flowergoddess/controller/FlowerGoddessController.lua

module("logic.extensions.flowergoddess.controller.FlowerGoddessController", package.seeall)

local FlowerGoddessController = class("FlowerGoddessController", BaseController)

function FlowerGoddessController:ctor()
	return
end

function FlowerGoddessController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self.startEnterGame, self)
	self:onReset()
end

function FlowerGoddessController:onReset()
	return
end

function FlowerGoddessController:onSendPM_SendGoddessFlowerGetInfoReq(activityId)
	FlowerGoddessAgent.instance:sendPM_SendGoddessFlowerGetInfoReq(activityId)
end

function FlowerGoddessController:onHandlePM_SendGoddessFlowerGetInfoRes(msg)
	FlowerGoddessModel.instance:onHandlePM_SendGoddessFlowerGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FlowerGoddessGetInfo)
end

function FlowerGoddessController:onSendPM_SendGoddessFlowerReq(activityId, flowerId, flowerNum)
	FlowerGoddessAgent.instance:sendPM_SendGoddessFlowerReq(activityId, flowerId, flowerNum)
end

function FlowerGoddessController:onHandlePM_SendGoddessFlowerRes(msg)
	FlowerGoddessModel.instance:onHandlePM_SendGoddessFlowerRes(msg)

	local changeSetId = checknumber(msg.changeSetId)

	if changeSetId ~= 0 then
		MaterialController.instance:saveChangeSetToTemp(changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.FlowerGoddessHandleSendFlower, changeSetId)
end

function FlowerGoddessController:onSendPM_SendGoddessFlowerGainProgressPrizeReq(activityId, prizeId)
	FlowerGoddessAgent.instance:sendPM_SendGoddessFlowerGainProgressPrizeReq(activityId, prizeId)
end

function FlowerGoddessController:onHandlePM_SendGoddessFlowerGainProgressPrizeRes(msg)
	FlowerGoddessModel.instance:onHandlePM_SendGoddessFlowerGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FlowerGoddessGainProPrize)
end

function FlowerGoddessController:startEnterGame()
	self:addMaterialCountChangeListener()
end

function FlowerGoddessController:dailyRefresh()
	return
end

function FlowerGoddessController:addMaterialCountChangeListener()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FlowerGoddess)

	if actCfg == nil then
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.showRedIfHaveItems, self)
end

function FlowerGoddessController:showRedIfHaveItems()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FlowerGoddess)

	if actCfg == nil then
		return
	end

	local activityId = actCfg.activityId
	local gfPlanCfg = FlowerGoddessConfig.instance:getGfPlanCfg(activityId)
	local isNeedRed = false

	for _, data in ipairs(gfPlanCfg) do
		if not string.nilorempty(data.flowerItem) then
			local itemNum = MaterialMgr.getMatCount(data.flowerItem)

			isNeedRed = isNeedRed or itemNum > 0
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_FLOWERGODDESSHAVEITEMS, isNeedRed)
end

function FlowerGoddessController:isHasGainPrize(prizeId)
	local hasGainedPrizeIds = FlowerGoddessModel.instance:getHasGainedPrizeIds()

	return table.indexof(hasGainedPrizeIds, prizeId) ~= false
end

function FlowerGoddessController:isCanGainPrize(prizeId)
	local activityId = FlowerGoddessModel.instance:getActivityId()
	local gfProCfg = FlowerGoddessConfig.instance:getGfProCfg(activityId)
	local data = gfProCfg[prizeId]
	local needIntimacy = data.needIntimacy
	local curInitimacy = FlowerGoddessModel.instance:getCurInitimacy()
	local isHasGain = self:isHasGainPrize(prizeId)

	return not isHasGain and needIntimacy <= curInitimacy
end

FlowerGoddessController.instance = FlowerGoddessController.New()

return FlowerGoddessController
