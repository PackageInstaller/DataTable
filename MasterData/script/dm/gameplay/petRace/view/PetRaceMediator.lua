-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceMediator.lua

PetRaceMediator = class("PetRaceMediator", DmAreaViewMediator)

PetRaceMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PetRaceMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")
PetRaceMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local viewShowTab = {
	myRace = 2,
	mainRace = 3,
	report = 1
}
local bottomClickEventMap = {
	["Panel_bottom.Node_mainRace.Button"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickMainRace"
	},
	["Panel_bottom.Node_myRace.Button"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickMyRace"
	},
	["Panel_bottom.Node_report.Button"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickReport"
	},
	["Panel_bottom.Node_rule.Button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["Panel_bottom.Node_reward.Button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClicReward"
	},
	["Panel_bottom.Node_rank.Button"] = {
		clickAudio = "Se_Alert_Error",
		func = "onClickRank"
	},
	["Panel_bottom.Node_recruit.Button"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickRecruit"
	}
}

function PetRaceMediator:initialize()
	super.initialize(self)
end

function PetRaceMediator:dispose()
	super.dispose(self)
end

function PetRaceMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(bottomClickEventMap)
	AdjustUtils.ignorSafeAreaRectForNode(self:getView():getChildByFullName("Panel_bottom"), AdjustUtils.kAdjustType.Right)
end

function PetRaceMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PETRACE_STATE_MAIN_CHANGE, self, self.updateState)
end

function PetRaceMediator:enterWithData()
	self:setupTopInfoWidget()

	self._viewType = self._petRaceSystem._mainClickIndex
	self._enterSta = self._petRaceSystem:getState()

	self:setupView()
	self:createAnim()
	self:switchView()
	self._petRaceSystem:setEnterViewSta(true)
	self._petRaceSystem:saveOpenViewState()
	self:mapEventListeners()
	self:setupClickEnvs()
end

function PetRaceMediator:setupView()
	self._panel_base = self:getView():getChildByFullName("Panel_base")
	self._node_anim = self:getView():getChildByFullName("Node_anim")

	local text_rule = self:getView():getChildByFullName("Panel_bottom.Node_rule.Text")
	local text_rank = self:getView():getChildByFullName("Panel_bottom.Node_rank.Text")
	local text_recruit = self:getView():getChildByFullName("Panel_bottom.Node_recruit.Text")
	local text_reward = self:getView():getChildByFullName("Panel_bottom.Node_reward.Text")

	text_rule:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_rank:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_recruit:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text_reward:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(167, 186, 255, 255)
		}
	}

	text_rule:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	text_rank:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	text_recruit:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	text_reward:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	self._panel_bottom = self:getView():getChildByFullName("Panel_bottom")
end

function PetRaceMediator:switchView()
	local function createView(name)
		local view = self:getInjector():getInstance(name)

		if view then
			view:addTo(self._panel_base, 1):center(self._panel_base:getContentSize())

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				mediator:enterWithData()
			end
		end

		return view
	end

	if self._viewType == viewShowTab.mainRace then
		if self._view_reoprt then
			self._view_reoprt:removeFromParent()

			self._view_reoprt = nil
		end

		if self._view_myRace then
			self._view_myRace:removeFromParent()

			self._view_myRace = nil
		end

		self._view_mainRace = self._view_mainRace or createView("PetRaceMainScheduleView")
	elseif self._viewType == viewShowTab.myRace then
		if self._view_reoprt then
			self._view_reoprt:removeFromParent()

			self._view_reoprt = nil
		end

		if self._view_mainRace then
			self._view_mainRace:removeFromParent()

			self._view_mainRace = nil
		end

		self._view_myRace = self._view_myRace or createView("PetRaceScheduleView")
	elseif self._viewType == viewShowTab.report then
		if self._view_myRace then
			self._view_myRace:removeFromParent()

			self._view_myRace = nil
		end

		if self._view_mainRace then
			self._view_mainRace:removeFromParent()

			self._view_mainRace = nil
		end

		self._view_reoprt = self._view_reoprt or createView("PetRaceReportView")
	end

	self._petRaceSystem._mainClickIndex = self._viewType

	self:refreshBtnSta()
	self:updateState()
end

function PetRaceMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("KOF")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Petrace")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function PetRaceMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._petRaceSystem:setEnterViewSta(false)
		self:dismiss()
	end
end

function PetRaceMediator:showTip(str)
	self:dispatch(ShowTipEvent({
		duration = 0.5,
		tip = str
	}))
end

function PetRaceMediator:onClickMainRace(sender, eventType)
	if self._viewType == viewShowTab.mainRace then
		return
	end

	self._viewType = viewShowTab.mainRace

	self:switchView()
end

function PetRaceMediator:onClickMyRace(sender, eventType)
	if self._viewType == viewShowTab.myRace then
		return
	end

	local isRegistOne = self._petRaceSystem:isRegistOneMatch()
	local curIndex = self._petRaceSystem:getPetRace():getCurIndex()
	local enterIndex = self._petRaceSystem:getPetRace():getEnterIndex()

	if (not isRegistOne or curIndex < enterIndex or nil) and true then
		local selectIndex = self._petRaceSystem:getSelectIndex()

		if selectIndex == enterIndex + 1 then
			self:showTip(Strings:get("Petrace_Text_121"))
		else
			self:showTip(Strings:get("Petrace_Text_120"))
		end

		return
	end

	self._viewType = viewShowTab.myRace

	self:switchView()
end

function PetRaceMediator:onClickReport(sender, eventType)
	local isRegistOne = self._petRaceSystem:isRegistOneMatch()
	local isFinalMatch = self._petRaceSystem:isFinalMatch()
	local curIndex = self._petRaceSystem:getPetRace():getCurIndex()
	local enterIndex = self._petRaceSystem:getPetRace():getEnterIndex()
	local isReturn = false

	if not isRegistOne and not isFinalMatch then
		isReturn = true
	elseif curIndex < enterIndex then
		isReturn = true
	end

	if isReturn then
		local selectIndex = self._petRaceSystem:getSelectIndex()

		if selectIndex == enterIndex + 1 then
			self:showTip(Strings:get("Petrace_Text_121"))
		else
			self:showTip(Strings:get("Petrace_Text_120"))
		end

		return
	end

	if self._viewType == viewShowTab.report then
		return
	end

	self._viewType = viewShowTab.report

	self:switchView()
end

function PetRaceMediator:onClickRule(sender, eventType)
	local view = self:getInjector():getInstance("PetRaceRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	})

	self:dispatch(event)
end

function PetRaceMediator:onClicReward(sender, eventType)
	local view = self:getInjector():getInstance("PetRaceRewardView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	})

	self:dispatch(event)
end

function PetRaceMediator:onClickRank(sender, eventType)
	local view = self:getInjector():getInstance("PetRaceRankView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	})

	self:dispatch(event)
end

function PetRaceMediator:onClickRecruit(sender, eventType)
	local recruitSystem = self:getInjector():getInstance(RecruitSystem)
	local data = {
		recruitType = RecruitPoolType.kPvp
	}

	recruitSystem:tryEnter(data)
end

function PetRaceMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("enter_PetRaceMediator")
	end))

	self:getView():runAction(sequence)
end

function PetRaceMediator:refreshBtnSta()
	local img_mainRaceSta = self:getView():getChildByFullName("Panel_bottom.Node_mainRace.Image_1")
	local img_myRaceSta = self:getView():getChildByFullName("Panel_bottom.Node_myRace.Image_1")
	local img_repostSta = self:getView():getChildByFullName("Panel_bottom.Node_report.Image_1")

	img_mainRaceSta:setVisible(false)
	img_myRaceSta:setVisible(false)
	img_repostSta:setVisible(false)

	if self._viewType == viewShowTab.myRace then
		img_myRaceSta:setVisible(true)
	elseif self._viewType == viewShowTab.mainRace then
		img_mainRaceSta:setVisible(true)
	elseif self._viewType == viewShowTab.report then
		img_repostSta:setVisible(true)
	end
end

function PetRaceMediator:updateState(event)
	local state = self._petRaceSystem:getState()

	if self._enterSta == PetRaceEnum.state.regist and state == PetRaceEnum.state.match then
		self._enterSta = state

		if self._viewType ~= viewShowTab.myRace then
			self._viewType = viewShowTab.myRace

			self:switchView()
		end
	end

	self._jjAnim:setVisible(true)

	if self._viewType == viewShowTab.mainRace and state == PetRaceEnum.state.regist then
		self._jjAnim:setVisible(false)
	end
end

function PetRaceMediator:createAnim()
	local anim = cc.MovieClip:create("all_shengshizhengba")

	anim:setPlaySpeed(2)

	local nodeToActionMap = {}

	nodeToActionMap[self._panel_bottom] = anim:getChildByName("bottomNode")

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, self._node_anim)

	startFunc()
	anim:addTo(self._node_anim)
	anim:gotoAndPlay(0)
	anim:addEndCallback(function(cid, mc)
		stopFunc()
		mc:gotoAndPlay(0)
	end)

	local jjAnim = cc.MovieClip:create("jingjirukou_jingjirukou")

	jjAnim:setPosition(cc.p(0, 0))
	self._node_anim:addChild(jjAnim)
	jjAnim:addCallbackAtFrame(12, function()
		jjAnim:stop()
	end)

	self._jjAnim = jjAnim
end
