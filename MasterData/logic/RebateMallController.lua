-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/controller/RebateMallController.lua

module("logic.extensions.doubleeleven.controller.RebateMallController", package.seeall)

local RebateMallController = class("RebateMallController", BaseController)

function RebateMallController:ctor()
	return
end

function RebateMallController:onInit()
	self:onReset()
end

function RebateMallController:onReset()
	self._activityId = nil
end

function RebateMallController:setActId(activityId)
	self._activityId = activityId
end

function RebateMallController:getActId()
	return self._activityId
end

function RebateMallController:sendPM_RebateMallPeriod1InfoReq(activityId)
	RebateMallAgent.instance:sendPM_RebateMallPeriod1InfoReq(activityId)
end

function RebateMallController:handlePM_RebateMallPeriod1InfoRes(status, msg)
	RebateMallModel.instance:setMallRechargeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RebateMallPeriod1InfoRes, msg)
end

function RebateMallController:sendPM_RebateMallPeriod2InfoReq(activityId)
	RebateMallAgent.instance:sendPM_RebateMallPeriod2InfoReq(activityId)
end

function RebateMallController:handlePM_RebateMallPeriod2InfoRes(status, msg)
	RebateMallModel.instance:setBuyInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RebateMallPeriod2InfoRes, msg)
end

function RebateMallController:sendPM_RebateMallGainPrizeReq(activityId, prizeId)
	RebateMallAgent.instance:sendPM_RebateMallGainPrizeReq(activityId, prizeId)
end

function RebateMallController:handlePM_RebateMallGainPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.RebateMallGainPrizeRes, msg)
end

function RebateMallController:sendPM_RebateMallBuyReq(activityId, itemId, deduceCount)
	RebateMallAgent.instance:sendPM_RebateMallBuyReq(activityId, itemId, deduceCount)
end

function RebateMallController:handlePM_RebateMallBuyRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.RebateMallBuyRes, msg)
end

function RebateMallController:sendRebateMallPeriodInfoReq()
	local shopIsOpen = self:isRebateMallBuyShopOpen(self._activityId)

	if shopIsOpen then
		self:sendPM_RebateMallPeriod2InfoReq(self._activityId)
	end

	self:sendPM_RebateMallPeriod1InfoReq(self._activityId)
end

function RebateMallController:rebateMallPeriod()
	local nowTime = ServerTime.now()
	local dayTimestamp = DoubleElevenConfig.instance:getRebateMallActCfgs(self._activityId).days * 86400
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(math.floor(self._activityId / 1000), self._activityId)
	local shopStartTime = startTime + dayTimestamp

	return GameUtil.getTimePeriodTypeBySec(shopStartTime, endTime)
end

function RebateMallController:isRebateMallBuyShopOpen()
	return self:rebateMallPeriod(self._activityId) == GameUtil.inTimePeriod
end

function RebateMallController:shopItemsData()
	local shopItemCfgs = DoubleElevenConfig.instance:getRebateItemCfgs(self._activityId)
	local shopItemsList = {}

	for i, cfg in ipairs(shopItemCfgs) do
		local itemData = {}

		itemData.cfg = cfg
		itemData.buyTimes = self:itemBuyTimes(cfg.id)
		itemData.isSellOut = self:isSellOut(cfg.id)

		table.insert(shopItemsList, itemData)
	end

	table.sort(shopItemsList, function(a, b)
		local remainACount = a.cfg.limitTimes - a.buyTimes
		local remainBCount = b.cfg.limitTimes - b.buyTimes

		if remainACount <= 0 and remainBCount > 0 then
			return false
		end

		if remainACount > 0 and remainBCount <= 0 then
			return true
		end

		return a.cfg.id < b.cfg.id
	end)

	return shopItemsList
end

function RebateMallController:itemBuyTimes(itemId)
	local buyItemsList = RebateMallModel.instance:getBuyInfo()

	for _, data in pairs(buyItemsList) do
		for _, info in pairs(data) do
			if info.itemId == itemId then
				return info.buyTimes
			end
		end
	end

	return 0
end

function RebateMallController:isSellOut(itemId)
	local buyItemsList = RebateMallModel.instance:getBuyInfo()
	local shopItemCfgs = DoubleElevenConfig.instance:getRebateItemCfgs(self._activityId)

	for _, data in pairs(buyItemsList) do
		for _, info in pairs(data) do
			if info.itemId == itemId then
				return info.buyTimes >= shopItemCfgs[itemId].limitTimes
			end
		end
	end

	return false
end

RebateMallController.instance = RebateMallController.New()

return RebateMallController
