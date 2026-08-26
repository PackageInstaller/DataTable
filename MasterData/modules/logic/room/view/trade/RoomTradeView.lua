-- chunkname: @modules/logic/room/view/trade/RoomTradeView.lua

module("modules.logic.room.view.trade.RoomTradeView", package.seeall)

local RoomTradeView = class("RoomTradeView", BaseView)

function RoomTradeView:onInitView()
	self._godailyselect = gohelper.findChild(self.viewGO, "root/tab/dailytab/#go_dailyselect")
	self._txtdaily = gohelper.findChildText(self.viewGO, "root/tab/dailytab/#txt_daily")
	self._btndailytab = gohelper.findChildButtonWithAudio(self.viewGO, "root/tab/dailytab/#btn_dailytab")
	self._gowholesaleselect = gohelper.findChild(self.viewGO, "root/tab/wholesale /#go_wholesaleselect")
	self._txtwholesale = gohelper.findChildText(self.viewGO, "root/tab/wholesale /#txt_wholesale")
	self._btnwholesaletab = gohelper.findChildButtonWithAudio(self.viewGO, "root/tab/wholesale /#btn_wholesaletab")
	self._gobarrage = gohelper.findChild(self.viewGO, "root/bottom/barrage/#go_barrage")
	self._txtweather = gohelper.findChildText(self.viewGO, "root/bottom/barrage/#go_barrage/#txt_weather")
	self._txtdialogue = gohelper.findChildText(self.viewGO, "root/bottom/barrage/#go_barrage/dialogue/#txt_dialogue")
	self._txttime = gohelper.findChildText(self.viewGO, "root/bottom/time/#txt_time")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTradeView:addEvents()
	self._btndailytab:AddClickListener(self._btndailytabOnClick, self)
	self._btnwholesaletab:AddClickListener(self._btnwholesaletabOnClick, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnGetTradeOrderInfo, self.onRefresh, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.onRefresh, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFinishOrder, self.refreshBarrage, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnCutOrderPage, self.onRefreshOrderPage, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFlyCurrency, self.onFlyCurrency, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.PlayCloseTVAnim, self._onPlayCloseTvAnim, self)
end

function RoomTradeView:removeEvents()
	self._btndailytab:RemoveClickListener()
	self._btnwholesaletab:RemoveClickListener()
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnGetTradeOrderInfo, self.onRefresh, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.onRefresh, self)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFinishOrder, self.refreshBarrage, self)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnCutOrderPage, self.onRefreshOrderPage, self)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFlyCurrency, self.onFlyCurrency, self)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.PlayCloseTVAnim, self._onPlayCloseTvAnim, self)
end

function RoomTradeView:_btndailytabOnClick()
	self:_cutMode(RoomTradeEnum.Mode.DailyOrder)
end

function RoomTradeView:_btnwholesaletabOnClick()
	self:_cutMode(RoomTradeEnum.Mode.Wholesale)
end

function RoomTradeView:_onPlayCloseTvAnim()
	local animatorPlayer = self.viewContainer:getAnimatorPlayer()

	animatorPlayer:Play(UIAnimationName.Close)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_close)
end

function RoomTradeView:_editableInitView()
	self._goBottom = gohelper.findChild(self.viewGO, "root/bottom")
	self._rootBarrage = gohelper.findChild(self.viewGO, "root/bottom/barrage")

	local goDialogue = gohelper.findChild(self.viewGO, "root/bottom/barrage/#go_barrage/dialogue")

	self._layoutDialogue = goDialogue:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	self._goPageRoot = gohelper.findChild(self.viewGO, "root/page")
	self._goPageItem = gohelper.findChild(self.viewGO, "root/page/pointitem")
	self._gollyItem = gohelper.findChild(self.viewGO, "flyitem/go_flyitem")

	gohelper.setActive(self._goPageItem, false)
end

function RoomTradeView:onUpdateParam()
	return
end

function RoomTradeView:onOpen()
	RoomRpc.instance:sendGetOrderInfoRequest(self.onRefresh, self)
	self:_setBarrage()
	self:_updateTime()
	self:_openDefaultMode()
	TaskDispatcher.runRepeat(self._updateTime, self, 1)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_open)
end

function RoomTradeView:onClose()
	self._mode = nil

	TaskDispatcher.cancelTask(self._updateTime, self)
	TaskDispatcher.cancelTask(self._selectMode, self)
	TaskDispatcher.cancelTask(self._hideFlyEffect, self)
	self:_killAnim()
end

function RoomTradeView:onDestroyView()
	return
end

function RoomTradeView:onClickModalMask()
	self:closeThis()
end

function RoomTradeView:_openDefaultMode()
	self._mode = self.viewParam.defaultTab or RoomTradeEnum.Mode.DailyOrder

	self:_selectMode()
	self:_activeTab()
end

function RoomTradeView:_cutMode(mode)
	if self._mode == mode or self._isPlayingSwitchAnim then
		return
	end

	self._mode = mode
	self._isPlayingSwitchAnim = true

	self.viewContainer:playAnim(RoomTradeEnum.TradeAnim.Swicth)
	self:_activeTab()
	TaskDispatcher.cancelTask(self._selectMode, self)
	TaskDispatcher.runDelay(self._selectMode, self, 0.16)
end

function RoomTradeView:_selectMode()
	if not self._mode then
		return
	end

	self._isPlayingSwitchAnim = nil

	self.viewContainer:selectTabView(self._mode)
	self:activeBarrage(self._mode)
end

function RoomTradeView:_activeTab()
	gohelper.setActive(self._godailyselect, self._mode == RoomTradeEnum.Mode.DailyOrder)
	gohelper.setActive(self._gowholesaleselect, self._mode == RoomTradeEnum.Mode.Wholesale)
	gohelper.setActive(self._goPageRoot, self._mode == RoomTradeEnum.Mode.Wholesale)
end

function RoomTradeView:onFlyCurrency()
	self._flyEffect = self._flyEffect or gohelper.findChild(self.viewGO, "vx_vitality/#vitality")

	gohelper.setActive(self._flyEffect, true)
	TaskDispatcher.cancelTask(self._hideFlyEffect, self)
	TaskDispatcher.runDelay(self._hideFlyEffect, self, 1.1)
end

function RoomTradeView:_hideFlyEffect()
	gohelper.setActive(self._flyEffect, false)
end

function RoomTradeView:onRefreshOrderPage(index)
	if self._mode == RoomTradeEnum.Mode.DailyOrder then
		gohelper.setActive(self._goPageRoot, false)

		return
	end

	local maxPage = RoomTradeModel.instance:getWholesaleGoodsPageMaxCount()

	for i = 1, maxPage do
		local item = self:getPageItem(i)

		gohelper.setActive(item.cur, index == i)
	end

	if self._pageItems then
		for i, item in ipairs(self._pageItems) do
			gohelper.setActive(item.go, i <= maxPage)
		end
	end

	gohelper.setActive(self._goPageRoot, true)
end

function RoomTradeView:getPageItem(index)
	self._pageItems = self._pageItems or self:getUserDataTb_()

	local item = self._pageItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goPageItem, "page_" .. index)
		local cur = gohelper.findChild(go, "light")

		item = {
			go = go,
			cur = cur
		}
		self._pageItems[index] = item
	end

	return item
end

function RoomTradeView:_updateTime()
	local t = os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset())

	self._txttime.text = string.format("%02d:%02d", t.hour, t.min)
end

RoomTradeView.iconWidth = 120
RoomTradeView.timeMul = 0.01

function RoomTradeView:_setBarrage()
	RoomTradeModel.instance:initBarrage()

	local weather = RoomTradeModel.instance:getBarrageCo(RoomTradeEnum.BarrageType.Weather)
	local dialogue = RoomTradeModel.instance:getBarrageCo(RoomTradeEnum.BarrageType.Dialogue)

	if weather then
		if not weather.desc then
			local weatherDesc = ""
			local weathWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txtweather, weatherDesc)
			local barrageWidth = self._rootBarrage.transform.rect.width
			local dialogueWidth = barrageWidth - weathWidth - RoomTradeView.iconWidth * 2

			self._txtweather.text = weatherDesc

			if self._layoutDialogue then
				self._layoutDialogue.minWidth = dialogueWidth
			end

			local weatherIcon = weather.icon

			if not string.nilorempty(weatherIcon) then
				local imgWeatherIcon = gohelper.findChildImage(self._txtweather.gameObject, "icon")

				UISpriteSetMgr.instance:setCritterSprite(imgWeatherIcon, weatherIcon)
			end

			self:_killAnim()

			local dialogueDescWidth = 0

			if dialogue then
				local dialogueDesc = dialogue.desc

				dialogueDescWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txtdialogue, dialogueDesc)
				self._txtdialogue.text = dialogueDesc

				recthelper.setAnchorX(self._txtdialogue.transform, RoomTradeView.iconWidth)
				gohelper.setActive(self._txtdialogue.gameObject, true)

				local dialogueIcon = dialogue.icon

				if not string.nilorempty(dialogueIcon) then
					local imgWDialogueIcon = gohelper.findChildImage(self._txtdialogue.gameObject, "icon")

					UISpriteSetMgr.instance:setCritterSprite(imgWDialogueIcon, dialogueIcon)
				end
			else
				self._txtdialogue.text = ""

				gohelper.setActive(self._txtdialogue.gameObject, false)
			end

			recthelper.setAnchorX(self._gobarrage.transform, 0)

			local totalDescWidth = weathWidth + dialogueDescWidth + RoomTradeView.iconWidth * 2
			local time = totalDescWidth * RoomTradeView.timeMul

			self:_runBarrage(totalDescWidth, barrageWidth, time)
		end
	end
end

function RoomTradeView:_runBarrage(width, totalWidth, time)
	local function callback()
		self:_killAnim()
		recthelper.setAnchorX(self._gobarrage.transform, totalWidth + RoomTradeView.iconWidth)

		local _time = (totalWidth + RoomTradeView.iconWidth + width) * RoomTradeView.timeMul

		self:_runBarrage(width, totalWidth, _time)
	end

	self._moveTweenId = ZProj.TweenHelper.DOAnchorPosX(self._gobarrage.transform, -width, time, callback, self, nil, EaseType.Linear)
end

function RoomTradeView:dailyRefresh()
	RoomRpc.instance:sendGetOrderInfoRequest(self.onRefresh, self)
end

function RoomTradeView:_killAnim()
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end
end

function RoomTradeView:onRefresh()
	self:refreshBarrage(self._mode)
end

function RoomTradeView:refreshBarrage(tab)
	self:activeBarrage(tab)
end

function RoomTradeView:activeBarrage(tab)
	if tab == RoomTradeEnum.Mode.DailyOrder then
		local count, max = RoomTradeModel.instance:getDailyOrderFinishCount()
		local isFinishAll = max <= count

		gohelper.setActive(self._goBottom, not isFinishAll)
	else
		gohelper.setActive(self._goBottom, true)
	end
end

return RoomTradeView
