-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityQuoteTradeItem.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteTradeItem", package.seeall)

local ActivityQuoteTradeItem = class("ActivityQuoteTradeItem", UserDataDispose)

function ActivityQuoteTradeItem:ctor(go)
	self:__onInit()

	self.viewGO = go
	self._godemanditem = gohelper.findChild(go, "#go_demanditem")
	self.content = gohelper.findChild(go, "mask/content")
	self.scroll = gohelper.findChild(self.content, "#scroll_trade"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self.scrollMask = gohelper.findChild(self.content, "#scroll_trade/Viewport"):GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self.scrollcontent = gohelper.findChild(self.content, "#scroll_trade/Viewport/Content")
	self.txtTips = gohelper.findChildTextMesh(self.content, "#go_tips/#txt_tips")
	self._simagetipsbg = gohelper.findChildSingleImage(self.content, "#go_tips/#simage_tipsbg")

	self._simagetipsbg:LoadImage(ResUrl.getVersionTradeBargainBg("img_datiao9"))

	self.goClose = gohelper.findChild(go, "#go_close")
	self._simageclosebg = gohelper.findChildSingleImage(go, "#go_close/#simage_closebg")

	self._simageclosebg:LoadImage(ResUrl.getVersionTradeBargainBg("img_dayang"))

	self._gobargain = gohelper.findChild(go, "mask/content/#scroll_trade/Viewport/Content/#go_bargain")
	self._animbargain = self._gobargain:GetComponent(typeof(UnityEngine.Animator))
	self._goquoteitem = gohelper.findChild(self._gobargain, "#scroll_info/Viewport/Content/#go_quoteitem")
	self._items = {}

	self:addEvents()
end

function ActivityQuoteTradeItem:addEvents()
	return
end

function ActivityQuoteTradeItem:removeEvents()
	return
end

function ActivityQuoteTradeItem:refresh(actId)
	self.actId = actId

	self.refreshTrade(self, self.refreshQuote, self)
end

function ActivityQuoteTradeItem:refreshTrade(callback)
	self.refreshCallback = callback

	TaskDispatcher.cancelTask(self.onAllAnimFinish, self)

	local finishCount, limitCount = Activity117Model.instance:getFinishOrderCount(self.actId)

	self.allFinish = limitCount <= finishCount

	local tag = {
		finishCount,
		limitCount
	}

	self.txtTips.text = self.allFinish and GameUtil.getSubPlaceholderLuaLang(luaLang("v1a2_tradequoteview_tips2"), tag) or GameUtil.getSubPlaceholderLuaLang(luaLang("v1a2_tradequoteview_tips1"), tag)

	gohelper.setActive(self.goClose, self.allFinish or false)

	local dataList = Activity117Model.instance:getOrderList(self.actId)

	self.dataList = dataList
	self.index = 0

	local refreshCount = math.max(#dataList, #self._items)

	TaskDispatcher.cancelTask(self.refreshIndex, self)

	if #self._items >= #dataList then
		for i = 1, refreshCount do
			self:refreshIndex(i)
		end
	else
		TaskDispatcher.runRepeat(self.refreshIndex, self, 0.02, refreshCount)
	end
end

function ActivityQuoteTradeItem:refreshIndex(index)
	index = index or self.index + 1
	self.index = index

	local item = self._items[index]

	if not item then
		local go = gohelper.clone(self._godemanditem, self.scrollcontent, "trade_item" .. tostring(index))

		item = ActivityQuoteDemandItem.New(go)
		self._items[index] = item
	end

	local data = self.dataList[index]

	item:setData(data, self.allFinish, index, #self.dataList, self._onAllAnimFinish, self)

	if data and data.id == self:getSelectOrderId() then
		self.selectIndex = index

		self._gobargain.transform:SetSiblingIndex(index)
	end

	if self.index == #self.dataList and self.refreshCallback then
		self:refreshCallback()
	end
end

function ActivityQuoteTradeItem:onAllAnimFinish()
	if self._items then
		for k, v in pairs(self._items) do
			v:onAllAnimFinish()
		end
	end
end

function ActivityQuoteTradeItem:_onAllAnimFinish()
	TaskDispatcher.runDelay(self.onAllAnimFinish, self, 1)
end

function ActivityQuoteTradeItem:refreshQuote()
	TaskDispatcher.cancelTask(self._animCallback, self)

	local isSelect = not self:noSelectOrder()
	local reset = false

	if self.inSelect ~= isSelect then
		reset = true
		self.inSelect = isSelect

		if isSelect then
			self:playShowQuoteAnim()
		else
			self:playHideQuoteAnim()
		end
	end

	if not isSelect then
		return
	end

	self.scroll.enabled = false
	self.scrollMask.enabled = false

	gohelper.setActive(self._gobargain, true)

	local mo = Activity117Model.instance:getOrderDataById(self.actId, self:getSelectOrderId())

	self.quoteItem = self.quoteItem or ActivityQuoteItem.New(self._goquoteitem)

	if reset then
		self.quoteItem:resetData()
	end

	self.quoteItem:setData(mo)
end

function ActivityQuoteTradeItem:playShowQuoteAnim()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	local item = self._items[self.selectIndex]
	local contentPosY = recthelper.getAnchorY(self.scrollcontent.transform)
	local posY = -recthelper.getAnchorY(item.go.transform) + 215 - contentPosY

	self._tweenId = ZProj.TweenHelper.DOAnchorPosY(self.content.transform, posY, 0.3)

	self._animbargain:Play(UIAnimationName.Open)
end

function ActivityQuoteTradeItem:playHideQuoteAnim()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._tweenId = ZProj.TweenHelper.DOAnchorPosY(self.content.transform, 0, 0.3)

	self._animbargain:Play(UIAnimationName.Close)
	TaskDispatcher.runDelay(self._animCallback, self, 0.6)

	self.scroll.enabled = true
	self.scrollMask.enabled = true
end

function ActivityQuoteTradeItem:_animCallback()
	if not self.inSelect then
		gohelper.setActive(self._gobargain, false)
	end
end

function ActivityQuoteTradeItem:getSelectOrderId()
	return Activity117Model.instance:getSelectOrder(self.actId)
end

function ActivityQuoteTradeItem:noSelectOrder()
	return not self:getSelectOrderId()
end

function ActivityQuoteTradeItem:onNegotiate()
	self:refreshTrade()

	local mo = Activity117Model.instance:getOrderDataById(self.actId, self:getSelectOrderId())

	if self.quoteItem then
		self.quoteItem:onNegotiate(mo)
	end
end

function ActivityQuoteTradeItem:destory()
	TaskDispatcher.cancelTask(self.refreshIndex, self)
	TaskDispatcher.cancelTask(self.onAllAnimFinish, self)
	TaskDispatcher.cancelTask(self._animCallback, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._simagetipsbg:UnLoadImage()
	self._simageclosebg:UnLoadImage()

	for k, v in pairs(self._items) do
		v:destory()
	end

	self._items = nil

	if self.quoteItem then
		self.quoteItem:destory()

		self.quoteItem = nil
	end

	self:removeEvents()
	self:__onDispose()
end

return ActivityQuoteTradeItem
