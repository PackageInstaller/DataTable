-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/topuplottery/controller/TopUpLotteryController.lua

module("logic.extensions.topuplottery.controller.TopUpLotteryController", package.seeall)

local TopUpLotteryController = class("TopUpLotteryController", BaseController)

TopUpLotteryController.E_GetInfoRes = "E_GetInfoRes"
TopUpLotteryController.E_RandRes = "E_RandRes"

function TopUpLotteryController:ctor()
	return
end

function TopUpLotteryController:onInit()
	return
end

function TopUpLotteryController:handleGetInfoRes(status, msg)
	if status == 0 then
		TopUpLotteryModel.instance:handleGetInfoRes(msg)
		self:localNotify(TopUpLotteryController.E_GetInfoRes)
	end
end

function TopUpLotteryController:handleSetBigPrizeRes(status, msg)
	if status == 0 then
		TopUpLotteryModel.instance:handleSetBigPrizeRes(msg)
		self:localNotify(TopUpLotteryController.E_GetInfoRes)
	end
end

function TopUpLotteryController:handleRandRes(status, msg)
	if status == 0 then
		TopUpLotteryModel.instance:handleRandRes(msg)
		self:localNotify(TopUpLotteryController.E_RandRes, msg.prizeId)
	end
end

function TopUpLotteryController:reqChooseBigPrize(activityId, bigPrizeConfigs)
	UIStateManager.instance:push(ViewName.TopuplotteryprizeView, bigPrizeConfigs, nil, function(choosePrizeConfig)
		if choosePrizeConfig then
			TopUpLotteryAgent.instance:sendPM_TopUpLotterySetBigPrizeReq(activityId, choosePrizeConfig.prizeId)
		end
	end)
end

TopUpLotteryController.instance = TopUpLotteryController.New()

return TopUpLotteryController
