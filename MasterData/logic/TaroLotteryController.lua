-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tarolottery/controller/TaroLotteryController.lua

module("logic.extensions.tarolottery.controller.TaroLotteryController", package.seeall)

local TaroLotteryController = class("TaroLotteryController", BaseController)

function TaroLotteryController:onInit()
	self:onReset()
end

function TaroLotteryController:onReset()
	self._tarotIds = nil
end

function TaroLotteryController:sendGetInfo(activityId)
	TarotLotteryAgent.instance:sendPM_TarotLotteryInfoReq(activityId)
end

function TaroLotteryController:onGetInfo(msg)
	TaroLotteryModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TaroLotteryInfoUpdate)
end

function TaroLotteryController:sendGetDraw(activityId, times)
	TarotLotteryAgent.instance:sendPM_TarotLotteryDrawReq(activityId, times)
end

function TaroLotteryController:onGetDraw(msg)
	TaroLotteryModel.instance:onGetDraw(msg)
	MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)

	self._tarotIds = {}

	if msg.tarotIds and #msg.tarotIds > 0 then
		self._tarotIds = msg.tarotIds
	end

	GlobalDispatcher:dispatch(GlobalNotify.TaroLotteryInfoUpdate)
end

function TaroLotteryController:tryPopupBigPrize()
	if self._tarotIds and #self._tarotIds > 0 then
		self._tarotIds = nil

		return (clone(self._tarotIds))
	end

	return self._tarotIds
end

function TaroLotteryController:sendGetPrize(activityId, prizeId)
	TarotLotteryAgent.instance:sendPM_TarotLotteryGainProgressReq(activityId, prizeId)
end

function TaroLotteryController:onGetPrize(msg)
	TaroLotteryModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TaroLotteryInfoUpdate)
end

TaroLotteryController.instance = TaroLotteryController.New()

return TaroLotteryController
