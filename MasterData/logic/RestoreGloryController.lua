-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/controller/RestoreGloryController.lua

module("logic.extensions.recastglory.controller.RestoreGloryController", package.seeall)

local RestoreGloryController = class("RestoreGloryController", BaseController)

function RestoreGloryController:ctor()
	self:onReset()
end

function RestoreGloryController:onReset()
	GlobalDispatcher:addListener("openrecastgloryshieldview", self._openrecastgloryshieldview, self)
	GlobalDispatcher:addListener("openrecastgloryswordview", self._openrecastgloryswordview, self)
end

function RestoreGloryController:sendPM_RestoreGloryGetInfoReq(activityId)
	RestoreGloryAgent.instance:sendPM_RestoreGloryGetInfoReq(activityId)
end

function RestoreGloryController:handlePM_RestoreGloryGetInfoRes(msg)
	RecastGloryModel.instance:setInfos(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RestoreGloryInfoReq)
end

function RestoreGloryController:sendPM_RestoreGloryGainSpacePrizeReq(activityId, progressId)
	RestoreGloryAgent.instance:sendPM_RestoreGloryGainSpacePrizeReq(activityId, progressId)
end

function RestoreGloryController:handlePM_RestoreGloryGainSpacePrizeRes(msg)
	RecastGloryModel.instance:setGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RestoreGloryGainSpacePrizeReq, msg)
end

function RestoreGloryController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function RestoreGloryController:getActivityType()
	return GameEnum.ActivityType.RECASTGLORY
end

function RestoreGloryController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function RestoreGloryController:_openrecastgloryshieldview(params)
	local gameId = checknumber(params[1])
	local activityId = self:getActivityId()

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show(string.format("不在活动时间范围内(%s)", activityId))

		return
	end

	local function successCallBack()
		if RestoreGloryController.instance:isInActivityTime(activityId) then
			local restoreId = 1

			RestoreGloryController.instance:sendPM_RestoreGloryReq(activityId, restoreId)
		end
	end

	self:openrecastgloryshieldview(gameId, successCallBack)
end

function RestoreGloryController:openrecastgloryshieldview(gameId, successCallBack)
	local gameId = checknumber(gameId)

	UIStateManager.instance:push(ViewName.RecastGloryshieldView, gameId, successCallBack)
end

function RestoreGloryController:_openrecastgloryswordview(params)
	local gameId = checknumber(params[1])
	local activityId = self:getActivityId()

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show(string.format("不在活动时间范围内(%s)", activityId))

		return
	end

	local function successCallBack()
		if RestoreGloryController.instance:isInActivityTime(activityId) then
			local restoreId = 2

			RestoreGloryController.instance:sendPM_RestoreGloryReq(activityId, restoreId)
		end
	end

	self:openrecastgloryswordview(gameId, successCallBack)
end

function RestoreGloryController:openrecastgloryswordview(gameId, successCallBack)
	local gameId = checknumber(gameId)

	UIStateManager.instance:push(ViewName.RecastGloryswordView, gameId, successCallBack)
end

function RestoreGloryController:isGainAllPrize(planId)
	local prizeCfg = RecastGloryConfig.instance:getGloryProgressCfg(planId)

	return checknumber(#RecastGloryModel.instance:getGainPrize()) == #prizeCfg
end

function RestoreGloryController:sendPM_RestoreGloryReq(activityId, restoreId)
	RestoreGloryAgent.instance:sendPM_RestoreGloryReq(activityId, restoreId)
end

function RestoreGloryController:handlePM_RestoreGloryRes(msg)
	RecastGloryModel.instance:setRestoreState(true)
	GlobalDispatcher:dispatch(GlobalNotify.RestoreGlory)
end

RestoreGloryController.instance = RestoreGloryController.New()

return RestoreGloryController
