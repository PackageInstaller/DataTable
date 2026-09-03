-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarActivityBuyTimesMediator.lua

PlaneWarActivityBuyTimesMediator = class("PlaneWarActivityBuyTimesMediator", DmPopupViewMediator, _M)

PlaneWarActivityBuyTimesMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlaneWarActivityBuyTimesMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")

function PlaneWarActivityBuyTimesMediator:initialize()
	super.initialize(self)
end

function PlaneWarActivityBuyTimesMediator:enterWithData(data)
	self._costData = data.cost
	self._activityId = data.activityId
	self._bagSystem = self._developSystem:getBagSystem()

	local mainPanel = self:getView():getChildByFullName("main")
	local bgNode = mainPanel:getChildByFullName("bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onBackClicked, self),
		title = Strings:get("MiniPlane_Ticket_Buy")
	})

	self._costAmount = self._costData.amount

	local mainPanel = self:getView():getChildByFullName("main")
	local descLabel = ccui.RichText:createWithXML(Strings:get("MiniPlane_Ticket", {
		num = self._costAmount,
		fontName = DEFAULT_TTF_FONT
	}), {})

	descLabel:ignoreContentAdaptWithSize(true)
	descLabel:rebuildElements()
	descLabel:formatText()
	descLabel:setAnchorPoint(cc.p(0.5, 0.5))
	descLabel:renderContent()
	descLabel:addTo(mainPanel):center(mainPanel:getContentSize()):offset(0, 25)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_BUYTIMES_SCUESS, self, self.buyTimesScuess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_CLOSE, self, self.activityClose)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewByResChange)
end

function PlaneWarActivityBuyTimesMediator:refreshViewByResChange(event)
	return
end

function PlaneWarActivityBuyTimesMediator:activityClose(event)
	local data = event:getData()

	if data.activityId == self._activityId then
		self:close()
	end
end

function PlaneWarActivityBuyTimesMediator:buyTimesScuess(event)
	self:close()
end

function PlaneWarActivityBuyTimesMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
end

function PlaneWarActivityBuyTimesMediator:bindWidgets()
	self:bindWidget("main.okbtn", TwoLevelMainButton, {
		handler = bind1(self.onOkClicked, self)
	})
end

function PlaneWarActivityBuyTimesMediator:onBackClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_2")
		self:close()
	end
end

function PlaneWarActivityBuyTimesMediator:onOkClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		snkAudio.play("Se_Click_Common_2")

		if not self._bagSystem:checkCostEnough(self._costData.id, self._costAmount, {
			type = "tip"
		}) then
			return
		end

		self._miniGameSystem:requestClubGameBuyTimes(MiniGameType.kPlaneWar, function()
			self:close()
		end)
	end
end
