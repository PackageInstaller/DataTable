-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkagelottery/controller/LinkageLotteryController.lua

module("logic.extensions.linkagelottery.controller.LinkageLotteryController", package.seeall)

local LinkageLotteryController = class("LinkageLotteryController", BaseController)

function LinkageLotteryController:ctor()
	return
end

function LinkageLotteryController:onInit()
	return
end

function LinkageLotteryController:getCostItemForBuy(buyPlanId)
	local cfgs = LinkageLotteryConfig.instance:getBuyPlanCfgList(buyPlanId)

	return cfgs[1].buyDec
end

function LinkageLotteryController:getMaxPrizeCount(lotteryPlanId)
	local cfgs = LinkageLotteryConfig.instance:getLotteryCfgList(lotteryPlanId)

	return #cfgs
end

function LinkageLotteryController:getNotHaveLotteryIdList(lotteryPlanId)
	local lotteryIdList = {}
	local cfgList = LinkageLotteryConfig.instance:getLotteryCfgList(lotteryPlanId)

	for i, v in ipairs(cfgList) do
		if not LinkageLotteryModel.instance:isGetedReward(v.lotteryId) then
			table.insert(lotteryIdList, v.lotteryId)
		end
	end

	return lotteryIdList
end

LinkageLotteryController.instance = LinkageLotteryController.New()

return LinkageLotteryController
