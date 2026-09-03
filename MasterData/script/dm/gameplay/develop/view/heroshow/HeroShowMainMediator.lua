-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/heroshow/HeroShowMainMediator.lua

HeroShowMainMediator = class("HeroShowMainMediator", DmAreaViewMediator, _M)

HeroShowMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroShowMainMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
HeroShowMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
HeroShowMainMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")
HeroShowMainMediator:has("_soundId", {
	is = "rw"
})
HeroShowMainMediator:has("_heroEffectId", {
	is = "rw"
})
HeroShowMainMediator:has("_ignoreSoundEffect", {
	is = "rw"
})

local kRightTabPos = {
	{
		cc.p(20, 297)
	},
	{
		cc.p(20, 342),
		cc.p(-13, 251)
	},
	{
		cc.p(20, 389),
		cc.p(-13, 298),
		cc.p(20, 207)
	},
	{
		cc.p(20, 432),
		cc.p(-13, 341),
		cc.p(20, 250),
		cc.p(-13, 159)
	},
	{
		cc.p(20, 480),
		cc.p(-13, 389),
		cc.p(20, 298),
		cc.p(-13, 207),
		cc.p(20, 116)
	}
}
local kTabBtnData = {
	{
		viewName = "HeroShowOwnView",
		unlockKey = "",
		tabName = Strings:get("HEROS_UI9"),
		tabName1 = Strings:get("UITitle_EN_Juese")
	},
	{
		viewName = "HeroStrengthEvolutionView",
		unlockKey = "Hero_Quality",
		tabName = Strings:get("QualityUI_1"),
		tabName1 = Strings:get("UITitle_EN_Lianjie")
	},
	{
		unlockKey = "Hero_StarUp",
		switchKey = "fn_hero_jingjie",
		viewName = "HeroStrengthStarView",
		tabName = Strings:get("HEROS_UI5"),
		tabName1 = Strings:get("UITitle_EN_Jingjie")
	},
	{
		viewName = "HeroStrengthSkillView",
		unlockKey = "Hero_Skill",
		tabName = Strings:get("heroshow_UI8"),
		tabName1 = Strings:get("UITitle_EN_Jineng")
	},
	{
		unlockKey = "Hero_Equip",
		switchKey = "fn_hero_equip",
		viewName = "HeroStrengthEquipView",
		tabName = Strings:get("Equip_Text1"),
		tabName1 = Strings:get("UITitle_EN_Zhuangbei")
	},
	{
		viewName = "HeroStrengthAwakenView",
		unlockKey = "Hero_StarUp",
		tabName = Strings:get("HEROS_UI5"),
		tabName1 = Strings:get("UITitle_EN_Jingjie")
	},
	{
		unlockKey = "Projection",
		switchKey = "fn_hero_soul",
		viewName = "TSoulMainView",
		tabName = Strings:get("TimeSoul_Button_Name"),
		tabName1 = Strings:get("UITitle_EN_TSoul")
	},
	{
		viewName = "HeroIdentityAwakeView",
		unlockKey = "Hero_StarUp",
		tabName = Strings:get("HEROS_UI5"),
		tabName1 = Strings:get("UITitle_EN_Jingjie")
	}
}
local kBtnHandlers = {
	["btnPanel.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["btnPanel.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	}
}

function HeroShowMainMediator:initialize()
	super.initialize(self)
end

function HeroShowMainMediator:dispose()
	self:getView():stopAllActions()

	self._viewClose = true

	if self._tabController then
		self._tabController:dispose()

		self._tabController = nil
	end

	if self._baseShowView then
		self._baseShowView:dispose()

		self._baseShowView = nil
	end

	self:stopHeroEffect()
	super.dispose(self)
end

function HeroShowMainMediator:userInject()
	return
end

function HeroShowMainMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._equipSystem = self._developSystem:getEquipSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_IGNORESOUND, self, self.resetIgnoreSound)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SURFACE_CHANGE_HERO, self, self.refreshWithData)
end

function HeroShowMainMediator:resetIgnoreSound(event)
	return
end

function HeroShowMainMediator:enterWithData(data)
	self._list = self._heroSystem:getOwnHeroIds()
	self._showChangeBtn = #self._list > 1

	if data and data.tabType then
		self._tabType = data.tabType or 1
	end

	if data and data.id then
		self._selectHeroId = data.id or self._list[1].id
	end

	if data and data.ignoreInit then
		if not data.ignoreInit then
			local ignoreInit = false

			self._heroSystem:setUiSelectHeroId(self._selectHeroId)

			self._cacheViews = {}
			self._soundId = nil
			self._heroEffectId = nil

			if data then
				self._ignoreSoundEffect = data.ignoreSound or false
			end

			self._canChangeHero = true

			self:refreshCurIndex()
			self:setupTopInfoWidget()
			self:initNodes()
			self:createTabController()
			self:getView():getChildByFullName("right_node"):setOpacity(0)

			if not ignoreInit then
				self:runBtnAnim()
				self:resetViews()
				self:setupClickEnvs()
			end
		end
	end
end

function HeroShowMainMediator:initByController()
	self:runBtnAnim()
	self:resetViews()
	self:setupClickEnvs()
end

function HeroShowMainMediator:runBtnAnim()
	local leftBtn = self:getView():getChildByFullName("btnPanel.left.leftBtn")
	local rightBtn = self:getView():getChildByFullName("btnPanel.right.rightBtn")

	CommonUtils.runActionEffect(leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true)
	CommonUtils.runActionEffect(rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true)
	performWithDelay(self:getView(), function()
		self:getView():getChildByFullName("right_node"):fadeIn({
			time = 0.7
		})
	end, 0.6)
end

function HeroShowMainMediator:resumeWithData()
	if self._viewClose then
		return
	end

	if self:getView():getChildByFullName("right_node"):getOpacity() == 0 then
		self:runBtnAnim()
	end

	self._initTouchSlide = false

	self:stopHeroEffect()
	self:updateData()
	self:refreshTabBtn()
	self:resetViews()
end

function HeroShowMainMediator:refreshWithData()
	if self._viewClose then
		return
	end

	self:updateData()
	self:resetViews(true)
end

function HeroShowMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Quality")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		stopAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Strengthen_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function HeroShowMainMediator:initNodes()
	self._btnPanel = self:getView():getChildByFullName("btnPanel")
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabClone = self:getView():getChildByFullName("tabClone")

	self._tabClone:setVisible(false)

	self._basePanel = self:getView():getChildByFullName("main.basePanel")

	self._basePanel:setVisible(false)
	self._basePanel:setLocalZOrder(2)

	local baseShowViewData = {
		isForAwaken = true,
		mediator = self,
		heroId = self._selectHeroId,
		mainNode = self._basePanel
	}

	self._baseShowView = self._heroSystem:enterBaseShowView(baseShowViewData)

	self._baseShowView:refreshView(self._selectHeroId)
	self._tabClone:getChildByFullName("dark_1.text1"):enableOutline(cc.c4b(3, 1, 4, 51), 1)
	self._tabClone:getChildByFullName("dark_1.text1"):setColor(cc.c3b(110, 108, 108))
	self._tabClone:getChildByFullName("dark_1.text1"):enableShadow(cc.c4b(3, 1, 4, 25.5), cc.size(1, 0), 1)
	self._tabClone:getChildByFullName("light_1.text1"):enableOutline(cc.c4b(3, 1, 4, 51), 1)
	self._tabClone:getChildByFullName("light_1.text1"):setColor(cc.c3b(110, 108, 108))
	self._tabClone:getChildByFullName("light_1.text1"):enableShadow(cc.c4b(3, 1, 4, 25.5), cc.size(1, 0), 1)

	local leftBtn = self:getView():getChildByFullName("btnPanel.left.leftBtn")
	local rightBtn = self:getView():getChildByFullName("btnPanel.right.rightBtn")

	leftBtn:setOpacity(0)
	rightBtn:setOpacity(0)
end

function HeroShowMainMediator:updateData()
	self._list = self._heroSystem:getOwnHeroIds()
	self._selectHeroId = self._heroSystem:getUiSelectHeroId() or self._selectHeroId
	self._showChangeBtn = #self._list > 1

	self:refreshCurIndex()
end

function HeroShowMainMediator:initTabBtn()
	self._tabBtns = self._tabBtns or {}
	self._invalidBtns = {}

	for i, v in pairs(self._tabBtns) do
		self._tabBtns[i]:removeFromParent()

		self._tabBtns[i] = nil
	end

	self._cacheViewsName = {}
	self._ignoreSound = true

	local index = 0

	for i = 1, #kTabBtnData do
		local data = kTabBtnData[i]
		local unlockKey = data.unlockKey
		local tabName = data.tabName
		local tabName1 = data.tabName1
		local viewName = data.viewName
		local unlock, tip1 = self._systemKeeper:isUnlock(unlockKey)
		local canShow, tip2 = self._systemKeeper:canShow(unlockKey)

		if i == 1 then
			canShow = true
			unlock = true
		elseif i == 2 then
			canShow = false
			unlock = false
		elseif i == 6 or i == 8 then
			canShow = false
			unlock = false
			self._cacheViewsName[i] = viewName
		end

		if (data.switchKey and not CommonUtils.GetSwitch(data.switchKey) or nil) and false then
			index = index + 1

			local btn = self._tabClone:clone()

			btn:setVisible(true)
			btn:addTo(self:getView():getChildByFullName("right_node"))
			btn:getChildByFullName("dark_1.text"):setString(tabName)
			btn:getChildByFullName("light_1.text"):setString(tabName)

			if btn:getChildByFullName("dark_1.text1") then
				btn:getChildByFullName("dark_1.text1"):setString(tabName1)
				btn:getChildByFullName("light_1.text1"):setString(tabName1)
			end

			btn:setVisible(true)
			btn:setTag(i)

			btn.trueIndex = index
			self._tabBtns[i] = btn
			self._cacheViewsName[i] = viewName
			btn.tip = nil

			if not unlock then
				btn.tip = tip1
				self._invalidBtns[i] = btn
			end
		end
	end

	local length = table.nums(self._tabBtns)
	local positions = kRightTabPos[length]

	for i, v in pairs(self._tabBtns) do
		local btn = self._tabBtns[i]
		local index = btn.trueIndex

		btn:setPosition(positions[index])
	end
end

function HeroShowMainMediator:createTabController()
	self._ignoreRefresh = true

	self:initTabBtn()

	self._tabController = TabController:new(self._tabBtns, function(name, tag)
		self:onClickTab(name, tag)
	end, {
		showAnim = 2
	})

	self._tabController:selectTabByTag(self._tabType)
	self._tabController:setInvalidButtons(self._invalidBtns)
end

function HeroShowMainMediator:refreshTabBtn()
	for i, v in pairs(self._cacheViews) do
		self._cacheViews[i]:removeFromParent()

		self._cacheViews[i] = nil
	end

	self:initTabBtn()
	self._tabController:refreshView(self._tabBtns)
	self._tabController:selectTabByTag(self._tabType)
	self._tabController:setInvalidButtons(self._invalidBtns)
end

function HeroShowMainMediator:resetViews(hideAnim)
	local heroData = self._heroSystem:getHeroById(self._selectHeroId)
	local hasAwaken = heroData:checkHaveAwakenView()
	local createNameType = self._tabType

	if self._tabType == 3 and hasAwaken then
		createNameType = heroData:heroAwaked() and heroData:canIdentityAwake() and 8 or 6
		self._isClick = true

		if self._cacheViews[createNameType] then
			self._cacheViews[createNameType].mediator:resetView()
		end
	end

	if not self._cacheViews[createNameType] then
		local view = self:getInjector():getInstance(self._cacheViewsName[createNameType])

		if view then
			view:addTo(self._mainPanel):center(self._mainPanel:getContentSize())
			AdjustUtils.adjustLayoutUIByRootNode(view)
			view:setLocalZOrder(2)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator

				mediator:setupView(self, {
					id = self._selectHeroId,
					idList = self._list
				})
			end

			self._cacheViews[createNameType] = view
		end

		self:setupClickEnvs()
	end

	for i, view in pairs(self._cacheViews) do
		if view and view.mediator then
			view:setVisible(createNameType == i)

			if view:isVisible() then
				view.mediator:refreshData(self._selectHeroId)
				view.mediator:refreshAllView(hideAnim)

				if self._isClick then
					view.mediator:runStartAction()

					self._isClick = false
				end
			end
		end
	end

	if self._tabType > 1 then
		local isEquipView = self._tabType == 5

		self._baseShowView:refreshView(self._selectHeroId, hideAnim, isEquipView)
		self._baseShowView:hideInfoBg(not isEquipView)
	end

	self._basePanel:setVisible(self._tabType > 1 and createNameType ~= 6 and createNameType ~= 7 and createNameType ~= 8)
	self:refreshTabRedPoint()
	self:refreshArrowState()
	self:initTouchSlide()

	if not hideAnim then
		self:refreshBg()
	end
end

local dragType = {
	kDragRight = 2,
	kDragLeft = 1,
	kDragNo = 0
}

function HeroShowMainMediator:initTouchSlide()
	local view = self._cacheViews[1]

	if view and not self._initTouchSlide then
		view = view.mediator

		local heropanel = view:getView():getChildByFullName("mainpanel.heropanel")

		heropanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				self._dragType = dragType.kDragNo
			elseif eventType == ccui.TouchEventType.ended then
				if not self._showChangeBtn then
					view:onClickHelp()

					return
				end

				local beganPos = sender:getTouchBeganPosition()
				local movedPos = sender:getTouchEndPosition()

				self._dragType = self:checkTouchType(beganPos, movedPos)

				if self._dragType == dragType.kDragNo then
					-- block empty
				elseif self._dragType == dragType.kDragLeft then
					self:onClickLeft()
				elseif self._dragType == dragType.kDragRight then
					self:onClickRight()
				end
			end
		end)

		self._initTouchSlide = true
	end
end

function HeroShowMainMediator:checkTouchType(pos1, pos2)
	local xOffset = math.abs(pos1.x - pos2.x)

	if xOffset >= 100 then
		if pos1.x < pos2.x then
			return dragType.kDragLeft
		else
			return dragType.kDragRight
		end
	end

	return dragType.kDragNo
end

function HeroShowMainMediator:refreshArrowState()
	local leftBtn = self._btnPanel:getChildByFullName("left")
	local rightBtn = self._btnPanel:getChildByFullName("right")

	leftBtn:setVisible(self._showChangeBtn)
	rightBtn:setVisible(self._showChangeBtn)
end

function HeroShowMainMediator:refreshTabRedPoint()
	local redPointFuncMap = self._heroSystem:getRedPointFuncMap()

	for i, v in pairs(self._tabBtns) do
		local index = i

		if redPointFuncMap[index] then
			local redPoint = self._tabBtns[i]:getChildByTag(12138)

			if not redPoint then
				redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

				redPoint:addTo(self._tabBtns[i])
				redPoint:setAnchorPoint(cc.p(1, 1))
				redPoint:setPosition(cc.p(51, 106))
				redPoint:setTag(12138)
				redPoint:setLocalZOrder(999)
				redPoint:setRotation(-45)
			end

			local showRed = redPointFuncMap[index](self._heroSystem, self._selectHeroId)

			redPoint:setVisible(showRed)
		end
	end
end

function HeroShowMainMediator:onClickTab(name, tag)
	if self._invalidBtns[tag] then
		self:dispatch(ShowTipEvent({
			tip = self._invalidBtns[tag].tip
		}))

		return
	end

	self._tabType = tag
	self._isClick = true

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

	if self._basePanel:isVisible() then
		if not self._intAnim then
			self._baseShowView:runStartAnim()

			self._intAnim = true
		end
	else
		self._intAnim = false
	end
end

function HeroShowMainMediator:refreshCurIndex()
	for i = 1, #self._list do
		if self._list[i].id == self._selectHeroId then
			self._curIdIndex = i

			break
		end
	end
end

function HeroShowMainMediator:refreshBg()
	local heroData = self._heroSystem:getHeroInfoById(self._selectHeroId)
	local bgPanel = self._mainPanel:getChildByFullName("animPanel")

	bgPanel:removeAllChildren()

	local bgAnim = self._heroSystem:getHeroBgAnim()

	if bgAnim then
		bgAnim:setVisible(true)
		bgAnim:changeParent(bgPanel)
		bgAnim:setScale(1)
	else
		local hero = self._heroSystem:getHeroById(self._selectHeroId)

		if hero then
			local var_27_0 = GameStyle:getHeroPartyByHeroInfo(hero)

			if not var_27_0 then
				var_27_0 = GameStyle:getHeroPartyBg(heroData.party)

				local bgAnim = var_27_0

				bgAnim:addTo(bgPanel):center(bgPanel:getContentSize())
			end
		end
	end

	self._heroSystem:setHeroBgAnim(nil)
end

function HeroShowMainMediator:onClickLeft()
	if not self._canChangeHero then
		return
	end

	self._equipSystem:resetOneKeyEquips()
	self._heroSystem:resetHeroStarUpItem()

	self._canChangeHero = false

	performWithDelay(self:getView(), function()
		self._canChangeHero = true
	end, 0.3)

	self._ignoreSoundEffect = false

	self:stopHeroEffect()

	self._curIdIndex = self._curIdIndex - 1

	if self._curIdIndex < 1 then
		self._curIdIndex = #self._list
	end

	local heroId = self._list[self._curIdIndex].id

	self._selectHeroId = heroId

	self._heroSystem:setUiSelectHeroId(heroId)

	self._isClick = true

	self:resetViews()
end

function HeroShowMainMediator:onClickRight()
	if not self._canChangeHero then
		return
	end

	self._equipSystem:resetOneKeyEquips()
	self._heroSystem:resetHeroStarUpItem()

	self._canChangeHero = false

	performWithDelay(self:getView(), function()
		self._canChangeHero = true
	end, 0.3)

	self._ignoreSoundEffect = false

	self:stopHeroEffect()

	self._curIdIndex = self._curIdIndex + 1

	if self._curIdIndex > #self._list then
		self._curIdIndex = 1
	end

	local heroId = self._list[self._curIdIndex].id

	self._selectHeroId = heroId

	self._heroSystem:setUiSelectHeroId(heroId)

	self._isClick = true

	self:resetViews()
end

function HeroShowMainMediator:onClickBack()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_heroShowMain_view")
	self._equipSystem:resetOneKeyEquips()
	self._heroSystem:resetHeroStarUpItem()
	self:stopHeroEffect()
	self:dismiss()
end

function HeroShowMainMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		for i, v in pairs(self._tabBtns) do
			local btn = self._tabBtns[i]

			storyDirector:setClickEnv("heroShowMain.tabbtn_" .. i, btn, function(sender, eventType)
				self._tabController:selectTabByTag(i)
			end)
		end

		if self._cacheViews[1] and self._cacheViews[1].mediator then
			local mediator = self._cacheViews[1].mediator
			local levelUpBtn = mediator:getView():getChildByFullName("mainpanel.levelNode.levelUpBtn")

			storyDirector:setClickEnv("heroShowMain.levelUpBtn", levelUpBtn, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)
				mediator:onClickLevelUpBtn()
			end)

			local infoNode = mediator._infoNode:getChildByFullName("nameBg.nameBg")

			storyDirector:setClickEnv("heroShowMain.infoNode", infoNode, nil)

			local infoPanel = mediator._infoPanel

			storyDirector:setClickEnv("heroShowMain.infoPanel", infoPanel, nil)

			local skillPanel = mediator._skillPanel

			storyDirector:setClickEnv("heroShowMain.skillPanel", skillPanel, nil)
		end

		if self._cacheViews[5] and self._cacheViews[5].mediator then
			local mediator = self._cacheViews[5].mediator
			local equipBtn = mediator._equipBtn

			storyDirector:setClickEnv("heroShowMain.equipBtn", equipBtn, function(sender, eventType)
				mediator:onClickEquip()
				storyDirector:notifyWaiting("click_heroShowMain_equipBtn")
			end)

			local equipNode1 = mediator:getView():getChildByFullName("mainpanel.equipPanel.node_1")

			storyDirector:setClickEnv("heroShowMain.equipNode1", equipNode1, function(sender, eventType)
				mediator:onClickEquipIcon(1)
				mediator:getView():runAction(cc.CallFunc:create(function()
					storyDirector:notifyWaiting("click_heroShowMain_equipNode1")
				end))
			end)

			local strengthenBtn = mediator._equipInfoView:getView():getChildByFullName("equipPanel.btnPanel.strengthenBtn")

			storyDirector:setClickEnv("heroShowMain.strengthenBtn", strengthenBtn, function(sender, eventType)
				mediator:onClickStrengthen()
			end)
		end

		if self._cacheViews[2] and self._cacheViews[2].mediator then
			local view2 = self._cacheViews[2].mediator
			local evolutionBtn = view2:getView():getChildByFullName("mainpanel.evelitionNode.evolutionpanel.evolutionbtn")

			storyDirector:setClickEnv("heroShowMain.evolutionBtn", evolutionBtn, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				view2:onEvolutionClicked()
			end)
		end

		if self._cacheViews[3] and self._cacheViews[3].mediator then
			local view3 = self._cacheViews[3].mediator
			local starbtn = view3:getView():getChildByFullName("mainpanel.starNode.costPanel.starbtn")

			storyDirector:setClickEnv("heroShowMain.starbtn", starbtn, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				view3:onUpStarClicked()
			end)

			local starCostPanel = view3:getView():getChildByFullName("mainpanel.starNode.costPanel")

			storyDirector:setClickEnv("heroShowMain.starCostPanel", starCostPanel, function(sender, eventType)
				return
			end)
		end

		if self._cacheViews[4] and self._cacheViews[4].mediator then
			local view4 = self._cacheViews[4].mediator
			local skillLevelBtn = view4:getView():getChildByFullName("mainpanel.skilllistpanel.detailPanel.levelBtn")

			storyDirector:setClickEnv("heroShowMain.skillLevelBtn", skillLevelBtn, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				view4:onClickLevelUpBtn()
			end)
		end

		local btnBack = self:getView():getChildByFullName("topinfo_node.back_btn")

		storyDirector:setClickEnv("heroShowMain.btnBack", btnBack, function(sender, eventType)
			self:onClickBack()
		end)
		storyDirector:notifyWaiting("enter_heroShowMain_view")
	end))

	self:getView():runAction(sequence)
end

function HeroShowMainMediator:stopHeroEffect()
	self._heroSystem:stopHeroEffect()

	for i, view in pairs(self._cacheViews) do
		if view and view.mediator and view.mediator.showDateToast then
			view.mediator:showDateToast()
		end
	end

	if self._heroEffectId then
		AudioEngine:getInstance():stopEffect(self._heroEffectId)

		self._heroEffectId = nil
	end
end
