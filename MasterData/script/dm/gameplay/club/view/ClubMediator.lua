-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubMediator.lua

ClubMediator = class("ClubMediator", DmAreaViewMediator, _M)

ClubMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ClubMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

local kBtnHandlers = {
	back_btn = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickBack"
	}
}

ClubViewType = {
	kJoin = 2,
	kNotJoin = 1
}

local kClubViewPath = {
	[ClubViewType.kNotJoin] = "ClubApplyView",
	[ClubViewType.kJoin] = "ClubMainMapView"
}
local kClubViewNameStr = {
	[ClubViewType.kNotJoin] = Strings:get("Club_Text48"),
	[ClubViewType.kJoin] = Strings:get("Club_Text50")
}

function ClubMediator:initialize()
	super.initialize(self)
end

function ClubMediator:dispose()
	if self._chatFlowWidget then
		self._chatFlowWidget:dispose()

		self._chatFlowWidget = nil
	end

	if self._currencyInfoWidget then
		self._currencyInfoWidget:dispose()

		self._currencyInfoWidget = nil
	end

	if self._clubInfoWidget then
		self._clubInfoWidget:dispose()

		self._clubInfoWidget = nil
	end

	self._viewClose = true

	self._clubSystem:setListenPush(false)
	self:disposeView()
	super.dispose(self)
end

function ClubMediator:disposeView()
	self._viewCache = nil
end

function ClubMediator:userInject()
	return
end

function ClubMediator:onRegister()
	local view = self:getView()
	local background = cc.Sprite:create("asset/scene/common_bg.jpg")

	background:addTo(view, -1):setName("backgroundBG"):center(view:getContentSize())
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:setupChatFlowWidget()
end

function ClubMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:setupCurrencyInfoWidget()
	self:setupClubInfoWidget()
	self:showChat()
	self:initNodes()
	self:createData()
	self:refreshData()
	self:createMainView(data)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_CREATECLUB_SUCC, self, self.refreshViewByCreateClubScuess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_QUIT_SUCC, self, self.rquitClubScuess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_APPLYSCUESS_SUCC, self, self.applyClubScuess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_REFRESHCLUBINFO_SUCC, self, self.refreshClubScuess)
	self._clubSystem:listenPush()
	self._clubSystem:setListenPush(true)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_CHANGECLUBICON_SUCC, self, self.refreshClubIconByServer)
	self:setupClickEnvs()

	local hasJoinClub = self._clubSystem:getHasJoinClub()

	if hasJoinClub == true then
		AudioEngine:getInstance():playBackgroundMusic("Mus_Community_Scene")
	else
		self._useHomeBGM = true

		local bgImageId = self._settingSystem:getHomeBgId()
		local BGM = ConfigReader:getDataByNameIdAndKey("HomeBackground", bgImageId, "BGM")

		AudioEngine:getInstance():playBackgroundMusic(BGM)
	end
end

function ClubMediator:resumeWithData(data)
	local hasJoinClub = self._clubSystem:getHasJoinClub()

	if hasJoinClub == true then
		AudioEngine:getInstance():playBackgroundMusic("Mus_Community_Scene")
	else
		self._useHomeBGM = true

		local bgImageId = self._settingSystem:getHomeBgId()
		local BGM = ConfigReader:getDataByNameIdAndKey("HomeBackground", bgImageId, "BGM")

		AudioEngine:getInstance():playBackgroundMusic(BGM)
	end
end

function ClubMediator:setupChatFlowWidget()
	local chatFLowNode = self:getView():getChildByName("chat_flow_node")
	local chatFlowWidget = ChatFlowWidget:new(chatFLowNode)

	self:getInjector():injectInto(chatFlowWidget)
	chatFlowWidget:start(ChannelId.kUnionFlow)

	self._chatFlowWidget = chatFlowWidget
end

function ClubMediator:refreshClubScuess(event)
	self._clubSystem:requestClubInfo(function()
		self:createMainView()
	end)
end

function ClubMediator:applyClubScuess(event)
	self:createMainView()
end

function ClubMediator:rquitClubScuess(event)
	delayCallByTime(500, function()
		self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
			showRedPoint = -1,
			type = 4
		}))
		self:dismissWithOptions({
			transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
		})
		cc.Director:getInstance():getOpenGLView():setIMEKeyboardState(false)
	end)
end

function ClubMediator:refreshViewByCreateClubScuess(event)
	self:createMainView()
end

function ClubMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._back_btn = self:getView():getChildByFullName("back_btn")
	self._adjustUtil = self:getView():getChildByFullName("adjustUtil")
	self._clubNode = self:getView():getChildByFullName("clubNode")
end

function ClubMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Club_System")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		title = "",
		hasAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ClubMediator:createData()
	self._player = self._developSystem:getPlayer()
	self._clubInfoOj = self._clubSystem:getClubInfoOj()
end

function ClubMediator:refreshData()
	return
end

function ClubMediator:refreshClubIconByServer()
	self:setupClubInfoWidget()
end

function ClubMediator:createMainView(data)
	local hasJoinClub = self._clubSystem:getHasJoinClub()

	if self._useHomeBGM and hasJoinClub then
		AudioEngine:getInstance():playBackgroundMusic("Mus_Community_Scene")

		self._useHomeBGM = false
	end

	if hasJoinClub then
		if not ClubViewType.kJoin then
			local viewType = ClubViewType.kNotJoin
			local viewPath = kClubViewPath[viewType]

			if self._curView then
				self._curView:removeFromParent(true)
			end

			if viewType == ClubViewType.kNotJoin then
				if self._clubSystem:getForcedLeaveClubMark() == true then
					self._clubSystem:clearForcedLeaveClubMark()
					self:dispatch(ShowTipEvent({
						tip = Strings:get("clubBoss_47")
					}))
				end

				self._topInfoWidget:setVisible(true)
				self._currencyInfoWidget:setVisible(false)
				self._clubNode:setVisible(false)
				self._adjustUtil:setVisible(false)
				self._back_btn:setVisible(false)
				self._chatViewPanel:setVisible(false)
			end

			if viewType == ClubViewType.kJoin then
				self._topInfoWidget:setVisible(false)
				self._currencyInfoWidget:setVisible(true)
				self._clubNode:setVisible(true)
				self._adjustUtil:setVisible(true)
				self._back_btn:setVisible(true)
				self._chatViewPanel:setVisible(true)
			end

			local view = self:getInjector():getInstance(viewPath)

			if view then
				self._mainPanel:addChild(view)
				view:setPosition(0, 0)

				local mediator = self:getMediatorMap():retrieveMediator(view)

				if mediator then
					view.mediator = mediator

					mediator:enterWithData(data)
				end

				self._curView = view
			end

			local viewNameStr = kClubViewNameStr[viewType]

			self._topInfoWidget:updateTitle(viewNameStr)
			self:setupClubInfoWidget()
		end
	end
end

function ClubMediator:refreshSelectView(data)
	if not data or not data.clubName then
		return
	end

	if self._curView then
		local mediator = self._curView.mediator

		mediator:refreshView()

		if mediator.setSelectClubId then
			mediator:setSelectClubId(data.clubName)
		end
	end
end

function ClubMediator:setupCurrencyInfoWidget()
	local currencyInfoNode = self:getView():getChildByFullName("currencyinfo_node")
	local config = {
		CurrencyIdKind.kDiamond,
		CurrencyIdKind.kClub,
		CurrencyIdKind.kGold
	}
	local injector = self:getInjector()

	self._currencyInfoWidget = injector:injectInto(CurrencyInfoWidget:new(currencyInfoNode))

	self._currencyInfoWidget:mapEvent()
	self._currencyInfoWidget:updateCurrencyInfo(config)
end

function ClubMediator:setupClubInfoWidget()
	local hasJoinClub = self._clubSystem:getHasJoinClub()

	if hasJoinClub == false then
		return
	end

	local clubInfoNode = self:getView():getChildByFullName("clubNode")

	if self._clubInfoWidget then
		self._clubInfoWidget:setupView()
	else
		self._clubInfoWidget = self:getInjector():injectInto(ClubInfoWidget:new(clubInfoNode))

		self._clubInfoWidget:initSubviews()
		self._clubInfoWidget:setupView()
	end
end

function ClubMediator:showChat()
	local view = self:getInjector():getInstance("SmallChat")

	if view then
		view:setAnchorPoint(cc.p(0.5, 0.5))
		view:setPosition(cc.p(568, 320))

		if not CommonUtils.GetSwitch("fn_clubBossPass") then
			view:getChildByFullName("passPanel"):setVisible(false)
		end

		self._chatViewPanel = self:getView():getChildByName("chatNode")

		self._chatViewPanel:addChild(view)

		local mediator = self:getMediatorMap():retrieveMediator(view)

		if mediator then
			mediator:setMessageBoxType(ChatTabType.kUnion)
			mediator:enterWithData(nil)

			self._chatMediator = mediator
		end
	end
end

function ClubMediator:onClickBack(sender, eventType)
	self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
		showRedPoint = -1,
		type = 4
	}))
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
	cc.Director:getInstance():getOpenGLView():setIMEKeyboardState(false)
end

function ClubMediator:setupClickEnvs()
	return
end
