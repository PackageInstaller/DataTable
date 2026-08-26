-- chunkname: @modules/logic/sp01/act208/controller/Act208Controller.lua

module("modules.logic.sp01.act208.controller.Act208Controller", package.seeall)

local Act208Controller = class("Act208Controller", BaseController)

function Act208Controller:onInit()
	return
end

function Act208Controller:onInitFinish()
	return
end

function Act208Controller:addConstEvents()
	return
end

function Act208Controller:reInit()
	return
end

function Act208Controller:getActInfo(activityId, channelId, callback, callbackObj)
	Act208Rpc.instance:sendGetAct208InfoRequest(activityId, channelId, callback, callbackObj)
end

function Act208Controller:getBonus(activityId, rewardId)
	Act208Rpc.instance:sendAct208ReceiveBonusRequest(activityId, rewardId)
end

Act208Controller.instance = Act208Controller.New()

return Act208Controller
