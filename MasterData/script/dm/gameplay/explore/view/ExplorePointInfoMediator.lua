-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExplorePointInfoMediator.lua

ExplorePointInfoMediator = class("ExplorePointInfoMediator", DmPopupViewMediator, _M)

ExplorePointInfoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExplorePointInfoMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExplorePointInfoMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local MapPointAutoTips = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MapPointAutoTips", "content")
local kBtnHandlers = {
	tipBtn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickTip"
	},
	["main.leftPanel.enterBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickEnter"
	},
	["main.leftPanel.quickBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickQuickBtn"
	},
	["main.leftPanel.strategyBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickStrategy"
	}
}

function ExplorePointInfoMediator:initialize()
	super.initialize(self)
end

function ExplorePointInfoMediator:dispose()
	super.dispose(self)
end

function ExplorePointInfoMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_RESET_MAPCOUNT, self, self.updateView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateView)
end

function ExplorePointInfoMediator:enterWithData(data)
	self._pointId = data.pointId
	self._data = data
	self._pointData = self._exploreSystem:getMapPointObjById(self._pointId)
	self._taskData = self._pointData:getMainTask()

	self:initView()
	self:initLeftPanel()
	self:setupClickEnvs()
end

function ExplorePointInfoMediator:initView()
	self._main = self:getView():getChildByName("main")
	self._leftPanel = self._main:getChildByName("leftPanel")
	self._heroInfoPanel = self._main:getChildByName("heroTipPanel")

	self._heroInfoPanel:setVisible(false)

	self._quickBtn = self._leftPanel:getChildByName("quickBtn")
	self._autoBtn = self._leftPanel:getChildByName("autoBtn")

	self._autoBtn:addClickEventListener(function()
		self:onClickAuto()
	end)

	local enterBtn = self._leftPanel:getChildByFullName("enterBtn")
	local anim = cc.MovieClip:create("tiaozhankuanghebinb_zhuxianguanka_UIjiaohudongxiao")

	anim:addEndCallback(function()
		anim:stop()
	end)
	anim:gotoAndPlay(25)
	anim:addTo(enterBtn):center(enterBtn:getContentSize()):offset(-440, 30)
	GameStyle:setCommonOutlineEffect(self._autoBtn:getChildByFullName("text"))
	GameStyle:setCommonOutlineEffect(self._leftPanel:getChildByName("text1"))
	GameStyle:setCommonOutlineEffect(self._leftPanel:getChildByName("text2"))
	GameStyle:setCommonOutlineEffect(self._leftPanel:getChildByName("text3"))
	GameStyle:setCommonOutlineEffect(self:getView():getChildByFullName("exploreTimesPanel.text"), 127.5)
	GameStyle:setCommonOutlineEffect(self:getView():getChildByFullName("exploreTimesPanel.times"), 127.5)
	self._leftPanel:getChildByFullName("text3.Image_3"):setVisible(false)
	self:setupTopInfoWidget()
	self:updateDailyRewardTimes()
	self:initHeroIcon()
end

function ExplorePointInfoMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kPower
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local tipBtn = self:getView():getChildByFullName("tipBtn")

	tipBtn:setPositionX(self._topInfoWidget:getTitleWidth() + 25)
end

function ExplorePointInfoMediator:updateDailyRewardTimes()
	local dailyRewardPanel = self:getView():getChildByFullName("dailyRewardPanel")
	local times = self._exploreSystem:getDailyRecommendTimes()
	local mapDailyRewardTime = self._exploreSystem:getMapDailyRewardTime()
	local textLabel = dailyRewardPanel:getChildByFullName("text")
	local timeLabel = dailyRewardPanel:getChildByFullName("times")

	timeLabel:setString(times .. "/" .. mapDailyRewardTime)
	textLabel:setPositionX(timeLabel:getPositionX() - timeLabel:getContentSize().width - 5)
	textLabel:disableEffect(1)
	timeLabel:disableEffect(1)

	if times <= 0 then
		textLabel:setTextColor(cc.c3b(255, 255, 255))
		timeLabel:setTextColor(cc.c3b(255, 255, 255))
		textLabel:enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
		timeLabel:enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
	else
		textLabel:setTextColor(cc.c3b(186, 238, 22))
		timeLabel:setTextColor(cc.c3b(186, 238, 22))
		textLabel:enableOutline(cc.c4b(0, 0, 0, 153), 1)
		timeLabel:enableOutline(cc.c4b(0, 0, 0, 153), 1)
	end

	local exploreTimesPanel = self:getView():getChildByFullName("exploreTimesPanel")
	local times = self._exploreSystem:getEnterTimes()
	local enterTotalTimes = self._exploreSystem:getEnterTotalTimes()
	local textLabel = exploreTimesPanel:getChildByFullName("text")
	local timeLabel = exploreTimesPanel:getChildByFullName("times")

	timeLabel:setString(times .. "/" .. enterTotalTimes)
	textLabel:setPositionX(timeLabel:getPositionX() - timeLabel:getContentSize().width - 5)

	if getCurrentLanguage() ~= GameLanguageType.CN then
		exploreTimesPanel:setPositionX(600)
	end

	local canAuto, tip = self._exploreSystem:canAuto(self._pointData)
	local autoState = self._pointData:getAutoState()

	self._autoBtn:getChildByFullName("lock"):setVisible(not canAuto)
	self._quickBtn:setVisible(canAuto)

	local color = cc.c3b(195, 195, 195)

	if canAuto then
		if autoState then
			color = cc.c3b(255, 255, 255)
		end
	else
		self._pointData:setAutoState(false)
	end

	self._autoBtn:getChildByFullName("text"):setColor(color)
	self._autoBtn:getChildByFullName("auto"):setVisible(canAuto and autoState)

	local bgFile = canAuto and autoState and "ts_bg_d01.png" or "ts_bg_d02.png"

	self._autoBtn:getChildByFullName("bg"):loadTexture(bgFile, 1)
	self._exploreSystem:setAutoBattleStatus(canAuto and autoState)
end

function ExplorePointInfoMediator:initHeroIcon()
	local heroIcon = self._main:getChildByFullName("heroIcon")

	heroIcon:removeAllChildren()

	local id = self._pointData:getPointHead()
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", id)
	local hero = self._heroSystem:getHeroById(id)
	local img = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = (hero or nil) and hero:getModel()
	})

	heroIcon:addChild(img)
	img:setPosition(cc.p(90, -80))
end

function ExplorePointInfoMediator:updateData()
	self._pointData = self._exploreSystem:getMapPointObjById(self._pointId)
	self._taskData = self._pointData:getMainTask()
end

function ExplorePointInfoMediator:updateView()
	self:initLeftPanel()
	self:updateDailyRewardTimes()
	self._leftPanel:getChildByFullName("enterBtn"):setGray(self._pointData:getLock())
end

function ExplorePointInfoMediator:initLeftPanel()
	local recommendTip = self._leftPanel:getChildByFullName("recommendTip")
	local title = self._leftPanel:getChildByName("title")

	title:setString(self._pointData:getName())
	GameStyle:setCommonOutlineEffect(title)
	recommendTip:setPositionX(title:getPositionX() + title:getContentSize().width)

	local level = self._leftPanel:getChildByFullName("Panel_combat.combat_text")

	level:setString(self._pointData:getRecommendLv())

	local desc = self._leftPanel:getChildByName("desc")

	desc:setString(self._pointData:getDesc())
	GameStyle:setCommonOutlineEffect(desc)

	local targetDesc = self._leftPanel:getChildByName("targetDesc")

	if self._taskData:getDesc() ~= "" then
		local var_13_0 = self._taskData:getDesc()

		if not var_13_0 then
			var_13_0 = self._exploreSystem:getTaskDescByCondition(self._taskData:getCondition())

			local str = var_13_0

			targetDesc:setString(str)

			local heroIds = self._pointData:getEffectHeroIds()
			local heroPanel = self._leftPanel:getChildByName("heroPanel")

			for i = 1, 4 do
				if heroIds[i] then
					local touchPanel = heroPanel:getChildByName("node_" .. i)

					touchPanel:removeAllChildren()

					local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroIds[i])
					local info = {
						id = heroIds[i],
						roleModel = roleModel
					}
					local petNode = IconFactory:createHeroLargeIcon(info, {
						hideAll = true
					})

					petNode:addTo(touchPanel):center(touchPanel:getContentSize()):offset(0, -4)
					petNode:setScale(0.4)
					touchPanel:setTouchEnabled(true)
					touchPanel:addTouchEventListener(function(sender, eventType)
						self:onClickHeroIcon(sender, eventType, heroIds[i], panel)
					end)
				end
			end

			local rewards = self._pointData:getShowReward()
			local text = self._leftPanel:getChildByFullName("rewardPanel.text")
			local bg = self._leftPanel:getChildByFullName("rewardPanel.bg")

			text:setString(Strings:get("EXPLORE_UI110"))
			GameStyle:setCommonOutlineEffect(text)

			local rewardPanel = self._leftPanel:getChildByFullName("rewardPanel.panel")

			rewardPanel:removeAllChildren()
			recommendTip:setVisible(false)
			bg:setVisible(false)

			if self._exploreSystem:isRecommendPoint(self._pointData:getWeekRecommend()) then
				text:setString(Strings:get("EXPLORE_UI97"))
				text:setColor(cc.c3b(250, 200, 124))

				rewards = self._pointData:getDailyRewardShow()

				recommendTip:setVisible(true)
				bg:setVisible(true)
			else
				text:setColor(cc.c3b(255, 255, 255))
			end

			local length = #rewards

			for i = 1, length do
				local rewardData = rewards[i]

				if rewardData then
					local posX = 67 + (i - 1) * 70
					local icon = IconFactory:createItemIcon({
						id = rewardData.itemId
					}, {
						showAmount = false,
						isWidget = true
					})
					local info = {
						amount = 1,
						code = rewardData.itemId,
						type = RewardType.kItem
					}

					IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), info, {
						showAmount = false,
						needDelay = true
					})
					icon:setScale(0.51)
					icon:setAnchorPoint(cc.p(1, 0.5))
					icon:addTo(rewardPanel)
					icon:setPosition(cc.p(posX, rewardPanel:getContentSize().height / 2))

					if rewardData.image and rewardData.image ~= "" then
						local image = ccui.ImageView:create(rewardData.image .. ".png", 1)

						image:setScale9Enabled(true)
						image:setCapInsets(cc.rect(17, 11, 10, 10))
						image:addTo(rewardPanel)
						image:setPosition(cc.p(posX - 27, 5))
						image:setScale(0.8)

						local text = cc.Label:createWithTTF(Strings:get(rewardData.text), TTF_FONT_FZYH_M, 17)

						text:addTo(image)
						text:setColor(cc.p(0, 0, 0))

						local width = 85
						local height = 36

						image:setContentSize(cc.size(width, height))
						text:setOverflow(cc.LabelOverflow.SHRINK)
						text:setDimensions(width - 5, 30)
						text:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
						text:setPosition(cc.p(width / 2 - 3, height / 2 + 4))
					end
				end
			end

			local costPower = self._pointData:getNeedPower()
			local timesRemain = self._leftPanel:getChildByName("timesRemain")

			timesRemain:setString("X" .. costPower)
			timesRemain:removeAllChildren()

			local icon = IconFactory:createResourcePic({
				id = CurrencyIdKind.kPower
			})

			icon:addTo(timesRemain):setScale(0.7)
			icon:setAnchorPoint(cc.p(0.5, 0.5))
			icon:setPosition(cc.p(-13, 12))
		end
	end
end

function ExplorePointInfoMediator:updateHeroInfo(heroId)
	local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(heroId)
	local heroConfig = heroPrototype:getConfig()
	local heroPanel = self._heroInfoPanel:getChildByName("iconBg")

	heroPanel:removeAllChildren()

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local info = {
		id = roleModel
	}
	local heroImg = IconFactory:createRoleIconSpriteNew(info)

	heroImg:addTo(heroPanel):center(heroPanel:getContentSize())

	local name = self._heroInfoPanel:getChildByName("name")

	name:setString(Strings:get(heroConfig.Name))

	local desc = self._heroInfoPanel:getChildByName("desc")

	desc:getVirtualRenderer():setLineHeight(26)
	desc:setString(Strings:get(heroConfig.Desc))

	local effectDesc = self._heroInfoPanel:getChildByName("effectDesc")

	effectDesc:setString("")
	effectDesc:removeAllChildren()

	local str = self._pointData:getEffectDescById(heroId, (self._heroSystem:hasHero(heroId) or nil) and self._heroSystem:getHeroById(heroId):getLevel())
	local descLabel = ccui.RichText:createWithXML(str, {})

	descLabel:setVerticalSpace(10)
	descLabel:renderContent(308, 0)
	descLabel:addTo(effectDesc, 1)
	descLabel:setAnchorPoint(cc.p(0, 1))
	descLabel:setPosition(cc.p(0, 100))
end

function ExplorePointInfoMediator:enterMapByKeyA(key)
	self._exploreSystem:enterMapById(function(data)
		local view = self:getInjector():getInstance("ExploreMapView")
		local event = ViewEvent:new(EVT_SWITCH_VIEW, view, nil, {
			pointId = data.data.id
		})

		self:dispatch(event)
		self:close()
	end, {
		pointId = key
	}, true)
end

function ExplorePointInfoMediator:onClickBack()
	self:close()
end

function ExplorePointInfoMediator:onClickPoint(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local data = sender.data

		self._pointId = data:getId()

		self:updateData()
		self:updateView()

		self._isReturn = true
	end
end

function ExplorePointInfoMediator:onClickEnter()
	if self._pointData:getLock() then
		self:dispatch(ShowTipEvent({
			tip = self._pointData:getLockTip()
		}))

		return
	end

	if self._exploreSystem:getEnterTimes() <= 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_11307")
		}))

		return
	end

	local costPower = self._pointData:getNeedPower()

	if costPower > self._developSystem:getEnergy() then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("CUSTOM_ENERGY_NOT_ENOUGH")
		}))
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kActionPoint)

		return
	end

	local value = {}

	function value.callback()
		local mapKey = self._pointId

		self:enterMapByKeyA(mapKey)
	end

	value.cardsRecommend = self._pointData:getEffectHeroIds()

	local function enterFunc()
		local view = self:getInjector():getInstance("ExploreTeamView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			stageType = StageTeamType.WORLD_MAP,
			data = value,
			rule = Strings:get("EXPLORE_UI15"),
			pointData = self._pointData
		}))
	end

	local canAuto, tip = self._exploreSystem:canAuto(self._pointData)
	local autoState = self._pointData:getAutoState()
	local state = canAuto and not autoState
	local showTip = table.indexof(MapPointAutoTips, self._pointId)

	if state and showTip then
		local data = {
			title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
			content = Strings:get("EXPLORE_UI111"),
			sureBtn = {},
			cancelBtn = {}
		}
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				outSelf:refreshAuto(true)
				enterFunc()
			elseif data.response == "cancel" then
				enterFunc()
			elseif data.response == "close" then
				-- block empty
			end
		end

		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	else
		enterFunc()
	end
end

function ExplorePointInfoMediator:onClickQuickBtn()
	local times = math.min(self._exploreSystem:getEnterTimes(), 5)

	if self._pointData:getLock() then
		self:dispatch(ShowTipEvent({
			tip = self._pointData:getLockTip()
		}))

		return
	end

	if times <= 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_11307")
		}))

		return
	end

	local costPower = self._pointData:getNeedPower()

	if costPower > self._developSystem:getEnergy() then
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kActionPoint)

		return
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if not data then
			return
		end

		if data.returnValue == 1 then
			outSelf:onClickEnter()
		elseif data.returnValue == 2 then
			outSelf:onClickWipeTimes(times)
		elseif data.returnValue == 3 then
			outSelf:onClickWipeTimes(1)
		end
	end

	local data = {}

	data.normalType = 1
	data.desc = "BigMap_RewardFast_Text02"
	data.stageType = StageType.kElite
	data.challengeTimes = times

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("SweepBoxPopView"), {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ExplorePointInfoMediator:onClickWipeTimes(times)
	self._exploreSystem:requestSweepPoint(self._pointId, times, function(response)
		local data = {}

		data.reward = response.data
		data.param = {
			pointId = self._pointId,
			wipeTimes = times
		}

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("ExploreSweepView"), {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))
	end)
end

function ExplorePointInfoMediator:onClickStrategy()
	local params = {
		pointId = self._pointId
	}

	self._exploreSystem:requestGetPointComment(function(response)
		local view = self:getInjector():getInstance("ExploreLogView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			tabType = 2,
			pointData = self._pointData,
			serverdata = response.data
		}))
	end, params)
end

function ExplorePointInfoMediator:onClickHeroIcon(sender, eventType, heroId, panel)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local targetPos = sender:getParent():convertToWorldSpace(cc.p(sender:getPosition()))

		self._heroInfoPanel:setPositionX(self._heroInfoPanel:getParent():convertToNodeSpace(targetPos).x - 45)
		self._heroInfoPanel:setVisible(true)
		self:updateHeroInfo(heroId)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self._heroInfoPanel:setVisible(false)
	end
end

function ExplorePointInfoMediator:onClickAuto()
	local canAuto, tip = self._exploreSystem:canAuto(self._pointData)

	if not canAuto then
		self:dispatch(ShowTipEvent({
			tip = tip
		}))

		return
	end

	local autoState = self._pointData:getAutoState()
	local state = not autoState

	self:refreshAuto(state)
end

function ExplorePointInfoMediator:refreshAuto(state)
	self._pointData:setAutoState(state)
	self._autoBtn:getChildByFullName("auto"):setVisible(state)
	self._exploreSystem:setAutoBattleStatus(state)

	local color = cc.c3b(195, 195, 195)

	self._autoBtn:getChildByFullName("text"):setColor((state or nil) and cc.c3b(255, 255, 255))

	local bgFile = state and "ts_bg_d01.png" or "ts_bg_d02.png"

	self._autoBtn:getChildByFullName("bg"):loadTexture(bgFile, 1)
end

function ExplorePointInfoMediator:onClickTip()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageSp_Map_Rule", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end

function ExplorePointInfoMediator:onTouchMaskLayer()
	return
end

function ExplorePointInfoMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local enterBtn = self._leftPanel:getChildByFullName("enterBtn")

		if enterBtn then
			storyDirector:setClickEnv("ExplorePointInfoMediator.enterBtn", enterBtn, function(sender, eventType)
				self:onClickEnter()
			end)
		end

		local targetDesc = self._leftPanel:getChildByName("targetDesc")

		storyDirector:setClickEnv("ExplorePointInfoMediator.targetDesc", targetDesc, nil)

		local heroPanel = self._leftPanel:getChildByName("Image_12")

		storyDirector:setClickEnv("ExplorePointInfoMediator.heroPanel", heroPanel, nil)

		local rewardPanel = self._leftPanel:getChildByName("Image_12_0")

		storyDirector:setClickEnv("ExplorePointInfoMediator.rewardPanel", rewardPanel, nil)
		storyDirector:notifyWaiting("enter_ExplorePointInfoMediator")
	end))

	self:getView():runAction(sequence)
end
