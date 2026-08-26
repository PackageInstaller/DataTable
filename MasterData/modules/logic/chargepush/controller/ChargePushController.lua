-- chunkname: @modules/logic/chargepush/controller/ChargePushController.lua

module("modules.logic.chargepush.controller.ChargePushController", package.seeall)

local ChargePushController = class("ChargePushController", BaseController)

function ChargePushController:onInit()
	self._pushViewOpenHandler = {
		[ChargePushEnum.PushViewType.MonthCard] = self._onMonthCardPushViewOpen,
		[ChargePushEnum.PushViewType.LevelGoods] = self._onLevelGoodsPushViewOpen,
		[ChargePushEnum.PushViewType.CommonGift] = self._onCommonGiftPushViewOpen
	}
end

function ChargePushController:reInit()
	TaskDispatcher.cancelTask(self.showCachePushView, self)
end

function ChargePushController:addConstEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, self._onMainPopupFlowFinish, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function ChargePushController:_onDailyRefresh()
	ChargePushRpc.instance:sendGetChargePushInfoRequest()
end

function ChargePushController:_onMainPopupFlowFinish()
	ChargePushRpc.instance:sendGetChargePushInfoRequest()
end

function ChargePushController:_onCloseViewFinish(viewName)
	if viewName == self.curPushView then
		self.curPushView = nil
	end

	self:_viewChangeCheckIsInMainView()
end

function ChargePushController:_onOpenViewFinish(viewName)
	self:_viewChangeCheckIsInMainView()
end

function ChargePushController:_viewChangeCheckIsInMainView()
	TaskDispatcher.cancelTask(self.showCachePushView, self)

	if not self:isCanPushView() then
		return
	end

	TaskDispatcher.runDelay(self.showCachePushView, self, 1.6)
end

function ChargePushController:isCanPushView()
	local count = ChargePushModel.instance:getCount()

	if not count or count <= 0 then
		return
	end

	local isInMainView = MainController.instance:isInMainView()

	if not isInMainView then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.MainView) then
		return
	end

	local isInGuide = self:checkInGuide()

	if isInGuide then
		return
	end

	return true
end

function ChargePushController:checkInGuide()
	if GuideController.instance:isForbidGuides() then
		return false
	end

	local isOpenGuideView = ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.GuideView2)
	local forceGuideId = GuideModel.instance:lastForceGuideId()
	local isFinishForceGuide = GuideModel.instance:isGuideFinish(forceGuideId)

	return not isOpenGuideView and isFinishForceGuide or true
end

function ChargePushController:showCachePushView()
	if not self:isCanPushView() then
		return
	end

	local pushMo = ChargePushModel.instance:popNextPushInfo()

	if not pushMo then
		return
	end

	self:showPushViewByConfig(pushMo.config)
end

function ChargePushController:showPushViewByConfig(config)
	if not config then
		return
	end

	local handler = self._pushViewOpenHandler[config.className]

	if not handler then
		return
	end

	ChargePushRpc.instance:sendRecordchargePushRequest(config.goodpushsId)
	handler(self, config)

	return true
end

function ChargePushController:_onMonthCardPushViewOpen(config)
	local cardInfo = StoreModel.instance:getMonthCardInfo()
	local remainDay = cardInfo and cardInfo:getRemainDay2() or StoreEnum.MonthCardStatus.NotPurchase
	local listenerType = tonumber(config.listenerType)
	local listenerParam = string.splitToNumber(config.listenerParam, ",")
	local canPushView = false

	if listenerType == ChargePushEnum.ListenerType.MonthCardBefore then
		remainDay = remainDay + 1
		canPushView = remainDay >= listenerParam[1] and remainDay <= listenerParam[2]
	elseif listenerType == ChargePushEnum.ListenerType.MonthCardAfter then
		canPushView = remainDay <= 0
	else
		logError(string.format("ChargePushController:_onMonthCardPushViewOpen listenerType error [%s] [%s]", config.listenerType, config.listenerParam))
	end

	if not canPushView then
		return
	end

	self:openPushView(ViewName.ChargePushMonthCardView, {
		config = config
	})
end

function ChargePushController:_onLevelGoodsPushViewOpen(config)
	local availableGoodsIds = {}
	local goodsIds = string.splitToNumber(config.containedgoodsId, "#")

	for i, v in ipairs(goodsIds) do
		local goodsMO = StoreModel.instance:getGoodsMO(v)

		if goodsMO and not goodsMO:isSoldOut() then
			table.insert(availableGoodsIds, v)
		end
	end

	if #availableGoodsIds <= 0 then
		return
	end

	self:openPushView(ViewName.ChargePushLevelGoodsView, {
		config = config
	})
end

function ChargePushController:_onCommonGiftPushViewOpen(config)
	local availableGoodsIds = {}
	local goodsIds = string.splitToNumber(config.containedgoodsId, "#")

	for i, v in ipairs(goodsIds) do
		local goodsMO = StoreModel.instance:getGoodsMO(v)

		if goodsMO and not goodsMO:isSoldOut() then
			table.insert(availableGoodsIds, v)
		end
	end

	if #availableGoodsIds <= 0 then
		return
	end

	self:openPushView(ViewName.ChargePushCommonGiftView, {
		config = config
	})
end

function ChargePushController:openPushView(viewName, viewParam)
	self.curPushView = viewName

	ChargePushStatController.instance:statShow(viewParam.config)
	ViewMgr.instance:openView(viewName, viewParam)
end

function ChargePushController:tryShowNextPush(type)
	local list = ChargePushModel.instance:getList()

	if not list or #list <= 0 then
		return
	end

	local pushList = {}

	for _, v in ipairs(list) do
		if v.config.className == type then
			table.insert(pushList, v)
		end
	end

	table.sort(pushList, ChargePushMO.sortFunction)

	if #pushList <= 0 then
		return
	end

	local pushMo = pushList[1]

	ChargePushModel.instance:remove(pushMo)

	return self:showPushViewByConfig(pushMo.config)
end

function ChargePushController:isInPushViewShow()
	return self.curPushView and ViewMgr.instance:isOpen(self.curPushView)
end

ChargePushController.instance = ChargePushController.New()

return ChargePushController
