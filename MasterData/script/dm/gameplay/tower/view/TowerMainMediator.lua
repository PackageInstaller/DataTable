-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerMainMediator.lua

TowerMainMediator = class("TowerMainMediator", DmAreaViewMediator, _M)

TowerMainMediator:has("_towerSystem", {
	is = "rw"
}):injectWith("TowerSystem")
TowerMainMediator:has("_dataList", {
	is = "rw"
})
TowerMainMediator:has("_selectData", {
	is = "rw"
})
TowerMainMediator:has("_selectBaseData", {
	is = "rw"
})
TowerMainMediator:has("_curTabId", {
	is = "rw"
})

local kBtnHandlers = {
	["main.describe_panel.button_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	},
	["main.movieClipPanel.Button_begin"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBegin"
	},
	["left_panel.btn_recruit"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRecruit"
	},
	infoBtn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickInfoBtn"
	}
}

function TowerMainMediator:initialize()
	super.initialize(self)
end

function TowerMainMediator:dispose()
	super.dispose(self)
end

function TowerMainMediator:onRegister()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)

	super.onRegister(self)
	self:initData()
	self:initView()
end

function TowerMainMediator:enterWithData()
	self:refreshData()
	self:refreshView()
	self:setupClickEnvs()
end

function TowerMainMediator:resumeWithData()
	self:initData()
	self:refreshData()
	self:refreshView()
end

function TowerMainMediator:initData()
	self._curTabId = 1
end

function TowerMainMediator:initView()
	self:setupTopInfoWidget()
	self:bindWidgets()
	self:mapEventListeners()
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._background = self._main:getChildByFullName("backGround")
	self._backgroundRight = self._main:getChildByFullName("backGround_right")
	self._title = self._main:getChildByFullName("describe_panel.title")
	self._desc = self._main:getChildByFullName("describe_panel.desc")
	self._page = self:getView():getChildByFullName("left_panel.Image_left_panel_page")
	self._textCount = self._main:getChildByFullName("text_count")

	GameStyle:setCommonOutlineEffect(self._title)
	GameStyle:setCommonOutlineEffect(self._desc)
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("describe_panel.reward_panel.text"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("Text_desc1"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("Text_desc2"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("Text_desc3"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("Text_desc3"))
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("text_count"))

	self._roleNode = self._main:getChildByName("roleNode")
	self._leftPanel = self:getView():getChildByName("left_panel")
	self._recruitBtnText = self._leftPanel:getChildByFullName("btn_recruit.text")

	self._recruitBtnText:setString(Strings:get("TowerRecruitText"))
	self:addBeginMovieClipPanel()
	self:setStyle()
	self:getView():getChildByName("infoBtn"):setVisible(false)
end

function TowerMainMediator:setStyle()
	local outlineColor = cc.c4b(0, 0, 0, 255)
	local outlineWidth = 1
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 175, 48, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 245, 83, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}
	local t = self:getView():getChildByFullName("main.Text_desc3")

	t:enableOutline(outlineColor, outlineWidth)
	t:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
end

function TowerMainMediator:refreshData()
	self._dataList = self._towerSystem:getTowerDataList()

	self._towerSystem:setCurTowerId(self._dataList[self._curTabId]:getTowerId())

	self._selectData = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())
	self._selectBaseData = self._selectData:getTowerBase():getConfig()
end

function TowerMainMediator:refreshView()
	if not self._dataList or not self._selectData then
		return
	end

	self:createTabController()
	self._background:loadTexture("asset/scene/" .. self._selectBaseData.Picture)
	self:setRoleNode()
	self:setDescribeView()
	self:setRewardView()
	self:setCountView()
end

function TowerMainMediator:setDescribeView(...)
	self._title:setString(Strings:get(self._selectBaseData.Name))

	local prevViewSize = self._title:getContentSize()
	local px = self._title:getPositionX() + prevViewSize.width

	self._main:getChildByFullName("describe_panel.button_rule"):setPositionX(px + 20)
	self._desc:setString(Strings:get(self._selectBaseData.Desc))
end

function TowerMainMediator:setCountView(...)
	self._enterTimes = self._selectData:getEnterTimes().value

	local max = ConfigReader:getDataByNameIdAndKey("Reset", self._selectBaseData.Reset, "ResetSystem").max

	self._mountTimes = max and max or ConfigReader:getDataByNameIdAndKey("Reset", self._selectBaseData.Reset, "ResetSystem").setValue or self._enterTimes or 1

	self._textCount:setString(Strings:get("Tower_Remain_Times", {
		num1 = self._enterTimes,
		num2 = self._mountTimes
	}))
end

function TowerMainMediator:setRewardView(...)
	local rewards = RewardSystem:getRewardsById(tostring(self._selectBaseData.ShowReward))
	local index = 0

	for i = 1, 4 do
		local rewardData = rewards[#rewards - index]
		local iconBg = self._main:getChildByFullName("describe_panel.reward_panel.icon" .. i)

		iconBg:removeAllChildren()

		if rewardData then
			index = index + 1

			local icon = IconFactory:createRewardIcon(rewardData, {
				showAmount = false,
				isWidget = true
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
				needDelay = true
			})
			icon:setScaleNotCascade(0.5)
			icon:addTo(iconBg):center(iconBg:getContentSize())
		end
	end

	local buffPanel = self._main:getChildByFullName("describe_panel.buff_panel")
	local starBuff = buffPanel:getChildByFullName("starBuff.iconReward.text")
	local awakenBuff = buffPanel:getChildByFullName("awakenBuff.iconReward.text")
	local buffData = ConfigReader:getRecordById("SkillAttrEffect", "Tower_1_Star_Buff")
	local awakeData = ConfigReader:getRecordById("SkillAttrEffect", "Tower_1_Awake_Buff")

	starBuff:setString(Strings:get(buffData.EffectDesc, {
		Value = buffData.Value
	}))
	awakenBuff:setString(Strings:get(awakeData.EffectDesc, {
		Value = awakeData.Value
	}))
end

function TowerMainMediator:addBeginMovieClipPanel()
	local panel = self:getView():getChildByFullName("main.movieClipPanel")
	local mc = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

	mc:setScale(0.8)
	mc:addTo(panel)
	mc:setPosition(cc.p(100, 100))
end

function TowerMainMediator:getTabData()
	local btnDatas = {}

	for i = 1, #self._dataList do
		local d = self._dataList[i]
		local unlock, tips = self._towerSystem:getTowerOpenState(d:getTowerId())
		local var_15_0 = {}

		var_15_0.tabText = Strings:get(d:getTowerBase():getConfig().Name)
		var_15_0.tabTextTranslate = Strings:get(d:getTowerBase():getConfig().ENName)
		var_15_0.lock = not unlock
		btnDatas[#btnDatas + 1] = var_15_0
	end

	return {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end,
		btnDatas = btnDatas
	}
end

function TowerMainMediator:onClickTab(name, tag)
	if tag == self._curTabId then
		return
	end

	local unlock, tips = self._towerSystem:getTowerOpenState(self._dataList[tag]:getTowerId())

	if not unlock then
		self:dispatch(ShowTipEvent({
			tip = tips
		}))

		return
	end

	self._curTabId = tag

	self:refreshData()
	self:refreshView()
end

function TowerMainMediator:createTabController()
	if self._tabBtnWidget then
		return
	end

	local config = self:getTabData()
	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 400)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabId)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._leftPanel):posite(0, -2)
	view:setLocalZOrder(1100)
	self._tabBtnWidget:scrollTabPanel(self._curTabId)
	self._page:setVisible(#self._dataList > 5 and true or false)
end

function TowerMainMediator:setRoleNode()
	self._roleNode:removeAllChildren()

	local roleModel = self._selectBaseData.Model

	if roleModel then
		local img = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = roleModel
		})

		self._roleNode:addChild(img)
		img:setScale(0.88)
		img:offset(60, 30)
	end
end

function TowerMainMediator:mapEventListeners()
	return
end

function TowerMainMediator:bindWidgets()
	self:bindWidget("main.button_sure", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickSure, self)
		}
	})
	self:bindWidget("main.button_cancel", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickCancel, self)
		}
	})
end

function TowerMainMediator:onClickSure(sender, eventType)
	self._towerSystem:showTowerBeginView()
end

function TowerMainMediator:onClickCancel(sender, eventType)
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:get("Tower_ChallengeTimeLock")
	}))
end

function TowerMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Unlock_Tower_All")
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
		title = Strings:get("Tower_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function TowerMainMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function TowerMainMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tower_1_RuleText", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {
			time = TimeUtil:getSystemResetDate()
		}
	}))
end

function TowerMainMediator:onClickBegin()
	local towerId = self._towerSystem:getCurTowerId()

	if self._towerSystem:checkTowerBuffAndCards() then
		return
	end

	local d = self._towerSystem:getTowerDataById(towerId)

	if d:getStatus() == kEnterFightStatus.END then
		local state = self._enterTimes > 0

		if not state then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tower_ChallengeTimeLock")
			}))

			return
		end

		self._towerSystem:showTowerBeginView()
	elseif d:getStatus() == kEnterFightStatus.ENTER then
		self._towerSystem:showTowerPointView(d:getTowerId())
	else
		self._towerSystem:showTowerChooseRoleView()
	end
end

function TowerMainMediator:onClickRecruit(sender, eventType)
	local recruitSystem = self:getInjector():getInstance(RecruitSystem)
	local data = {
		recruitType = RecruitPoolType.kPve
	}

	recruitSystem:tryEnter(data)
end

function TowerMainMediator:onClickInfoBtn(sender, eventType)
	RuleFactory:showRules(self, nil, "Mirror_GuidePic")
end

function TowerMainMediator:setupClickEnvs()
	local scriptNames = "guide_TowerPicGuide"
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local guideSaved = guideAgent:isSaved(scriptNames)

	if not guideSaved then
		RuleFactory:showRules(self, nil, "Mirror_GuidePic")
		guideAgent:save(scriptNames)
	end

	storyDirector:notifyWaiting("enter_TowerMain_view")
end
