-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/controller/ExchangeController.lua

module("logic.extensions.exchange.controller.ExchangeController", package.seeall)

local ExchangeController = class("ExchangeController", BaseController)

function ExchangeController:ctor()
	ExchangeController.super.ctor(self)
end

function ExchangeController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
	self:onReset()
end

function ExchangeController:onReset()
	self:resetInited()
end

function ExchangeController:_reloadData()
	self:resetInited()
	ExchangeModel.instance:resetInited()
end

function ExchangeController:resetInited()
	self.tabidList = {}

	for k, v in pairs(self.tabidList) do
		self.tabidList[k] = false
	end
end

function ExchangeController:sendGetTabInfo(tabId, callback)
	if ExchangeModel.instance:getTabItems(tabId) then
		GameUtil.callBack(callback)
	else
		self:sendGetInfoForce(tabId, callback)
	end
end

function ExchangeController:sendGetInfoForce(tabId, callback)
	ExchangeAgent.instance:sendExchangeTabInfoReq(tabId, function(msg)
		local tabInfo = msg.tabInfo

		ExchangeModel.instance:setTabItems(tabId, tabInfo)
		GameUtil.callBack(callback)
	end)
end

function ExchangeController:sendExchangeItem(tabId, posId, commodityId, num)
	ExchangeAgent.instance:sendExchangeReq(tabId, posId, commodityId, num, function(msg)
		local changesetid = msg.changeSetId

		ItemGetController.instance:setTitleType(changesetid, ItemGetController.TITLE_EXCHANGE_SUC)
		ExchangeModel.instance:setTabItemHasExchagne(tabId, posId, num)
		GlobalDispatcher:dispatch(GlobalNotify.ExchangeRes)
	end, nil, function(msg, status)
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("兑换失败，商品信息有更新"), function()
			return
		end)
		self:sendGetInfoForce(tabId, callback)
	end)
end

function ExchangeController:sendRefreshTab(tabId, callback)
	ExchangeAgent.instance:sendExchangeRefreshReq(tabId, function(msg)
		ExchangeModel.instance:setTabItems(tabId, msg.tabInfo)
		GameUtil.callBack(callback)
	end)
end

function ExchangeController:handleExchangeAllOpenedTabIds(tabIds)
	ExchangeModel.instance:setAllOpenedTabIds(tabIds)
end

function ExchangeController:isBuyLimit(commodityProgramId)
	local cfg = ExchangeConfig.instance:getPlanCfgByCommodityProgram(commodityProgramId)

	return cfg.sellPeriodLimit ~= "none"
end

function ExchangeController:getSellLimitCount(commodityProgramId)
	local cfg = ExchangeConfig.instance:getPlanCfgByCommodityProgram(commodityProgramId)

	return cfg.sellLimitCount
end

ExchangeController.instance = ExchangeController.New()

return ExchangeController
