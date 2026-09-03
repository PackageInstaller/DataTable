-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/pass/view/PassMainMediator.lua

PassMainMediator = class("PassMainMediator", DmAreaViewMediator, _M)

PassMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PassMainMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
PassMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
PassMainMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kTabBtnData = {
	{
		viewName = "PassAwardView",
		unlockKey = "",
		tabName = Strings:get("Pass_UI4")
	},
	{
		viewName = "PassTaskView",
		unlockKey = "",
		tabName = Strings:get("Pass_UI3")
	},
	{
		viewName = "PassShopView",
		unlockKey = "",
		tabName = Strings:get("Pass_UI49")
	}
}
local kBtnHandlers = {
	["main.levelNode.reward.ringNode.buyBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBuy"
	},
	["main.levelNode.reward.ringNode.previewBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReward"
	},
	["main.levelNode.level.main.btnBuy"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBuyLevel"
	},
	["main.levelNode.level.main.btnGetAll"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickGetAll"
	}
}

function PassMainMediator:initialize()
	super.initialize(self)
end

function PassMainMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._tabController then
		self._tabController:dispose()

		self._tabController = nil
	end

	for i, view in pairs(self._cacheViews) do
		if view and view.mediator then
			view.mediator:dispose()
		end
	end

	super.dispose(self)
end

function PassMainMediator:userInject()
	return
end

function PassMainMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.onResetDone)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PASSPORT_REFRESH, self, self.doPassPortRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PASSPORT_LEVELUP, self, self.showLevelUp)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PASSPORT_DAILYEXP, self, self.showDailyExp)
end

function PassMainMediator:enterWithData(data)
	self:initData()
	self:initNodes()
	self:setupTopInfoWidget()
	self:createTabController()
	self:resetViews()
	self:refreshRedPoint()

	if self._showPass == true then
		local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
		local data = customDataSystem:getValue(PrefixType.kGlobal, EVT_PASS_ACTIVATE_KEY .. "_FirstEnterPass", "false")

		if data == nil or data == "false" then
			self._passSystem:showActivateView({
				showType = 1,
				type = 1
			})
			customDataSystem:setValue(PrefixType.kGlobal, EVT_PASS_ACTIVATE_KEY .. "_FirstEnterPass", "true")
		end

		self._passSystem:checkShowDailyChangePopUp()
	end

	self:runStartAction()
end

function PassMainMediator:doPassPortRefresh()
	self._showPassEnter, self._showPass, self._showPassShop = self._passSystem:checkShowPassAndPassShop()

	self:initCurrentLevelNode()

	if self._showPass == false and self._showPassShop == true and self._tabType ~= 3 then
		self._tabType = 3

		self:resetViews()
	end

	if self._showPass == true and self._showPassShop == false and self._tabType == 3 then
		self._tabType = 1

		self:resetViews()
	end

	self:refreshRedPoint()
end

function PassMainMediator:refreshRedPoint()
	for i = 1, #self._tabBtns do
		local showRedPoint = false

		if i == 1 then
			showRedPoint = self._showPass and self._passSystem:checkIsHaveRewardCanGet()
		end

		if i == 2 then
			showRedPoint = self._showPass and self._passSystem:checkIsHaveTaskRewardCanGet(PassTaskType.kAllTask)
		end

		self._tabBtns[i].redPoint:setVisible((i >= 3 or nil) and false)
	end
end

function PassMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._passSystem:getResourceBannerIds(self._tabType)

	if currencyInfoWidget == nil then
		currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Quality")
	end

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
		title = Strings:get("Pass_UI1")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local titlePanel = topInfoNode:getChildByFullName("titlePanel")

	if titlePanel:getChildByName("InfoSprite") == nil then
		local image = ccui.ImageView:create("asset/common/common_btn_xq.png")

		image:addTo(titlePanel):posite(310, 40)
		image:setScale(0.6)
		image:setName("InfoSprite")
		image:setTouchEnabled(true)
		image:addClickEventListener(function()
			self:onClickShowActivityInfo()
		end)
	end
end

function PassMainMediator:refreshTopInfo(tabType)
	local currencyInfoWidget = self._passSystem:getResourceBannerIds(tabType)

	if currencyInfoWidget == nil then
		currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Quality")
	end

	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		stopAnim = true,
		currencyInfo = currencyInfo,
		title = Strings:get("Pass_UI1"),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	}

	self._topInfoWidget:updateView(config)
end

function PassMainMediator:initData()
	self._showPassEnter, self._showPass, self._showPassShop = self._passSystem:checkShowPassAndPassShop()
	self._cacheViews = {}
	self._tabType = 1

	if self._showPass == false and self._showPassShop == true then
		self._tabType = 3
	end

	self:getTaskEndTime()
end

function PassMainMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._timeNode = self._mainPanel:getChildByFullName("timeNode")
	self._levelNode = self._mainPanel:getChildByFullName("levelNode")
	self._levelInfoNode = self._levelNode:getChildByFullName("level")
	self._loadingBar = self._levelNode:getChildByFullName("level.main.loadingBar")

	self._loadingBar:setScale9Enabled(true)
	self._loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	self._btnGetAll = self._levelInfoNode:getChildByFullName("main.btnGetAll")
	self._btnBuy = self._levelInfoNode:getChildByFullName("main.btnBuy")
	self._bigRewardInfoNode = self._levelNode:getChildByFullName("reward")
	self._ringNode = self._bigRewardInfoNode:getChildByFullName("ringNode")
	self._heroNode = self._bigRewardInfoNode:getChildByFullName("heroNode")
	self._tabClone = self._mainPanel:getChildByFullName("tabClone")

	self._tabClone:setVisible(false)
	self:initCurrentLevelNode()

	if self._showPass == true then
		self:updateRemainTime()
		self:initBigRewardNode()
	end
end

function PassMainMediator:initCurrentLevelNode()
	local levelMain = self._levelInfoNode:getChildByFullName("main")
	local text = levelMain:getChildByFullName("level")

	text:setString(tostring(self._passSystem:getCurrentLevel()))

	local exp = levelMain:getChildByFullName("exp")
	local text = levelMain:getChildByFullName("level")

	if self._passSystem:isPassMaxLevel() then
		local expStr = string.format("%d", self._passSystem:getCurrentLevelMaxExp())

		exp:setString(expStr)
		self._loadingBar:setPercent(100)
	else
		local expStr = string.format("%d/%d", self._passSystem:getCurrentLevelExp(), self._passSystem:getCurrentLevelMaxExp())

		exp:setString(expStr)

		local percent = self._passSystem:getCurrentLevelExp() / self._passSystem:getCurrentLevelMaxExp() * 100

		self._loadingBar:setPercent(percent)
	end

	self:checkButtonStatusOfGetAll()
end

function PassMainMediator:checkButtonStatusOfGetAll()
	if self._tabType == 1 then
		if self._passSystem:checkIsHaveRewardCanGet() then
			self._btnGetAll:setGray(false)
			self._btnGetAll:setEnabled(true)
		else
			self._btnGetAll:setGray(true)
			self._btnGetAll:setEnabled(false)
		end
	end

	if self._tabType == 2 then
		if self._passSystem:checkIsHaveTaskRewardCanGet(PassTaskType.kAllTask) then
			self._btnGetAll:setGray(false)
			self._btnGetAll:setEnabled(true)
		else
			self._btnGetAll:setGray(true)
			self._btnGetAll:setEnabled(false)
		end
	end
end

function PassMainMediator:initBigRewardNode()
	if self._tabType < 3 then
		self._heroNode:setVisible(false)

		local goodReward = self._passSystem:getGoodShow()
		local itemImage = self._ringNode:getChildByFullName("itemImage")
		local heroImage = self._ringNode:getChildByFullName("heroImage")

		if goodReward.good ~= nil and goodReward.type ~= nil then
			heroImage:setVisible(false)
			itemImage:setVisible(true)

			local nameText = self._ringNode:getChildByFullName("name")

			nameText:setString(self:getBigRewardName(goodReward.good))

			local iconNode = self._ringNode:getChildByFullName("icon")

			iconNode:removeAllChildren()

			local oneReward = {
				amount = 1,
				type = goodReward.type,
				code = goodReward.good
			}
			local icon
			local info = self:getEquipInfo(oneReward)

			if info then
				icon = IconFactory:createRewardEquipIcon(info, {
					hideLevel = true,
					notShowQulity = true,
					showAllSprite = true,
					showAmount = false,
					isWidget = false
				})

				icon:setScale(0.9)
			else
				icon = IconFactory:createIcon({
					rewardType = oneReward.type,
					id = oneReward.code,
					amount = oneReward.amount
				}, {
					hideLevel = true,
					showAmount = false,
					notShowQulity = true,
					isWidget = false
				})

				icon:setScale(1.7)
			end

			icon:addTo(iconNode)
		end

		if goodReward.hero ~= nil then
			heroImage:setVisible(true)
			itemImage:setVisible(false)

			local nameText = self._ringNode:getChildByFullName("name")

			nameText:setString(self:getBigRewardName(goodReward.good))

			local iconNode = self._ringNode:getChildByFullName("icon")

			iconNode:removeAllChildren()

			local heroPanel = self._ringNode:getChildByFullName("heroPanel")
			local roleModel = IconFactory:getRoleModelByKey("HeroBase", goodReward.hero)
			local heroImg = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe9",
				id = roleModel
			})

			if goodReward.position then
				heroImg:setPosition(cc.p(goodReward.position[1], goodReward.position[2]))
			end

			if goodReward.zoom then
				heroImg:setScale(goodReward.zoom[1])
			end

			heroImg:addTo(heroPanel)

			local heroPanel = self._ringNode:getChildByFullName("heroPanel")

			heroPanel:addClickEventListener(function()
				local heroInfo = self._heroSystem:getHeroInfoById(goodReward.hero)

				if not heroInfo then
					return
				end

				self:onClickHeroDetail(goodReward.hero)
			end)
		end

		self._ringNode:setVisible(true)
	else
		self._ringNode:setVisible(false)
	end
end

function PassMainMediator:updateData()
	return
end

function PassMainMediator:updateRemainTime()
	if self._showPass == false then
		self._timeNode:setVisible(false)

		return
	end

	if not self._timer then
		local remoteTimestamp = self._passSystem:getCurrentTime()
		local refreshTiem = self._passSystem:getCurrentActivity():getEndTime() / 1000

		local function checkTimeFunc()
			remoteTimestamp = self._passSystem:getCurrentTime()

			local remainTime = refreshTiem - remoteTimestamp

			if remainTime <= 0 then
				self._timer:stop()

				self._timer = nil

				return
			end

			self:refreshRemainTime(remainTime)
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function PassMainMediator:refreshRemainTime(remainTime)
	local str = ""
	local fmtStr = "${d}:${H}:${M}:${S}"
	local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
	local parts = string.split(timeStr, ":", nil, true)
	local timeTab = {}

	timeTab.day = tonumber(parts[1])
	timeTab.hour = tonumber(parts[2])
	timeTab.min = tonumber(parts[3])
	timeTab.sec = tonumber(parts[4])
	str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")

	local str1 = Strings:get("Pass_UI32", {
		time = str,
		fontName = TTF_FONT_FZYH_M
	})
	local node = self._timeNode:getChildByFullName("time")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local image = self._timeNode:getChildByFullName("Image_14")

		image:setContentSize(cc.size(240, 45))
	end

	node:removeAllChildren()

	local contentText = ccui.RichText:createWithXML(str1, {})

	contentText:setAnchorPoint(cc.p(0, 0.5))
	contentText:setPosition(cc.p(-70, 0))
	contentText:addTo(node)
	contentText:renderContent(180, 0, true)
end

function PassMainMediator:createTabController()
	self._ignoreRefresh = true
	self._tabBtns = self._tabBtns or {}
	self._invalidBtns = {}
	self._cacheViewsName = {}
	self._ignoreSound = true

	local index = 0

	for i = 1, #kTabBtnData do
		local data = kTabBtnData[i]
		local unlockKey = data.unlockKey
		local tabName = data.tabName
		local viewName = data.viewName
		local canShow = true
		local unlock = true
		local tip = Strings:get("Pass_UI59")

		if unlockKey == "" then
			if self._showPass == false and i < 4 then
				unlock = false
			end

			if self._showPassShop == false and i == 4 then
				unlock = false
			end
		else
			local unlock1, tip1 = self._systemKeeper:isUnlock(unlockKey)
			local canShow1, tip2 = self._systemKeeper:canShow(unlockKey)

			canShow = canShow1
			unlock = unlock1
			tip = tip2
		end

		if canShow then
			index = index + 1

			local btn = self._tabClone:clone()

			btn:setVisible(true)
			btn:addTo(self._mainPanel:getChildByFullName("tabPanel.panel"))

			local posX = -83 - (i - 1) * 170

			btn:setPosition(cc.p(posX, 0))
			btn:getChildByFullName("dark_1.text"):setString(tabName)
			btn:getChildByFullName("light_1.text"):setString(tabName)
			btn:setVisible(true)
			btn:setTag(i)

			btn.index = index
			btn.redPoint = RedPoint:createDefaultNode()

			btn.redPoint:setScale(0.8)
			btn.redPoint:addTo(btn:getChildByFullName("dark_1")):posite(160, 53)
			btn.redPoint:setLocalZOrder(99900)

			self._tabBtns[i] = btn
			self._cacheViewsName[i] = viewName
			btn.tip = nil

			if not unlock then
				btn.tip = tip
				self._invalidBtns[i] = btn
			end
		end
	end

	self._tabController = TabController:new(self._tabBtns, function(name, tag)
		self:onClickTab(name, tag)
	end)

	self._tabController:selectTabByTag(self._tabType)
	self._tabController:setInvalidButtons(self._invalidBtns)
end

function PassMainMediator:resetViews()
	if not self._cacheViews[self._tabType] then
		local view = self:getInjector():getInstance(self._cacheViewsName[self._tabType])

		if view then
			view:addTo(self._mainPanel):center(self._mainPanel:getContentSize())
			AdjustUtils.adjustLayoutUIByRootNode(view)
			view:setLocalZOrder(2)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator

				mediator:setTabIndex(self._tabType)
				mediator:setupView(self)
			end

			self._cacheViews[self._tabType] = view
		end
	end

	self._passSystem:setShowViewTabIndex(self._tabType)

	for i, view in pairs(self._cacheViews) do
		if view and view.mediator then
			view:setVisible(self._tabType == i)

			if view:isVisible() then
				view.mediator:refreshData(true)
				view.mediator:refreshView(true)
			else
				view.mediator:removeTableView()
				view.mediator:stopEffect()
			end
		end
	end

	self._levelNode:setVisible(self._tabType < 3)
	self:checkButtonStatusOfGetAll()
	self:refreshTopInfo(self._tabType)
end

function PassMainMediator:onClickTab(name, tag)
	if self._invalidBtns[tag] then
		self:dispatch(ShowTipEvent({
			tip = self._invalidBtns[tag].tip
		}))

		return
	end

	if self._showPass == false and self._showPassShop == true then
		if tag ~= 3 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Pass_UI59")
			}))
		end

		return
	end

	self._tabType = tag

	if not self._ignoreSound then
		AudioEngine:getInstance():playEffect("Se_Click_Tab_5", false)
	else
		self._ignoreSound = false
	end

	if not self._ignoreRefresh then
		self:updateData()
		self:resetViews()
	else
		self._ignoreRefresh = false
	end
end

function PassMainMediator:onClickBuy()
	self._passSystem:showBuyView()
end

function PassMainMediator:onClickBuyLevel()
	if self._passSystem:isPassMaxLevel() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Pass_UI60")
		}))

		return
	end

	if self._passSystem:getHasRemarkableStatus() == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Pass_UI14")
		}))

		return
	end

	self._passSystem:showBuyLevelView()
end

function PassMainMediator:onClickGetAll()
	local activityId = self._passSystem:getCurrentActivityID()

	if self._tabType == 1 then
		self._passSystem:requestGetReward(1, -1, nil)
	end

	if self._tabType == 2 then
		self._passSystem:requestGetTaskReward(-1, nil, nil)
	end
end

function PassMainMediator:getTaskEndTime()
	local showPassEnter, showPass, showPassShop = self._passSystem:checkShowPassAndPassShop()

	if showPass == true then
		self._passSystem:requestTaskEndTime()
	end
end

function PassMainMediator:onClickReward()
	self._passSystem:showRewardsPreviewView()
end

function PassMainMediator:onClickShowActivityInfo()
	local RuleDesc = ConfigReader:getRecordById("ConfigValue", "BattlePass_RuleDesc").content.RuleDesc

	if RuleDesc ~= nil then
		local view = self:getInjector():getInstance("ArenaRuleView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			rule = RuleDesc
		}, nil)

		self:dispatch(event)
	end
end

function PassMainMediator:onClickBack()
	self:dismiss()
end

function PassMainMediator:onResetDone(event)
	local data = event:getData()

	if data and (data[ResetId.kBattlePass_ClubTask] or data[ResetId.kBattlePass_DailyTask]) then
		local showPassEnter, showPass, showPassShop = self._passSystem:checkShowPassAndPassShop()

		if showPassEnter == false then
			self:dismiss()
			self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

			return true
		end

		if showPass == false and self._tabType ~= 3 then
			self._tabType = 3

			self:resetViews()
		end

		if showPassShop == false and self._tabType == 3 then
			self._tabType = 1

			self:resetViews()
		end

		self:getTaskEndTime()
		self:dispatch(Event:new(EVT_PASSPORT_REFRESH))
	end
end

function PassMainMediator:showLevelUp(event)
	local data = event:getData()

	self._passSystem:showLevelUpView(data)
end

function PassMainMediator:showDailyExp(event)
	local data = event:getData()

	self._passSystem:checkShowDailyChangePopUp()
end

function PassMainMediator:runStartAction()
	self._levelNode:stopAllActions()

	local action1 = cc.CSLoader:createTimeline("asset/ui/PassLevelWidget.csb")

	self._levelNode:runAction(action1)
	action1:clearFrameEventCallFunc()
	action1:gotoFrameAndPlay(0, 30, false)
	action1:setTimeSpeed(1)
	self._bigRewardInfoNode:stopAllActions()

	local action2 = cc.CSLoader:createTimeline("asset/ui/PassRewardWidget.csb")

	self._bigRewardInfoNode:runAction(action2)
	action2:clearFrameEventCallFunc()
	action2:gotoFrameAndPlay(0, 25, false)
	action2:setTimeSpeed(1)
end

function PassMainMediator:getEquipInfo(data)
	local HeroEquipExp = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipExp", "content")
	local HeroEquipStar = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStar", "content")

	if data.type == RewardType.kEquip or data.type == RewardType.kEquipExplore then
		local config = ConfigReader:getRecordById("HeroEquipBase", data.code)

		if not config.Rareity then
			return nil
		end

		local rarity = config.Rareity
		local star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", HeroEquipStar[tostring(rarity)], "StarLevel")
		local level = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", HeroEquipExp[tostring(rarity)], "ShowLevel")

		return {
			id = data.code,
			rarity = rarity,
			star = star,
			level = level
		}
	end

	return nil
end

function PassMainMediator:getBigRewardName(code)
	if code then
		local config = ConfigReader:getRecordById("ItemConfig", code)

		config = config or ConfigReader:getRecordById("Surface", code)
		config = config or ConfigReader:getRecordById("HeroEquipBase", code)
		config = config or ConfigReader:getRecordById("HeroBase", code)
		config = config or ConfigReader:getRecordById("ResourcesIcon", code)
		config = config or ConfigReader:getRecordById("PlayerHeadFrame", code)

		if config then
			return Strings:get(config.Name)
		end
	end

	return ""
end

function PassMainMediator:onClickDetail(id)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("HeroInfoView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		heroId = id
	}))
end

function PassMainMediator:onClickHeroDetail(id)
	self:onClickDetail(id)
end
