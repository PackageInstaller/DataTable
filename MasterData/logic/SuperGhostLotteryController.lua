-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/superghostlottery/controllor/SuperGhostLotteryController.lua

module("logic.extensions.superghostlottery.controller.SuperGhostLotteryController", package.seeall)

local SuperGhostLotteryController = class("SuperGhostLotteryController", BaseController)

function SuperGhostLotteryController:ctor()
	return
end

function SuperGhostLotteryController:onInit()
	GlobalDispatcher:addListener(SuperGhostLotteryAgent.handlePM_SuperGhostLotteryGetInfoRes, self._handlePM_SuperGhostLotteryGetInfoRes, self)
	GlobalDispatcher:addListener(SuperGhostLotteryAgent.handlePM_SuperGhostLotterySelectBigPrizeRes, self._handlePM_SuperGhostLotterySelectBigPrizeRes, self)
	GlobalDispatcher:addListener(SuperGhostLotteryAgent.handlePM_SuperGhostLotteryDrawRes, self._handlePM_SuperGhostLotteryDrawRes, self)
	self:onReset()
end

function SuperGhostLotteryController:onReset()
	return
end

function SuperGhostLotteryController:sendPM_SuperGhostLotteryGetInfoReq(activityId)
	SuperGhostLotteryModel.instance:setCurActId(activityId)
	SuperGhostLotteryAgent.instance:sendPM_SuperGhostLotteryGetInfoReq(activityId)
end

function SuperGhostLotteryController:_handlePM_SuperGhostLotteryGetInfoRes(msg)
	SuperGhostLotteryModel.instance:setDrawInfos(msg.round, msg.drawedPrizeIds, msg.selectedBigPrizeIds)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SuperGhostLotteryGetInfoRes)
end

function SuperGhostLotteryController:sendPM_SuperGhostLotterySelectBigPrizeReq(activityId, prizeId)
	self._addPrizeId = prizeId

	SuperGhostLotteryAgent.instance:sendPM_SuperGhostLotterySelectBigPrizeReq(activityId, prizeId)
end

function SuperGhostLotteryController:_handlePM_SuperGhostLotterySelectBigPrizeRes(msg)
	SuperGhostLotteryModel.instance:handlePM_SuperGhostLotterySelectBigPrizeRes(self._addPrizeId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SuperGhostLotterySelectBigPrizeRes)
end

function SuperGhostLotteryController:_handlePM_SuperGhostLotteryDrawRes(msg)
	SuperGhostLotteryModel.instance:drawSuccessed(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SuperGhostLotteryDrawRes)
end

SuperGhostLotteryController.instance = SuperGhostLotteryController.New()

return SuperGhostLotteryController
