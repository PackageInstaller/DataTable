-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityQuoteItem.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteItem", package.seeall)

local ActivityQuoteItem = class("ActivityQuoteItem", UserDataDispose)

function ActivityQuoteItem:ctor(go)
	self:__onInit()

	self.go = go
	self.txtremaincount = gohelper.findChildTextMesh(self.go, "top/txt_remaincount")
	self.goTabItem = gohelper.findChild(self.go, "tab/#go_tabitem")
	self.slider = gohelper.findChildSlider(self.go, "slider_setquotevalue")
	self.txtMinPrice = gohelper.findChildTextMesh(self.go, "slider_setquotevalue/txt_min")
	self.txtMaxPrice = gohelper.findChildTextMesh(self.go, "slider_setquotevalue/txt_max")
	self.txtTips = gohelper.findChildText(self.go, "tips")
	self.goDot = gohelper.findChild(self.go, "vx_dot")
	self.goBtn = gohelper.findChild(self.go, "goBtn")
	self.btnQuoted = gohelper.findChildButtonWithAudio(self.goBtn, "btn_quoted")
	self.btnConfirm = gohelper.findChildButtonWithAudio(self.goBtn, "btn_quote", AudioEnum.UI.Play_UI_General_OK)
	self.btnRequote1 = gohelper.findChildButtonWithAudio(self.goBtn, "btn_requote1", AudioEnum.UI.play_ui_bank_open)
	self.btnRequote2 = gohelper.findChildButtonWithAudio(self.goBtn, "btn_requote2", AudioEnum.UI.play_ui_bank_open)
	self.btnDeal = gohelper.findChildButtonWithAudio(self.goBtn, "btn_deal", AudioEnum.UI.play_ui_bank_open)

	self.btnConfirm:AddClickListener(self.onClickSubmitMyPrice, self)
	self.btnDeal:AddClickListener(self.onClickConfirmPrice, self)
	self.btnRequote1:AddClickListener(self.onClickRetryBargain, self)
	self.btnRequote2:AddClickListener(self.onClickRetryBargain, self)
	self.slider:AddOnValueChanged(self.onSliderValueChanged, self)

	self.tabItems = {}
end

function ActivityQuoteItem:resetData()
	self.isWait = false

	if self.slider then
		self.slider:SetValue(0.5)
	end
end

function ActivityQuoteItem:setData(data)
	self.data = data
	self.actId = data and data.activityId

	if not data then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)
	self:updateView()
end

function ActivityQuoteItem:updateView()
	self.dealCount = #self.data.userDealScores
	self.limitCount = CommonConfig.instance:getConstNum(ConstEnum.ActivityTradeMaxTimes)
	self.curIndex = self.dealCount + (Activity117Model.instance:isInQuote(self.actId) and 1 or 0)
	self.curIndex = Mathf.Clamp(self.curIndex, 1, self.limitCount)
	self.hasCount = self.limitCount - self.dealCount > 0

	local tag = {
		self.limitCount - self.dealCount,
		self.limitCount
	}

	self.txtremaincount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a2_tradequoteview_remaincount"), tag)

	self:updateTabs()
	self:updateContent()
end

function ActivityQuoteItem:onNegotiate(data)
	self.isWait = true

	self:setData(data)
end

function ActivityQuoteItem:_delaySetData()
	TaskDispatcher.cancelTask(self._delaySetData, self)

	if not self.isWait then
		return
	end

	self.isWait = false

	self:setData(self.data)
end

function ActivityQuoteItem:updateTabs()
	local extCount = 0

	if not self.hasCount and not self.isWait then
		local score = self.data.userDealScores[self.dealCount]
		local priceType = self.data:checkPrice(score)

		if priceType == Activity117Enum.PriceType.Bad then
			extCount = 1
		end
	end

	self.curTabIndex = self.curIndex + extCount

	local count = self.limitCount + extCount

	for i = 1, math.max(count, #self.tabItems) do
		self.tabItems[i] = self.tabItems[i] or self:createTab(i)

		self:updateTab(self.tabItems[i], i <= count)
	end
end

function ActivityQuoteItem:createTab(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.cloneInPlace(self.goTabItem, "tab" .. index)
	item.goCurrent = gohelper.findChild(item.go, "go_current")
	item.txtCurrent = gohelper.findChildTextMesh(item.go, "go_current/txt_curvalue")
	item.goCurrentLine = gohelper.findChild(item.go, "go_current/txt_curvalue/go_line")
	item.goCricle = gohelper.findChild(item.go, "go_current/circle")
	item.goUnfinish = gohelper.findChild(item.go, "go_unfinish")
	item.goFinish = gohelper.findChild(item.go, "go_finish")
	item.txtFinish = gohelper.findChildTextMesh(item.go, "go_finish/txt_quotevalue")

	gohelper.setActive(item.go, true)

	return item
end

function ActivityQuoteItem:updateTab(item, show)
	if not show then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local isCur = item.index == self.curTabIndex
	local score = self.data.userDealScores[item.index]

	if item.index > self.limitCount then
		score = self.data:getMinPrice()
	end

	if isCur then
		gohelper.setActive(item.goCurrent, true)
		gohelper.setActive(item.goFinish, false)
		gohelper.setActive(item.goUnfinish, false)

		if score then
			local priceType = self.data:checkPrice(score)

			if not self.isWait and priceType == Activity117Enum.PriceType.Bad then
				item.txtCurrent.text = string.format("<color=#797E79>%s</color>", score)

				gohelper.setActive(item.goCurrentLine, true)
			else
				item.txtCurrent.text = score

				gohelper.setActive(item.goCurrentLine, false)
			end
		else
			item.txtCurrent.text = self:getSliderValue()

			gohelper.setActive(item.goCurrentLine, false)
		end
	else
		gohelper.setActive(item.goCurrent, false)

		if score then
			gohelper.setActive(item.goFinish, true)
			gohelper.setActive(item.goUnfinish, false)

			item.txtFinish.text = string.format("%s", score)
		else
			gohelper.setActive(item.goFinish, false)
			gohelper.setActive(item.goUnfinish, true)
		end
	end
end

function ActivityQuoteItem:updateContent()
	TaskDispatcher.cancelTask(self.showTalkDesc, self)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	if self.isWait then
		self.txtTips.text = ""

		Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, self.actId, "", true)
		self:setBtnActive(false, false, true, false, false)
		gohelper.setActive(self.slider, false)
		TaskDispatcher.runDelay(self._delaySetData, self, 3)
		gohelper.setActive(self.goDot, true)

		return
	end

	gohelper.setActive(self.goDot, false)

	local score = self.data.userDealScores[self.curIndex]

	if score then
		local priceType = self.data:checkPrice(score)

		if priceType ~= Activity117Enum.PriceType.Bad then
			self:setBtnActive(self.hasCount, false, false, false, true)
		else
			self:setBtnActive(false, self.hasCount, false, false, not self.hasCount)

			if self.curIndex == self.limitCount then
				priceType = Activity117Enum.PriceType.LastFail
			end
		end

		self:updateTalk(priceType)
		gohelper.setActive(self.slider, false)

		return
	end

	gohelper.setActive(self.slider, true)

	self.txtTips.text = ""

	self:setBtnActive(false, false, false, true, false)

	self.txtMinPrice.text = self.data.minScore
	self.txtMaxPrice.text = self.data.maxScore

	Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, self.actId)
end

function ActivityQuoteItem:setBtnActive(requote1, requote2, quoted, quote, deal)
	gohelper.setActive(self.btnRequote1, requote1)
	gohelper.setActive(self.btnRequote2, requote2)
	gohelper.setActive(self.btnQuoted, quoted)
	gohelper.setActive(self.btnConfirm, quote)
	gohelper.setActive(self.btnDeal, deal)
end

function ActivityQuoteItem:updateTalk(priceType)
	local co = Activity117Config.instance:getTalkCo(self.actId, priceType)

	if co then
		if not co.content2 then
			self.talkContent = ""
			self.txtTips.text = ""

			Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, self.actId, (co or nil) and (co.content1 or ""))
			TaskDispatcher.runDelay(self.showTalkDesc, self, 2)
		end
	end
end

function ActivityQuoteItem:showTalkDesc()
	TaskDispatcher.cancelTask(self.showTalkDesc, self)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	self.txtTips.text = ""
	self.tweenId = ZProj.TweenHelper.DOText(self.txtTips, self.talkContent, 2)
end

function ActivityQuoteItem:getSliderValue()
	if not self.data then
		return 0
	end

	return tostring(math.ceil(self.slider:GetValue() * (self.data.maxScore - self.data.minScore)) + self.data.minScore)
end

function ActivityQuoteItem:refreshBargainSliderText()
	local curItem = self.tabItems[(not self.curIndex or nil) and 1]

	if curItem then
		curItem.txtCurrent.text = self:getSliderValue()
	end
end

function ActivityQuoteItem:onSliderValueChanged(value)
	self:refreshBargainSliderText()

	local curTime = Time.realtimeSinceStartup

	if not self._audioTime then
		self._audioTime = Time.realtimeSinceStartup

		AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_Star_In)

		return
	end

	local deltaTime = curTime - self._audioTime

	if deltaTime > 0.1 then
		self._audioTime = curTime

		AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_Star_In)
	end
end

function ActivityQuoteItem:onClickRetryBargain(data)
	Activity117Model.instance:setInQuote(self.actId, true)
	Activity117Controller.instance:dispatchEvent(Activity117Event.RefreshQuoteView, self.actId)
end

function ActivityQuoteItem:onClickConfirmPrice(data)
	local orderId = Activity117Model.instance:getSelectOrder(self.actId)

	Activity117Rpc.instance:sendAct117DealRequest(self.actId, orderId)
end

function ActivityQuoteItem:onClickSubmitMyPrice()
	local data = self.data

	if not data then
		return
	end

	local orderId = Activity117Model.instance:getSelectOrder(self.actId)
	local price = math.ceil(self.slider:GetValue() * (data.maxScore - data.minScore)) + data.minScore

	local function yesFunc()
		Activity117Rpc.instance:sendAct117NegotiateRequest(self.actId, orderId, price)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.TradeBargainConfirm, MsgBoxEnum.BoxType.Yes_No, yesFunc)
end

function ActivityQuoteItem:destory()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	self.tabItems = nil

	self.btnConfirm:RemoveClickListener()
	self.btnDeal:RemoveClickListener()
	self.btnRequote1:RemoveClickListener()
	self.btnRequote2:RemoveClickListener()
	self.slider:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self._delaySetData, self)
	TaskDispatcher.cancelTask(self.showTalkDesc, self)
	self:__onDispose()
end

return ActivityQuoteItem
