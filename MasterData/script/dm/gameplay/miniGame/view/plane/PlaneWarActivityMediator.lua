-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/plane/PlaneWarActivityMediator.lua

PlaneWarActivityMediator = class("PlaneWarActivityMediator", PlaneWarBaseMediator, _M)

PlaneWarActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["bottomnode.rulebtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	},
	["bottomnode.rankbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRank"
	},
	["bottomnode.rewardbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReward"
	},
	["main.beginbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBegin"
	}
}

function PlaneWarActivityMediator:initialize()
	super.initialize(self)
end

function PlaneWarActivityMediator:dispose()
	super.dispose(self)

	if self._rollSchedule then
		self._rollSchedule:stop()

		self._rollSchedule = nil
	end
end

function PlaneWarActivityMediator:userInject()
	return
end

function PlaneWarActivityMediator:onRegister()
	super.onRegister(self)

	local view = self:getView()
	local background1 = cc.Sprite:create("asset/ui/minigame/city.png")

	background1:addTo(view, -1):setName("backgroundBG1"):center(view:getContentSize())

	local background2 = cc.Sprite:create("asset/ui/minigame/city.png")

	background2:addTo(view, -1):setName("backgroundBG2"):center(view:getContentSize())

	local background3 = cc.Sprite:create("asset/ui/minigame/city.png")

	background3:addTo(view, -1):setName("backgroundBG3"):center(view:getContentSize())

	self._rollsCityBg = {
		background1,
		background2,
		background3
	}

	local background1 = cc.Sprite:create("asset/ui/minigame/floor.png")

	background1:addTo(view, -2):setName("backgroundBG21"):center(view:getContentSize())

	local background2 = cc.Sprite:create("asset/ui/minigame/floor.png")

	background2:addTo(view, -2):setName("backgroundBG22"):center(view:getContentSize())

	local background3 = cc.Sprite:create("asset/ui/minigame/floor.png")

	background3:addTo(view, -2):setName("backgroundBG23"):center(view:getContentSize())

	self._rollsfloorBg = {
		background1,
		background2,
		background3
	}

	local background1 = cc.Sprite:create("asset/ui/minigame/sky.png")

	background1:addTo(view, -3):setName("backgroundBG31"):center(view:getContentSize())

	local background2 = cc.Sprite:create("asset/ui/minigame/sky.png")

	background2:addTo(view, -3):setName("backgroundBG32"):center(view:getContentSize())

	local background3 = cc.Sprite:create("asset/ui/minigame/sky.png")

	background3:addTo(view, -3):setName("backgroundBG33"):center(view:getContentSize())

	self._rollsSkyBg = {
		background1,
		background2,
		background3
	}

	self:mapButtonHandlersClick(kBtnHandlers)
end

function PlaneWarActivityMediator:bindWidgets()
	return
end

function PlaneWarActivityMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
	self:adaptBackground(self:getView():getChildByName("backgroundBG1"))
	self:adaptBackground(self:getView():getChildByName("backgroundBG2"))
	self:adaptBackground(self:getView():getChildByName("backgroundBG3"))
	self:adaptBackground(self:getView():getChildByName("backgroundBG21"))
	self:adaptBackground(self:getView():getChildByName("backgroundBG22"))
	self:adaptBackground(self:getView():getChildByName("backgroundBG23"))
	self:adaptBackground(self:getView():getChildByName("backgroundBG31"))
	self:adaptBackground(self:getView():getChildByName("backgroundBG32"))
	self:adaptBackground(self:getView():getChildByName("backgroundBG33"))
end

function PlaneWarActivityMediator:repositeBgs1()
	for k, v in pairs(self._rollsCityBg) do
		if self._rollsCityBg[k - 1] then
			self._rollsCityBg[k]:setPositionX(self._rollsCityBg[k - 1]:getPositionX() + 1386 * self._rollsCityBg[k - 1]:getScaleX())
		end
	end
end

function PlaneWarActivityMediator:repositeBgs2()
	for k, v in pairs(self._rollsfloorBg) do
		if self._rollsfloorBg[k - 1] then
			self._rollsfloorBg[k]:setPositionX(self._rollsfloorBg[k - 1]:getPositionX() + 1386 * self._rollsfloorBg[k - 1]:getScaleX())
		end
	end
end

function PlaneWarActivityMediator:repositeBgs3()
	for k, v in pairs(self._rollsSkyBg) do
		if self._rollsSkyBg[k - 1] then
			self._rollsSkyBg[k]:setPositionX(self._rollsSkyBg[k - 1]:getPositionX() + 1386 * self._rollsSkyBg[k - 1]:getScaleX())
		end
	end
end

function PlaneWarActivityMediator:setRollBgSpeed(value)
	self._rollSpeed = value
end

function PlaneWarActivityMediator:getRollBgSpeed()
	return self._rollSpeed or 20
end

function PlaneWarActivityMediator:startRollBg()
	local function rollFunc(_, dt)
		local switchBg

		for k, v in pairs(self._rollsCityBg) do
			local targetPs = cc.p(v:getPositionX() + v:getContentSize().width / 2, 0)
			local wordPs = v:getParent():convertToWorldSpace(targetPs)

			v:setPositionX(v:getPositionX() - self:getRollBgSpeed() * dt)

			if wordPs.x <= -100 then
				switchBg = v

				break
			end
		end

		if switchBg then
			local index = table.find(self._rollsCityBg, switchBg)

			if index then
				self._rollsCityBg[#self._rollsCityBg + 1] = self._rollsCityBg[index]

				table.remove(self._rollsCityBg, index)
				self:repositeBgs1()

				switchBg = nil
			end
		end

		local switchBg2

		for k, v in pairs(self._rollsSkyBg) do
			local targetPs = cc.p(v:getPositionX() + v:getContentSize().width / 2, 0)
			local wordPs = v:getParent():convertToWorldSpace(targetPs)

			v:setPositionX(v:getPositionX() - self:getRollBgSpeed() * dt * 0.5)

			if wordPs.x <= -100 then
				switchBg2 = v

				break
			end
		end

		if switchBg2 then
			local index = table.find(self._rollsSkyBg, switchBg2)

			if index then
				self._rollsSkyBg[#self._rollsSkyBg + 1] = self._rollsSkyBg[index]

				table.remove(self._rollsSkyBg, index)
				self:repositeBgs2()

				switchBg2 = nil
			end
		end

		local switchBg3

		for k, v in pairs(self._rollsfloorBg) do
			local targetPs = cc.p(v:getPositionX() + v:getContentSize().width / 2, 0)
			local wordPs = v:getParent():convertToWorldSpace(targetPs)

			v:setPositionX(v:getPositionX() - self:getRollBgSpeed() * dt)

			if wordPs.x <= -100 then
				switchBg3 = v

				break
			end
		end

		if switchBg3 then
			local index = table.find(self._rollsfloorBg, switchBg3)

			if index then
				self._rollsfloorBg[#self._rollsfloorBg + 1] = self._rollsfloorBg[index]

				table.remove(self._rollsfloorBg, index)
				self:repositeBgs3()

				switchBg3 = nil
			end
		end
	end

	self._rollSchedule = self._rollSchedule or LuaScheduler:getInstance():schedule(rollFunc, 0.01, true)
end

function PlaneWarActivityMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._bagSystem = self._developSystem:getBagSystem()

	self:setupTopInfoWidget()
	super.enterWithData(self)
	self:initData(data)
	self:initNodes()
	self:createView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewByResChange)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_STAGE_PAUSE, self, self.popPauseView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_BUYTIMES_SCUESS, self, self.buyTimesScuess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_GAMEOVER, self, self.gameOver)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_BUYTIMESANDBEGIN_SCUESS, self, self.rStartGame)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_CLOSE, self, self.activityClose)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_REFRESH, self, self.refreshTimesView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MINIGAME_RESULT_SCUESS, self, self.gameOverByServerRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_RESTARTGAME, self, self.tryBeginGame)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_QUITGAME, self, self.quitGame)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLANEWAR_CONTINUEGAME, self, self.continueGame)
	self:rCreateGameView()
	self:createAnim()
	self:setPopPasueTip(true)
	self:repositeBgs1()
	self:repositeBgs2()
	self:repositeBgs3()
end

function PlaneWarActivityMediator:createAnim()
	if self._mainAnim then
		self._mainAnim:gotoAndPlay(0)

		return
	end

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local safeAreaInset = director:getOpenGLView():getSafeAreaInset()
	local offX = (winSize.width - safeAreaInset.left - safeAreaInset.right - self:getMainPanel():getContentSize().width) / 2
	local offY = (winSize.height - self:getMainPanel():getContentSize().height) / 2

	self._mainAnim = cc.MovieClip:create("kaishi_feijitiaozhan")

	self._mainAnim:addEndCallback(function(fid)
		self._mainAnim:stop()
		self._mainAnim:removeCallback(fid)
	end)
	self._mainAnim:addCallbackAtFrame(15, function()
		local scriptNames = "ministory_3a"
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local storyAgent = storyDirector:getStoryAgent()

		storyAgent:setSkipCheckSave(false)

		local guideSaved = storyAgent:isSaved(scriptNames)

		if not guideSaved then
			storyAgent:trigger(scriptNames)
		end

		AudioEngine:getInstance():playBackgroundMusic("Mus_Game_Fly")
	end)
	self._mainAnim:addTo(self:getView(), 99):center(self:getView():getContentSize())

	local roleAnim = self._mainAnim:getChildByName("role")
	local descAnim = self._mainAnim:getChildByName("desc")

	self._descLabel:removeFromParent(false)
	self._descLabel:addTo(descAnim):center(descAnim:getContentSize())

	local btnAnim = self._mainAnim:getChildByName("start")

	self._beginBtn:removeFromParent(false)
	self._beginBtn:addTo(btnAnim):center(btnAnim:getContentSize())

	local cishu = self._mainAnim:getChildByName("cishu")

	self._timesNode:removeFromParent(false)
	self._timesNode:addTo(cishu):center(cishu:getContentSize())

	local img, path, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
		id = "Model_SDTZi",
		useAnim = true,
		frameId = "bustframe9"
	})

	img:setScale(0.6)
	img:addTo(roleAnim)

	local redPoint = RedPoint:new(RedPoint:createDefaultNode(), self._rewardBtn, function()
		return self._planeWarActivity:hasRewardRedPoint()
	end)

	redPoint:offset(-10, -6)
end

function PlaneWarActivityMediator:initData(data)
	super.initData(self, data)

	self._planeWarSystem = self:getPlaneWarSystem()
	self._planeWarActivity = self._planeWarSystem:getPlaneWarActivity()
end

function PlaneWarActivityMediator:initNodes()
	super.initNodes(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._timePanel = self:getView():getChildByFullName("timepanel")

	self._timePanel:setLocalZOrder(10)

	self._bottomNode = self:getView():getChildByFullName("bottomnode")

	self._bottomNode:setLocalZOrder(10)

	self._topNode = self:getView():getChildByFullName("topmnode")

	self._topNode:setLocalZOrder(10)
	GameStyle:setTabPressTextEffect(self._topNode:getChildByFullName("scorelabel2"))

	self._timesNode = self:getMainPanel():getChildByFullName("timesnode")

	self._timesNode:setLocalZOrder(10)

	self._descLabel = self:getMainPanel():getChildByFullName("desclabel")
	self._beginBtn = self:getMainPanel():getChildByFullName("beginbtn")
	self._addBtn = self._timesNode:getChildByFullName("addbtn")

	self._addBtn:addTouchEventListener(function(sender, eventType)
		self:onClickAddTimes(sender, eventType, viewType)
	end)

	self._ruleBtn = self:getView():getChildByFullName("bottomnode.rulebtn")
	self._rewardBtn = self:getView():getChildByFullName("bottomnode.rewardbtn")
	self._rankBtn = self:getView():getChildByFullName("bottomnode.rankbtn")
	self._backImg = self:getView():getChildByFullName("bgmain")

	self._addBtn:setTouchEnabled(true)

	self._timeNode = self:getView():getChildByName("datebg")

	local text = self._timeNode:getChildByName("date")
	local startDate = TimeUtil:localDate("%Y.%m.%d", self._activity:getStartTime() / 1000)
	local endDate = TimeUtil:localDate("%Y.%m.%d", self._activity:getEndTime() / 1000)

	text:setString(startDate .. "-" .. endDate)
end

function PlaneWarActivityMediator:setupTopInfoWidget()
	self._topInfoNode = self:getView():getChildByFullName("topinfo_node")

	local config = {
		title = "",
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(self._topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function PlaneWarActivityMediator:createView()
	self._timesNode:setVisible(true)
	self:refreshTimesView()
	self:refreshRewardView()
end

function PlaneWarActivityMediator:refreshTimesView()
	self._descLabel:setString(self._planeWarActivity:getGameDecs())

	local timesTitle = self._timesNode:getChildByFullName("timelabel1")

	timesTitle:setString(Strings:get("Shop_Text11"))

	local timesLabel = self._timesNode:getChildByFullName("timelabel2")

	timesLabel:setString(self._planeWarActivity:getCurTimes() .. "/" .. self._planeWarActivity:getAllTimes())
	timesLabel:setColor(self._planeWarActivity:getCurTimes() > 0 and cc.c3b(71, 255, 101) or cc.c3b(255, 40, 40))
	self._beginBtn:setGray(self._planeWarActivity:getCurTimes() == 0)
	self._addBtn:setGray(not self._planeWarActivity:canBuyTimes())
	self._addBtn:setVisible(self._planeWarActivity:getCurTimes() == 0)
end

function PlaneWarActivityMediator:refreshRewardView()
	do return end

	local scoreLabel = self._topNode:getChildByFullName("scorelabel2")

	scoreLabel:setString(self._planeWarActivity:getHightScore())

	local rewardParent = self._topNode:getChildByFullName("bgimg")

	rewardParent:removeAllChildren(true)

	local rewardLabel = self._topNode:getChildByFullName("rewardlabel")
	local rewardList = self._planeWarActivity:getRewardList()

	rewardLabel:setVisible(table.nums(rewardList) > 0)

	local width = 175
	local posY = 10
	local list = {}

	if rewardList[CurrencyIdKind.kDiamond] then
		local amount = rewardList[CurrencyIdKind.kDiamond]

		list[#list + 1] = {
			id = CurrencyIdKind.kDiamond,
			amount = amount
		}
	end

	for id, amount in pairs(rewardList) do
		if id ~= CurrencyIdKind.kDiamond and id ~= CurrencyIdKind.kGold then
			list[#list + 1] = {
				id = id,
				amount = amount
			}
		end
	end

	if rewardList[CurrencyIdKind.kGold] then
		local amount = rewardList[CurrencyIdKind.kGold]

		list[#list + 1] = {
			id = CurrencyIdKind.kGold,
			amount = amount
		}
	end

	for i = 1, #list do
		local amount = list[i].amount
		local icon = IconFactory:createIcon(list[i])

		icon:getAmountNode():setVisible(false)
		icon:setScale(0.3)
		icon:setAnchorPoint(cc.p(0, 0))
		icon:addTo(rewardParent):posite(width, posY)

		width = width + 40

		local label = cc.Label:createWithTTF("", DEFAULT_TTF_FONT, 20)

		label:setAnchorPoint(cc.p(0, 0.5))
		label:setString("x" .. tostring(amount))
		label:addTo(rewardParent):posite(width, 15 + posY)

		width = width + label:getContentSize().width + 16
	end
end

function PlaneWarActivityMediator:beginGame()
	self._preHightScore = self._planeWarActivity:getHighestScore()

	self:offSetViewPos(true)
	self:startRollBg()
	self:setRollBgSpeed(20)
	self:runSleepAnim(function()
		self:setRollBgSpeed(150)
		self:runGame()
		self:setPopPasueTip(false)
	end)
end

function PlaneWarActivityMediator:offSetViewPos(isAdd)
	local factor = isAdd and 1 or -1

	self._mainAnim:setVisible(isAdd ~= true)
	self._backImg:setVisible(isAdd ~= true)

	local actionTime = 0.4
	local offSetY = 110

	self._topInfoNode:runAction(cc.MoveBy:create(actionTime, cc.p(0, offSetY * factor + 70 * factor)))

	local actionTime = 0.2
	local offSetY = -300

	self._ruleBtn:runAction(cc.MoveBy:create(actionTime, cc.p(0, offSetY * factor + 70 * factor)))
	self._rewardBtn:runAction(cc.MoveBy:create(actionTime, cc.p(0, offSetY * factor + 70 * factor)))
	self._rankBtn:runAction(cc.MoveBy:create(actionTime, cc.p(0, offSetY * factor + 70 * factor)))
	self._timeNode:runAction(cc.MoveBy:create(actionTime, cc.p(0, offSetY * factor + 70 * factor)))
end

function PlaneWarActivityMediator:tryBeginGame()
	if self._planeWarActivity:getCurTimes() == 0 then
		local factor1 = self._planeWarActivity:getCurTimes() == 0
		local factor2 = self._planeWarActivity:getBuyTimes() >= self._planeWarActivity:getLimitBuyTimes()

		if factor1 and factor2 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_Darts_Text2")
			}))

			return
		end

		local buytimes = self._planeWarActivity:getBuyTimes()
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				if not outSelf._bagSystem:checkCostEnough(outSelf._planeWarSystem:getBuyCostItemId(), outSelf._planeWarSystem:getCostBuyTimes(buytimes + 1), {
					type = "tip"
				}) then
					return
				end

				outSelf._miniGameSystem:requestActivityGameBuyTimes(outSelf._activityId)
			end
		end

		local data = {
			isRich = true,
			title = Strings:get("MiniGame_BuyTimes_UI1"),
			title1 = Strings:get("MiniGame_BuyTimes_UI2"),
			content = Strings:get("Activity_Darts_UI_16", {
				fontName = TTF_FONT_FZYH_R,
				num = self._planeWarSystem:getCostBuyTimes(buytimes + 1),
				count = self._planeWarSystem:getEachBuyNum()
			}),
			sureBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))

		return
	end

	self._miniGameSystem:requestActivityGameBegin(self._planeWarActivity:getId(), function()
		self:refreshTimesView()
		self:beginGame()
	end)
end

function PlaneWarActivityMediator:onClickRule()
	local rewardList = self._activity:getActivityConfig().maxReward
	local strList = {}

	for i, v in pairs(rewardList) do
		local name = RewardSystem:getName(v)

		strList[#strList + 1] = Strings:get("Activity_Darts_UI_30", {
			name = name,
			num = v.amount
		})
	end

	local rewardStr = ""

	rewardStr = rewardStr .. table.concat(strList, "、")

	local ruleList = self._activity:getRuleDesc()
	local ruleData = {
		{
			Desc = ruleList
		}
	}
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = ruleData,
		ruleReplaceInfo = {
			value = rewardStr,
			time = TimeUtil:getSystemResetDate()
		}
	}))
end

function PlaneWarActivityMediator:onClickRank()
	print(RankType.KPlane, self._activityId)
	self._miniGameSystem:requestActivityRankData(RankType.KPlane, self._activityId, 1, 20, function()
		local view = self:getInjector():getInstance("MiniGameRankView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			type = MiniGameType.KPlane,
			evn = MiniGameEvn.kActivity,
			activityId = self._activityId,
			rankNum = self._activity:getActivityConfig().maximumShow,
			rankType = RankType.KPlane
		}, nil))
	end)
end

function PlaneWarActivityMediator:onClickReward()
	local view = self:getInjector():getInstance("MiniGameRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activityId = self._activityId
	}, nil))
end

function PlaneWarActivityMediator:onClickBegin(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if self._planeWarActivity:isLimitReward() then
			local popupDelegate, outSelf = {}, self

			function popupDelegate:onContinue(dialog)
				outSelf:tryBeginGame()
			end

			function popupDelegate:onLeave(dialog)
				return
			end

			local view = outSelf:getInjector():getInstance("PlaneWarActivityLimitTipView")

			outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 156,
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				cost = self._planeWarActivity:getCost(),
				activityId = self._planeWarActivity:getId()
			}, popupDelegate))

			return
		end

		self:tryBeginGame()
	end
end

function PlaneWarActivityMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()
	end
end

function PlaneWarActivityMediator:onClickAddTimes(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local factor1 = self._planeWarActivity:getCurTimes() == 0
		local factor2 = self._planeWarActivity:getBuyTimes() >= self._planeWarActivity:getLimitBuyTimes()

		if factor1 and factor2 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_Darts_Text2")
			}))

			return
		end

		self:buyTimes()
	end
end

function PlaneWarActivityMediator:buyTimes()
	local buytimes = self._planeWarActivity:getBuyTimes()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			if not outSelf._bagSystem:checkCostEnough(outSelf._planeWarSystem:getBuyCostItemId(), outSelf._planeWarSystem:getCostBuyTimes(buytimes + 1), {
				type = "tip"
			}) then
				return
			end

			outSelf._miniGameSystem:requestActivityGameBuyTimes(outSelf._activityId)
		end
	end

	local data = {
		isRich = true,
		title = Strings:get("MiniGame_BuyTimes_UI1"),
		title1 = Strings:get("MiniGame_BuyTimes_UI2"),
		content = Strings:get("Activity_Darts_UI_16", {
			fontName = TTF_FONT_FZYH_R,
			num = self._planeWarSystem:getCostBuyTimes(buytimes + 1),
			count = self._planeWarSystem:getEachBuyNum()
		}),
		sureBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function PlaneWarActivityMediator:popPauseView(event)
	local rewardList = event:getData().rewards
	local list = {}

	for k, v in pairs(rewardList) do
		list[#list + 1] = {
			id = v.code,
			num = v.amount
		}
	end

	local data = {}

	data.reward = list
	data.eventconfirm = EVT_PLANEWAR_QUITGAME
	data.eventback = EVT_PLANEWAR_CONTINUEGAME

	self:setRollBgSpeed(0)

	local view = self:getInjector():getInstance("MiniGameQuitConfirmView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data))
end

function PlaneWarActivityMediator:continueGame()
	if self:isGameOver() then
		self:setPopPasueTip(true)
		self:setRollBgSpeed(150)
		self:rCreateGame()

		return
	end

	self:runSleepAnim(function()
		self:setRollBgSpeed(150)
		self:resume()
	end)
	self:dispatch(Event:new(EVT_PLANEWAR_PAUSETIP_CLOSE))
end

function PlaneWarActivityMediator:quitGame()
	return
end

function PlaneWarActivityMediator:buyTimesScuess(event)
	self:refreshTimesView()
end

function PlaneWarActivityMediator:activityClose(event)
	local data = event:getData()

	if data.activityId == self._planeWarActivity:getId() then
		self:dismiss()
	end
end

function PlaneWarActivityMediator:refreshViewByResChange(event)
	self:refreshTimesView()
end

function PlaneWarActivityMediator:gameOverByServerRefresh(event)
	local response = event:getData().response

	if response and self._gameOverParams then
		if not response.data.score then
			local gameScore = 0
			local data = {
				isWin = true,
				modelId = "Model_SDTZi",
				isGetRewardLimit = false,
				score = gameScore,
				highscore = self._preHightScore,
				todaytimes = self._activity:getGameTimes(),
				totaltimes = self._activity:getDailyGameTimes(),
				isHightScore = gameScore > self._preHightScore,
				buytimes = self._planeWarActivity:getBuyTimes(),
				buymaxtimes = self._planeWarActivity:getLimitBuyTimes(),
				eachbuynum = self._planeWarSystem:getEachBuyNum(),
				amountlist = self._planeWarSystem:getCost(),
				costid = self._planeWarSystem:getBuyCostItemId(),
				activityId = self._activityId,
				event = EVT_PLANEWAR_RESTARTGAME
			}
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				if data and data.rStartGame then
					-- block empty
				else
					outSelf:rCreateGameView()
					outSelf:offSetViewPos()
					outSelf:refreshRewardView()
				end
			end

			data.rewards = response.data.rewards or {}
			data.highscore = self._activity:getHighestScore()

			local view = self:getInjector():getInstance("MiniGameResultView")

			self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {}, data, delegate))
		end
	else
		self:dismiss()
	end
end

function PlaneWarActivityMediator:gameOver(event)
	self:setPopPasueTip(true)

	local params = event:getData()

	self._gameOverParams = params

	self._miniGameSystem:requestActivityGameResult(self._planeWarActivity:getId(), params)
end

function PlaneWarActivityMediator:rStartGame(event)
	self:rCreateGameView()
	self:runSleepAnim(function()
		self:runGame()
		self:setPopPasueTip(false)
	end)
end
