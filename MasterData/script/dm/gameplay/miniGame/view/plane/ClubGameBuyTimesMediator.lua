-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/ClubGameBuyTimesMediator.lua

ClubGameBuyTimesMediator = class("ClubGameBuyTimesMediator", DmPopupViewMediator, _M)

ClubGameBuyTimesMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubGameBuyTimesMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")

function ClubGameBuyTimesMediator:initialize()
	super.initialize(self)
end

function ClubGameBuyTimesMediator:enterWithData(data)
	self._costData = data.costData
	self._gameType = data.gameType
	self._bagSystem = self._developSystem:getBagSystem()

	local mainPanel = self:getView():getChildByFullName("main")
	local bgNode = mainPanel:getChildByFullName("bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onBackClicked, self),
		title = Strings:get("MiniPlane_Ticket_Buy")
	})

	self._costAmount = self._costData.amount
	self._eachBuyNum = self._costData.eachbuynum or 1

	local mainPanel = self:getView():getChildByFullName("main")
	local descLabel = ccui.RichText:createWithXML(Strings:get("Ninja_Buy", {
		num = self._costAmount,
		fontName = DEFAULT_TTF_FONT,
		count = GameStyle:intNumToCnString(self._eachBuyNum)
	}), {})

	descLabel:ignoreContentAdaptWithSize(true)
	descLabel:rebuildElements()
	descLabel:formatText()
	descLabel:setAnchorPoint(cc.p(0.5, 0.5))
	descLabel:renderContent()
	descLabel:addTo(mainPanel):center(mainPanel:getContentSize()):offset(0, 25)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewByResChange)
end

function ClubGameBuyTimesMediator:refreshViewByResChange(event)
	return
end

function ClubGameBuyTimesMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
end

function ClubGameBuyTimesMediator:bindWidgets()
	self:bindWidget("main.okbtn", TwoLevelMainButton, {
		handler = bind1(self.onOkClicked, self)
	})
end

function ClubGameBuyTimesMediator:onBackClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_2")
		self:close()
	end
end

function ClubGameBuyTimesMediator:onOkClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_2")

		if not self._bagSystem:checkCostEnough(self._costData.id, self._costAmount, {
			type = (self._costData.id == CurrencyIdKind.kDiamond or nil) and "source"
		}) then
			return
		end

		if MiniGameType.kDarts == self._gameType then
			self._miniGameSystem:requestActivityGameBuyTimes(self._miniGameSystem:getDartsSystem():getActivityId(), function()
				self:close()
			end, 102)

			return
		end

		if MiniGameType.kCircus == self._gameType then
			self._miniGameSystem:requestActivityGameBuyTimes(self._miniGameSystem:getCircusSystem():getActivityId(), function()
				self:close()
			end, 102)

			return
		end

		if MiniGameType.kPlumber == self._gameType then
			self._miniGameSystem:requestActivityGameBuyTimes(self._miniGameSystem:getPlumberSystem():getPlumberActivity():getId(), function()
				self:close()
			end)

			return
		end

		local gameId = self._miniGameSystem:getGameByType(self._gameType):getId()

		self._miniGameSystem:requestClubGameBuyTimes(gameId, function()
			self:close()
		end)
	end
end
