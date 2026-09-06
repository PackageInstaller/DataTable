-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/controller/DivineKingShiKongLongZunController.lua

module("logic.extensions.divinekingshikongllongzun.controller.DivineKingShiKongLongZunController", package.seeall)

local DivineKingShiKongLongZunController = class("DivineKingShiKongLongZunController", BaseController)

function DivineKingShiKongLongZunController:onInit()
	self:onReset()
end

function DivineKingShiKongLongZunController:onReset()
	return
end

function DivineKingShiKongLongZunController:sendPM_DivineKingSpaceDragonInfoReq(activityId)
	DivineKingShiKongLongZunAgent.instance:sendPM_DivineKingSpaceDragonInfoReq(activityId)
end

function DivineKingShiKongLongZunController:handlePM_DivineKingSpaceDragonInfoRes(msg)
	DivineKingShiKongLongZunModel.instance:handlePM_DivineKingSpaceDragonInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineKingSpaceDragonInfoRes)
end

function DivineKingShiKongLongZunController:sendPM_DivineKingSpaceDragonResetFloorReq(activityId, floorId)
	DivineKingShiKongLongZunAgent.instance:sendPM_DivineKingSpaceDragonResetFloorReq(activityId, floorId)
end

function DivineKingShiKongLongZunController:handlePM_DivineKingSpaceDragonResetFloorRes(msg)
	DivineKingShiKongLongZunModel.instance:handlePM_DivineKingSpaceDragonResetFloorRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineKingSpaceDragonResetFloorRes)
end

function DivineKingShiKongLongZunController:sendPM_DivineKingSpaceDragonChallengeReq(activityId, form, floorId, stageId)
	DivineKingShiKongLongZunAgent.instance:sendPM_DivineKingSpaceDragonChallengeReq(activityId, form, floorId, stageId)
end

function DivineKingShiKongLongZunController:handlePM_DivineKingSpaceDragonNotifyChallengeRes(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, msg))

	if msg.isWin then
		DivineKingShiKongLongZunModel.instance:handlePM_DivineKingSpaceDragonNotifyChallengeRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_DivineKingSpaceDragonNotifyChallengeRes)
end

function DivineKingShiKongLongZunController:_onResFightEnd(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)

	if msg.isWin and msg.stageId == 1 then
		UIStateManager.instance:push(ViewName.DivineKingShiKongLongZunFightEndView, msg)

		return true
	end

	return false
end

function DivineKingShiKongLongZunController:enterBattleClg(activityId, floorId, stageId)
	local customFmtMo = stageId == 1 and DivineKingShiKongLongZunModel.instance:getFmtMo(activityId) or DivineKingShiKongLongZunModel.instance:getSecondFmtMo(activityId)

	customFmtMo:updateCfg(activityId, floorId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineKingShiKongLongZunController:allFloorHasFirstPass(activityId)
	local floorCfgs = DivineKingShiKongLongZunConfig.instance:getFloorCfgs(activityId)
	local info = DivineKingShiKongLongZunModel.instance:getInfo(activityId)
	local floorInfos = info.floorInfos

	for i, floorInfo in ipairs(floorInfos) do
		if not floorInfo.isPassFloor then
			return false
		end
	end

	return true
end

function DivineKingShiKongLongZunController:floorHasFirstPass(activityId, floorId)
	local floorCfgs = DivineKingShiKongLongZunConfig.instance:getFloorCfgs(activityId)
	local info = DivineKingShiKongLongZunModel.instance:getInfo(activityId)
	local floorInfo = info.floorInfos[floorId]

	return (floorInfo or nil) and (floorInfo.isPassFloor or false)
end

function DivineKingShiKongLongZunController:allFloorHasPass(activityId)
	local floorCfgs = DivineKingShiKongLongZunConfig.instance:getFloorCfgs(activityId)
	local info = DivineKingShiKongLongZunModel.instance:getInfo(activityId)
	local floorInfos = info.floorInfos

	for i, floorInfo in ipairs(floorInfos) do
		if not floorInfo.isPassFloor then
			return false
		end
	end

	return true
end

function DivineKingShiKongLongZunController:getCanChallengeFloor(activityId)
	local floorCfgs = DivineKingShiKongLongZunConfig.instance:getFloorCfgs(activityId)
	local info = DivineKingShiKongLongZunModel.instance:getInfo(activityId)
	local floorInfos = info.floorInfos
	local canChanllegeFloor = 0

	for i, floorInfo in ipairs(floorInfos) do
		if floorInfo.maxPassStageId < DivineKingShiKongLongZunModel.FLOOR_TOTAL_CHALLENGE_NUM then
			canChanllegeFloor = floorInfo.floorId

			break
		end
	end

	return canChanllegeFloor
end

DivineKingShiKongLongZunController.instance = DivineKingShiKongLongZunController.New()

return DivineKingShiKongLongZunController
