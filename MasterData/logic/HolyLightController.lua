-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/controller/HolyLightController.lua

module("logic.extensions.holylight.controller.HolyLightController", package.seeall)

local HolyLightController = class("HolyLightController", BaseController)

function HolyLightController:ctor()
	return
end

function HolyLightController:onInit()
	self:onReset()
end

function HolyLightController:onReset()
	self:onResetHolyLightMgrList()
end

function HolyLightController:sendPM_HolyLightGetInfoReq(activityId)
	HolyLightAgent.instance:sendPM_HolyLightGetInfoReq(activityId)
end

function HolyLightController:handlePM_HolyLightGetInfoRes(msg)
	HolyLightModel.instance:handlePM_HolyLightGetInfoRes(msg)

	local mgr = HolyLightController.instance:getHolyLightMgr(msg.activityId)

	mgr:setCurGridId(msg.gridId)
	mgr:setCurCircleId(msg.circle)
	mgr:setCreepsTimes(msg.creepsTime)
	mgr:setCreepsProgress(msg.creepsProgress)
	mgr:setMyPetInfoPool(msg.pets)
	mgr:setMyBuffInfoPool(msg.buffs)
	mgr:setDoubleTime(msg.doubleTime)
	mgr:setShopPetInfoPool(msg.randCreepsIds, msg.usedRandCreepsIds)
	mgr:setRefreshTimesOfShop(msg.refreshTime)
	GlobalDispatcher:dispatch(GlobalNotify.HolyLightGetInfoRes)
end

function HolyLightController:sendPM_HolyLightGoReq(activityId, item, step, diceId)
	HolyLightAgent.instance:sendPM_HolyLightGoReq(activityId, item, step, diceId)
end

function HolyLightController:handlePM_HolyLightGoRes(status, msg)
	if status == 0 then
		HolyLightModel.instance:handlePM_HolyLightGoRes(msg)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HolyLightGoRes, status, msg)
end

function HolyLightController:sendPM_HolyLightRandCreepsReq(activityId)
	HolyLightAgent.instance:sendPM_HolyLightRandCreepsReq(activityId)
end

function HolyLightController:handlePM_HolyLightRandCreepsRes(msg)
	HolyLightModel.instance:handlePM_HolyLightRandCreepsRes(msg)

	local mgr = HolyLightController.instance:getHolyLightMgr(msg.activityId)

	mgr:setShopPetInfoPool(msg.randCreepsIds)
	mgr:setRefreshTimesOfShop(msg.refreshTime)
	GlobalDispatcher:dispatch(GlobalNotify.HolyLightRandCreepsRes)
end

function HolyLightController:sendPM_HolyLightChoiceCreepsReq(activityId, creepsId)
	HolyLightAgent.instance:sendPM_HolyLightChoiceCreepsReq(activityId, creepsId)
end

function HolyLightController:handlePM_HolyLightChoiceCreepsRes(msg)
	HolyLightModel.instance:handlePM_HolyLightChoiceCreepsRes(msg)

	local mgr = HolyLightController.instance:getHolyLightMgr(msg.activityId)

	mgr:setMyPetInfoPool(msg.pets)
	mgr:setShopPetInfoPool(mgr:getShopPetIdList(), msg.usedRandCreepsIds)
	GlobalDispatcher:dispatch(GlobalNotify.HolyLightChoiceCreepsRes)
end

function HolyLightController:sendPM_HolyLightChallengeReq(activityId, form)
	HolyLightAgent.instance:sendPM_HolyLightChallengeReq(activityId, form)
end

function HolyLightController:handlePM_HolyLightChallengeRes(status, msg)
	if status == 0 then
		HolyLightModel.instance:handlePM_HolyLightChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.HolyLightChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function HolyLightController:handlePM_HolyLightChallengeResultRes(msg)
	HolyLightModel.instance:handlePM_HolyLightChallengeResultRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.HolyLightChallengeResultRes)
end

function HolyLightController:sendPM_HolyLightGetRankReq(activityId)
	HolyLightAgent.instance:sendPM_HolyLightGetRankReq(activityId)
end

function HolyLightController:handlePM_HolyLightGetRankRes(msg)
	HolyLightModel.instance:handlePM_HolyLightGetRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HolyLightGetRankRes)
end

function HolyLightController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function HolyLightController:getActivityType()
	return GameEnum.ActivityType.HolyLight
end

function HolyLightController:isInActivityTimeAsHolyLight(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function HolyLightController:onResetHolyLightMgrList()
	if self._holyLightMgrList then
		table.clear(self._holyLightMgrList)
	end

	self._holyLightMgrList = {}
end

function HolyLightController:getHolyLightMgr(activityId)
	activityId = checknumber(activityId)

	if self._holyLightMgrList[activityId] == nil then
		self._holyLightMgrList[activityId] = HolyLightMgr.New(activityId)
	end

	return self._holyLightMgrList[activityId]
end

function HolyLightController:enterBattleAsHolyLight(activityId, masterId)
	local customFmtMo = HolyLightModel.instance:getCustomFmtMoAsHolyLight()

	customFmtMo:updateCfg(activityId, masterId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function HolyLightController:getHlPetCostPrice(activityId, creepsId, level)
	local costPrice = 0
	local data = HolyLightConfig.instance:getHlPetData(activityId, creepsId, level)

	if not string.nilorempty(data.dec) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.dec)

		costPrice = matNum
	end

	return costPrice
end

HolyLightController.instance = HolyLightController.New()

return HolyLightController
