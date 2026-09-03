-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/worldBoss/WorldBossMediator.lua

WorldBossMediator = class("WorldBossMediator", DmAreaViewMediator, _M)

WorldBossMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
WorldBossMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WorldBossMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {
	["main.ScrollView.panel.btn_rank"] = {
		ignoreClickAudio = true,
		func = "onClickRank"
	},
	["main.ScrollView.panel.btn_reward"] = {
		ignoreClickAudio = true,
		func = "onClickReward"
	},
	["main.ScrollView.panel.btn_vanguard"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickVanguard"
	},
	["main.ScrollView.panel.btn_boss"] = {
		ignoreClickAudio = true,
		func = "onClickBoss"
	},
	["main.ScrollView.panel.buff"] = {
		ignoreClickAudio = true,
		func = "onClickBuff"
	},
	["main.btn_rule"] = {
		ignoreClickAudio = true,
		func = "onClickRule"
	}
}

function WorldBossMediator:initialize()
	super.initialize(self)
end

function WorldBossMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function WorldBossMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function WorldBossMediator:onRegister()
	super.onRegister(self)
	self:setupTopInfoWidget()

	self._main = self:getView():getChildByName("main")
	self._scrollView = self._main:getChildByFullName("ScrollView")
	self._touchPanel = self:getView():getChildByName("Panel_touch")
end

function WorldBossMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function WorldBossMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self._buffList = self._activity:getBuffOpenTime()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:updateInfoWidget()
	self:mapEventListeners()
	self:setupView()
	self:playBackgroundMusic()
	self:refreshRedPoint()
	self:showFirstAnim()
	self:initTimer()
	self:addRole()
end

function WorldBossMediator:resumeWithData(data)
	super.resumeWithData(self, data)
	self:doReset()
end

function WorldBossMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_REDPOINT_REFRESH, self, self.refreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.doReset)
end

function WorldBossMediator:playBackgroundMusic()
	local bgm = self._activity:getBgm()

	AudioEngine:getInstance():playBackgroundMusic(bgm)
end

function WorldBossMediator:doReset()
	self:stopTimer()

	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return true
	end

	self:initTimer()
	self:refreshRedPoint()

	return false
end

function WorldBossMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function WorldBossMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local config = {
		style = 1,
		currencyInfo = self._activity:getResourcesBanner(),
		title = Strings:get(self._activity:getTitle())
	}

	self._topInfoWidget:updateView(config)
end

function WorldBossMediator:setupView()
	local winSize = cc.Director:getInstance():getWinSize()

	self._scrollView:setContentSize(cc.size(winSize.width, 852))
	self._scrollView:setInnerContainerSize(cc.size(2073, 852))
	AdjustUtils.adjustLayoutByType(self._scrollView, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(self._scrollView, AdjustUtils.kAdjustType.Left)
	AdjustUtils.adjustLayoutByType(self._main:getChildByName("btn_rule"), AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Top)
	AdjustUtils.adjustLayoutByType(self._main:getChildByName("node_time"), AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Top)
	self._scrollView:setInnerContainerPosition(cc.p(0, 0))

	self._buffPanel = self._scrollView:getChildByFullName("panel.buff")

	local vanguardBtn = self._scrollView:getChildByFullName("panel.btn_vanguard")
	local role = RoleFactory:createHeroAnimation("Model_Enemy_JSJJu", "stand")

	role:addTo(vanguardBtn, -1):posite(170, 30):setScale(1.2)
	role:setScaleX(-1.2)

	local playerName = self._scrollView:getChildByFullName("panel.btn_boss.Text_player")

	if self._activity:getPreNickname() and self._activity:getPreNickname() ~= "" then
		playerName:setString(self._activity:getPreNickname())
	else
		playerName:setString(Strings:get("Activity_WorldBoss_Boss_Initial_Name"))
	end
end

function WorldBossMediator:instantiateBuildingHero(node)
	return self:getInjector():instantiate("WorldBossHero", {
		view = node
	})
end

local posList = {
	cc.p(150, 120),
	cc.p(150, 30),
	cc.p(690, 120),
	cc.p(690, 30),
	cc.p(1050, 120),
	cc.p(1050, 30),
	cc.p(1630, 120),
	cc.p(1630, 30)
}

function WorldBossMediator:addRole()
	self._heroList = {}

	local panel = self._scrollView:getChildByFullName("panel")
	local roleList = self._activity:getMoveRoles()

	if not next(roleList) then
		return
	end

	local random = math.random(1, #roleList)

	local function hasHero(index)
		for i, hero in pairs(self._heroList) do
			local posIndex = hero:getPosIndex()

			if index == posIndex then
				return true
			end
		end
	end

	local function getCreatePosIndex()
		local list = {}

		for i, v in pairs(posList) do
			if not hasHero(i) and i ~= self._oldPos then
				list[#list + 1] = v
			end
		end

		local random = math.random(1, #list)

		for k, v in pairs(posList) do
			if v.x == list[random].x and v.y == list[random].y then
				return k
			end
		end
	end

	local function createRole(index, posIndex)
		local roleInfo = roleList[index]

		if roleInfo then
			local node = cc.Node:create():addTo(panel)
			local buildingHero = self:instantiateBuildingHero(node)

			node.__mediator = buildingHero

			buildingHero:setHeroInfo(roleInfo, self)

			self._heroList[roleInfo:getRid()] = buildingHero

			local createPos = posIndex or getCreatePosIndex()

			self._oldPos = createPos

			buildingHero:enterWithData(createPos)
		end
	end

	local function getRoleIndex()
		local random = math.random(1, #roleList)
		local roleInfo = roleList[random]

		if table.nums(self._heroList) >= #roleList then
			return 0
		end

		if self._heroList[roleInfo:getRid()] == nil then
			return random
		else
			return getRoleIndex()
		end
	end

	local spwanSec = ConfigReader:getDataByNameIdAndKey("ConfigValue", "WorldBoss_ModelSpwanSec", "content")

	local function action()
		local delay = cc.DelayTime:create(spwanSec)
		local call = cc.CallFunc:create(function()
			local roleIndex = getRoleIndex()

			if roleIndex > 0 then
				createRole(roleIndex)
				action()
			end
		end)

		self:getView():runAction(cc.Sequence:create(delay, call))
	end

	local createPos = math.random(1, #posList)

	self._oldPos = createPos

	createRole(random, createPos)
	action()
end

function WorldBossMediator:hasHeroStay(posIndex)
	for i, v in pairs(self._heroList) do
		if posIndex == v:getPosIndex() then
			return true
		end
	end

	return false
end

function WorldBossMediator:initTimer()
	local timeText = self._main:getChildByFullName("node_time.Text_time")

	local function checkTimeFunc()
		local curTime = self._gameServerAgent:remoteTimestamp()

		self._main:getChildByFullName("node_time"):setVisible(true)

		local isVanguardOpen = self._activity:isPointCanChallenge(WorldBossPointType.kVanguard)

		if isVanguardOpen then
			local ts = self._activity:getPointOpenTime(WorldBossPointType.kVanguard)
			local remainTime = ts.endTime - curTime

			timeText:setString(TimeUtil:formatTime(Strings:get("Activity_WorldBoss_Vanguard_Limit"), remainTime))
		else
			local ts = self._activity:getPointOpenTime(WorldBossPointType.kBoss)
			local isBossOpen = self._activity:isPointCanChallenge(WorldBossPointType.kBoss)

			if isBossOpen then
				local remainTime = ts.endTime - curTime

				timeText:setString(TimeUtil:formatTime(Strings:get("Activity_WorldBoss_Boss_Limit"), remainTime))
			elseif curTime < ts.startTime then
				local remainTime = ts.startTime - curTime

				timeText:setString(TimeUtil:formatTime(Strings:get("Activity_WorldBoss_Boss_Limit_1"), remainTime))
			else
				self._main:getChildByFullName("node_time"):setVisible(false)
			end
		end

		local hasBuff = false

		for i, v in pairs(self._buffList) do
			if curTime > v.startTime and curTime < v.endTime and self._activity:isPointCanChallenge(v.pointType) then
				hasBuff = true
				self._buffIndex = i

				self._activity:setCurBuffIndex(self._buffIndex)

				break
			end
		end

		if not hasBuff then
			self._activity:setCurBuffIndex(0)
		end

		self._buffPanel:setVisible(hasBuff)

		local node = self._scrollView:getChildByFullName("panel.Image_60")

		node:setVisible(not hasBuff)
		self._buffAnim:setVisible(hasBuff)
	end

	self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

	checkTimeFunc()
end

function WorldBossMediator:refreshRedPoint()
	local btns = {
		"btn_rank",
		"btn_reward",
		"btn_vanguard",
		"btn_boss"
	}
	local redFunc = {
		function()
			return false
		end,
		function()
			return self._activity:hasRewardToGet()
		end,
		function()
			return self._activity:isPointCanChallenge(WorldBossPointType.kVanguard) and self._activity:getFightVanguardTimes() > 0
		end,
		function()
			return self._activity:isPointCanChallenge(WorldBossPointType.kBoss) and self._activity:getFightBossTimes() > 0
		end
	}

	for i, name in pairs(btns) do
		local btn = self._main:getChildByFullName("ScrollView.panel." .. name)
		local redPoint = btn:getChildByName("redPoint")

		redPoint:setVisible(redFunc[i]())
	end
end

function WorldBossMediator:showFirstAnim()
	self._scrollView:jumpToPercentHorizontal(50)

	local anim = cc.MovieClip:create("yinhua_bingshuanglingyujiemian")

	self._scrollView:getChildByFullName("panel.Image_bg"):setLocalZOrder(-2)

	local node = self._scrollView:getChildByFullName("panel.Image_60")

	anim:addTo(node:getParent(), -1):posite(node:getPosition()):offset(154, 49)
	anim:setScale(1.45)
	anim:addEndCallback(function()
		anim:stop()
	end)

	self._buffAnim = anim

	local customDataSystem = self:getInjector():getInstance("CustomDataSystem")
	local customKey = "Guide" .. self._activity:getId()
	local customValue = customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if customValue then
		self._touchPanel:setVisible(false)

		return
	end

	self._touchPanel:setVisible(true)
	customDataSystem:setValue(PrefixType.kGlobal, customKey, true)

	local function endCallBack()
		local action1 = cc.DelayTime:create(0.3)
		local action2 = cc.CallFunc:create(function()
			self._scrollView:scrollToRight(1.5, true)
		end)
		local action3 = cc.DelayTime:create(1.5)
		local action4 = cc.CallFunc:create(function()
			self._scrollView:scrollToLeft(1.5, true)
		end)
		local action5 = cc.DelayTime:create(1.5)
		local action6 = cc.CallFunc:create(function()
			self._scrollView:scrollToPercentHorizontal(50, 1, true)
			self._touchPanel:setVisible(false)
		end)

		self._main:runAction(cc.Sequence:create(action1, action2, action3, action4, action5, action6))
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()
	local storyLink = "guide_minigame_WorldBoss"

	storyAgent:trigger(storyLink, function()
		return
	end, endCallBack)
end

function WorldBossMediator:buyTimes(pointType)
	local cost = self._activity:getCostBuyTimes(pointType)
	local bagSystem = self._developSystem:getBagSystem()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			if not bagSystem:checkCostEnough(cost.id, cost.amount, {
				type = "tip"
			}) then
				return
			end

			outSelf._activitySystem:requestDoActivity(outSelf._activityId, {
				doActivityType = 106,
				pointType = pointType
			}, function()
				if not checkDependInstance(outSelf) then
					return
				end

				outSelf:refreshRedPoint()

				local view = outSelf:getInjector():getInstance("WorldBossDetailView")

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, {
					activityId = outSelf._activityId,
					pointType = pointType
				}))
			end)
		end
	end

	local data = {
		isRich = true,
		title = Strings:get("MiniGame_BuyTimes_UI1"),
		content = Strings:get("WorldBoss_Buy", {
			fontName = TTF_FONT_FZYH_R,
			num = cost.amount,
			count = cost.eachBuyNum
		}),
		sureBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function WorldBossMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()
	end
end

function WorldBossMediator:onClickBoss()
	local isOpen = self._activity:isPointCanChallenge(WorldBossPointType.kBoss)

	if not isOpen then
		local ts = self._activity:getPointOpenTime(WorldBossPointType.kBoss)
		local curTime = self._gameServerAgent:remoteTimestamp()

		if curTime < ts.startTime then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_WorldBoss_Tip4")
			}))
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_WorldBoss_Tip7")
			}))
		end

		return
	end

	local isFightBoss = self._activity:getIsFightBoss()

	if not isFightBoss then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Activity_WorldBoss_Tip5")
		}))

		return
	end

	if self._activity:getFightBossTimes() == 0 then
		if self._activity:isCanBuyTimes(WorldBossPointType.kBoss) then
			self:buyTimes(WorldBossPointType.kBoss)
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_WorldBoss_Tip3")
			}))
		end

		return
	end

	local view = self:getInjector():getInstance("WorldBossDetailView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, {
		pointType = 2,
		activityId = self._activityId
	}))
end

function WorldBossMediator:onClickVanguard()
	local isOpen = self._activity:isPointCanChallenge(WorldBossPointType.kVanguard)

	if not isOpen then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Activity_WorldBoss_Tip6")
		}))

		return
	end

	if self._activity:getFightVanguardTimes() == 0 then
		if self._activity:isCanBuyTimes(WorldBossPointType.kVanguard) then
			self:buyTimes(WorldBossPointType.kVanguard)
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Activity_WorldBoss_Tip3")
			}))
		end

		return
	end

	local view = self:getInjector():getInstance("WorldBossDetailView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, {
		pointType = 1,
		activityId = self._activityId
	}))
end

function WorldBossMediator:onClickReward()
	local view = self:getInjector():getInstance("WorldBossRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activityId = self._activityId
	}))
end

function WorldBossMediator:onClickRank()
	local view = self:getInjector():getInstance("WorldBossRankView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activityId = self._activityId
	}, nil))
end

function WorldBossMediator:onClickRule()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._activity:getRuleDesc()
	local params = {
		time = TimeUtil:getSystemResetDate()
	}

	self._activitySystem:showActivityRules(rules, nil, params)
end

function WorldBossMediator:onClickBuff()
	local view = self:getInjector():getInstance("WorldBossBuffView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activityId = self._activityId,
		buffData = self._buffList[self._buffIndex],
		nextBuffData = self._buffList[self._buffIndex + 1]
	}))
end
