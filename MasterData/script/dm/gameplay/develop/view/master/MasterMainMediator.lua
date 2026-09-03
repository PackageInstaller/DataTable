-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterMainMediator.lua

MasterMainMediator = class("MasterMainMediator", DmAreaViewMediator, _M)

MasterMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MasterMainMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
MasterMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
MasterMainMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")
MasterMainMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")
MasterMainMediator:has("_soundId", {
	is = "rw"
})
MasterMainMediator:has("_heroEffectId", {
	is = "rw"
})
MasterMainMediator:has("_ignoreSoundEffect", {
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
		viewName = "MasterCultivateView",
		unlockKey = "",
		tabName = Strings:get("heroshow_UI13"),
		tabName1 = Strings:get("UITitle_EN_Shuxing")
	},
	{
		unlockKey = "Master_Skill",
		switchKey = "fn_master_skill",
		viewName = "MasterSkillView",
		tabName = Strings:get("heroshow_UI8"),
		tabName1 = Strings:get("UITitle_EN_Jineng"),
		bg2Size = cc.size(1318, 333),
		bg2PosY = cc.p(954, 48)
	},
	{
		unlockKey = "LeadStage",
		switchKey = "fn_master_leadStage",
		viewName = "MasterLeadStageView",
		tabName = Strings:get("LeadStage_SystemName"),
		tabName1 = Strings:get("LeadStage_EnglishName")
	},
	{
		unlockKey = "Master_Equip",
		switchKey = "fn_master_equip",
		viewName = "MasterEmblemView",
		tabName = Strings:get("MasterEmblem_Entrance"),
		tabName1 = Strings:get("UITitle_EN_Guanghuan"),
		bg2Size = cc.size(1318, 333),
		bg2PosY = cc.p(948, 69)
	}
}
local kBtnHandlers = {}

function MasterMainMediator:initialize()
	super.initialize(self)
end

function MasterMainMediator:dispose()
	self:getView():stopAllActions()

	self._viewClose = true

	if self._tabController then
		self._tabController:dispose()

		self._tabController = nil
	end

	super.dispose(self)
end

function MasterMainMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LEADSTASGE_SWITCH_HERO, self, self.switchHero)
end

function MasterMainMediator:enterWithData(data)
	self._masterNodes = {}
	self._showMasterList = self._masterSystem:getShowMasterList()

	local var_4_0

	if data then
		if data.tabType then
			var_4_0 = data.tabType

			if not data.tabType then
				var_4_0 = 1

				goto label_4_0
			end
		end
	end

	::label_4_0::

	self._tabType = 1

	if data then
		local var_4_1

		if data.id then
			var_4_1 = tostring(data.id) or self._showMasterList[1]:getId() or self._showMasterList[1]:getId()
		end
	end

	self._selectedMasterId = var_4_1
	self._curMasterList = {}

	if self._tabType == 1 then
		table.copy(self._showMasterList, self._curMasterList)
	else
		for i = 1, #self._showMasterList do
			local master = self._showMasterList[i]

			if not master:getIsLock() then
				table.insert(self._curMasterList, master)
			end
		end
	end

	self:setupTopInfoWidget()
	self:initNodes()
	self:createTabController()
	self:initMasterView()
	self:resetViews()
	self:setupClickEnvs()
end

function MasterMainMediator:resumeWithData()
	if self._viewClose then
		return
	end

	self._initTouchSlide = false

	self:updateData()
	self:refreshTabBtn()
end

function MasterMainMediator:refreshWithData()
	if self._viewClose then
		return
	end

	self:updateData()
	self:resetViews(true)
	self._masterView:reloadData()
end

function MasterMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Quality")
	local config = {
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
		},
		title = Strings:get("Master_Title_Hero")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function MasterMainMediator:initNodes()
	self._changeAnim = self:getView():getChildByFullName("animNode_0")
	self._mainPanel = self:getView():getChildByFullName("main")
	self._animNode = self:getView():getChildByFullName("animNode")
	self._tabClone = self:getView():getChildByFullName("tabClone")

	self._tabClone:setVisible(false)

	self._masterBustPanel = self:getView():getChildByFullName("masterBustPanel")
	self._masterPanel = self._masterBustPanel:getChildByFullName("masterPanel")
	self._masterClone = self._masterBustPanel:getChildByFullName("cellClone")

	self._masterClone:setVisible(false)
	self._tabClone:getChildByFullName("dark_1.text1"):enableOutline(cc.c4b(3, 1, 4, 51), 1)
	self._tabClone:getChildByFullName("dark_1.text1"):setColor(cc.c3b(110, 108, 108))
	self._tabClone:getChildByFullName("dark_1.text1"):enableShadow(cc.c4b(3, 1, 4, 25.5), cc.size(1, 0), 1)
	self._tabClone:getChildByFullName("light_1.text1"):enableOutline(cc.c4b(3, 1, 4, 51), 1)
	self._tabClone:getChildByFullName("light_1.text1"):setColor(cc.c3b(110, 108, 108))
	self._tabClone:getChildByFullName("light_1.text1"):enableShadow(cc.c4b(3, 1, 4, 25.5), cc.size(1, 0), 1)

	self._cellWidth = self._masterPanel:getContentSize().width

	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	self._masterPanel:setContentSize(cc.size(self._cellWidth, winSize.height - 65))
end

function MasterMainMediator:updateData(data)
	self._showMasterList = self._masterSystem:getShowMasterList()
	self._selectedMasterId = self._selectedMasterId or self._showMasterList[1]:getId()
	self._curMasterList = {}

	if self._tabType == 1 then
		table.copy(self._showMasterList, self._curMasterList)
	else
		for i = 1, #self._showMasterList do
			local master = self._showMasterList[i]

			if not master:getIsLock() then
				table.insert(self._curMasterList, master)
			end
		end
	end
end

function MasterMainMediator:initTabBtn()
	self._tabBtns = self._tabBtns or {}

	for i, v in pairs(self._tabBtns) do
		self._tabBtns[i]:removeFromParent()

		self._tabBtns[i] = nil
	end

	self._cacheViewsName = {}
	self._cacheViews = {}
	self._ignoreSound = true
	self._invalidBtns = {}

	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local index = 0

	for i = 1, #kTabBtnData do
		if not kTabBtnData[i].switchKey or systemKeeper:canShow(kTabBtnData[i].unlockKey) then
			local data = kTabBtnData[i]
			local unlockKey = data.unlockKey
			local tabName = data.tabName
			local viewName = data.viewName
			local result, tip = systemKeeper:canShow(unlockKey)

			if kTabBtnData[i].switchKey and not CommonUtils.GetSwitch(kTabBtnData[i].switchKey) then
				result = false
			end

			if (i == 1 or nil) and true then
				index = index + 1

				local btn = self._tabClone:clone()

				btn:setVisible(true)
				btn:addTo(self:getView():getChildByFullName("right_node"))
				btn:getChildByFullName("dark_1.text"):setString(tabName)
				btn:getChildByFullName("light_1.text"):setString(tabName)

				if btn:getChildByFullName("dark_1.text1") then
					btn:getChildByFullName("dark_1.text1"):setString("")
					btn:getChildByFullName("light_1.text1"):setString("")
				end

				btn:setVisible(true)
				btn:setTag(i)

				btn.trueIndex = index

				if unlockKey == "Master_StarUp" then
					local node = RedPoint:createDefaultNode()
					local redPoint = RedPoint:new(node, btn, function()
						return self._masterSystem:isStarUpgradable(self:getSelectedMasterData())
					end)

					redPoint:getView():setAnchorPoint(cc.p(1, 1))
					redPoint:getView():setPosition(cc.p(51, 106))
					redPoint:getView():setTag(12138)
					redPoint:getView():setLocalZOrder(999)
					redPoint:getView():setRotation(-45)

					btn.redPoint = redPoint
				elseif unlockKey == "LeadStage" then
					local node = RedPoint:createDefaultNode()
					local redPoint = RedPoint:new(node, btn, function()
						return self._masterSystem:checkLeadStageRedPoint(self._selectedMasterId)
					end)

					redPoint:getView():setAnchorPoint(cc.p(1, 1))
					redPoint:getView():setPosition(cc.p(51, 106))
					redPoint:getView():setTag(12138)
					redPoint:getView():setLocalZOrder(999)
					redPoint:getView():setRotation(-45)

					btn.redPoint = redPoint
				end

				self._tabBtns[i] = btn
				self._cacheViewsName[i] = viewName

				local result, tip = systemKeeper:isUnlock(unlockKey)

				btn.tip = nil

				if not result then
					btn.tip = tip

					btn:setGray(true)

					self._invalidBtns[i] = btn
				end
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

function MasterMainMediator:getSelectedMasterData()
	return self._masterSystem:getMasterById(self._selectedMasterId)
end

function MasterMainMediator:createTabController()
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

function MasterMainMediator:refreshTabBtn()
	for i, v in pairs(self._cacheViews) do
		self._cacheViews[i]:removeFromParent()

		self._cacheViews[i] = nil
	end

	self:initTabBtn()
	self._tabController:refreshView(self._tabBtns)
	self._tabController:selectTabByTag(self._tabType)
end

function MasterMainMediator:getAnimNode()
	return self._changeAnim
end

function MasterMainMediator:resetViews(hideAnim)
	self:refreshBgSize()

	if not self._cacheViews[self._tabType] then
		local view = self:getInjector():getInstance(self._cacheViewsName[self._tabType])

		if view then
			view:addTo(self._mainPanel):center(self._mainPanel:getContentSize())
			AdjustUtils.adjustLayoutUIByRootNode(view)
			view:setLocalZOrder(2)

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				view.mediator = mediator

				mediator:setupView(self, {
					id = self._selectedMasterId
				})
			end

			self._cacheViews[self._tabType] = view
		end
	end

	for i, view in pairs(self._cacheViews) do
		if view and view.mediator then
			view:setVisible(self._tabType == i)

			if view:isVisible() then
				view.mediator:refreshData(self._selectedMasterId)
				view.mediator:refreshAllView(hideAnim)

				if self._isClick then
					view.mediator:runStartAction()

					self._isClick = false
				end
			end
		end
	end

	local master = self._masterSystem:getMasterById(self._selectedMasterId)
	local showTab = not master:getIsLock()

	self:getView():getChildByFullName("right_node"):setVisible(showTab)
	self:refreshRightBtnRedpoint()
end

function MasterMainMediator:refreshBgSize()
	local tabNum = #kTabBtnData

	self._masterBustPanel:setVisible(self._tabType ~= tabNum)

	local isShow = self._tabType ~= 1 and self._tabType ~= 3

	self._mainPanel:getChildByFullName("bg1"):setVisible(isShow)
	self._mainPanel:getChildByFullName("bg2"):setVisible(isShow)

	local leftPanelPosX = self._masterBustPanel:getPositionX()
	local leftPanelWidth = self._masterBustPanel:getContentSize().width
	local bg1 = self._mainPanel:getChildByFullName("bg1")
	local bg2 = self._mainPanel:getChildByFullName("bg2")

	if bg1:isVisible() then
		local posY = self._tabType == tabNum and -4 or -8
		local height = self._tabType == tabNum and 573 or 552

		bg1:setPositionY(posY)
		bg1:setContentSize(cc.size((self._tabType ~= tabNum or nil) and bg1:getPositionX() - leftPanelPosX - leftPanelWidth, height))

		local size = kTabBtnData[self._tabType].bg2Size
		local pos = kTabBtnData[self._tabType].bg2PosY

		if size then
			bg2:setPosition(pos)
			bg2:setContentSize(cc.size((self._tabType ~= tabNum or nil) and bg2:getPositionX() - leftPanelPosX - leftPanelWidth, size.height))
		end
	end
end

function MasterMainMediator:initMasterView()
	local height = self._masterClone:getContentSize().height

	local function scrollViewDidScroll(view)
		self._isReturn = false
	end

	local function cellSizeForTable(table, idx)
		return self._cellWidth, height
	end

	local function numberOfCellsInTableView(table)
		return #self._curMasterList
	end

	local function tableCellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local node = self._masterClone:clone()

			node:setVisible(false)
			node:addTo(cell):posite(0, 0)
			node:setTag(12345)
		end

		self:createCell(cell, index)

		return cell
	end

	local tableView = cc.TableView:create(self._masterPanel:getContentSize())

	self._masterView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._masterPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
end

function MasterMainMediator:createCell(cell, index)
	local node = cell:getChildByTag(12345)

	node:setVisible(true)

	local basePanel = node:getChildByFullName("basePanel")
	local master = self._curMasterList[index]
	local icon = basePanel:getChildByFullName("icon")

	icon:removeAllChildren()

	local image = IconFactory:createRoleIconSpriteNew({
		iconType = "MasterHeadWide",
		id = master:getModel()
	})

	image:addTo(icon):center(icon:getContentSize())

	local unlock = not master:getIsLock()
	local saturation = unlock and 0 or -100

	basePanel:getChildByFullName("icon"):setSaturation(saturation)

	local select = master:getId() == self._selectedMasterId
	local scale = select and 1.15 or 1
	local posX = select and -10 or 0

	basePanel:setScale(scale)
	basePanel:setPositionX(posX)

	local isActivity = self._masterSystem:canMasterActive(master)
	local animNode = node:getChildByFullName("animNode")

	if isActivity then
		local anim = animNode:getChildByName("zhaohuantishi")

		if anim == nil then
			anim = cc.MovieClip:create("dh_zhaohuantishi")

			anim:setName("zhaohuantishi")
			anim:setAnchorPoint(0.5, 0.5)
			anim:addEndCallback(function()
				anim:stop()
			end)
			anim:setScale(0.7)
			anim:addTo(animNode)
		end

		if select then
			animNode:setPosition(182, 30.5)
		else
			animNode:setPosition(172, 34.5)
		end

		animNode:setVisible(true)
	else
		animNode:setVisible(false)
	end

	node:getChildByFullName("selectImage"):setVisible(select)
	basePanel:setVisible(true)
	basePanel:setTouchEnabled(true)
	basePanel:setSwallowTouches(false)
	basePanel:addTouchEventListener(function(sender, eventType)
		self:onTouchBottomClicked(sender, eventType, index)
	end)
	cell:removeChildByName("redPoint")

	local node = RedPoint:createDefaultNode()
	local redPoint = RedPoint:new(node, cell, function()
		return self._masterSystem:isStarUpgradable(master) or self._masterSystem:checkLeadStageRedPoint(master:getId())
	end)

	redPoint:getView():setAnchorPoint(cc.p(1, 1))

	if select then
		redPoint:getView():setPosition(cc.p(197, 100))
	else
		redPoint:getView():setPosition(cc.p(187, 96))
	end

	redPoint:getView():setTag(12138)
	redPoint:getView():setLocalZOrder(999)
	redPoint:getView():setName("redPoint")
end

function MasterMainMediator:showCombatAnim(preCombat, pos)
	self._animNode:setPosition(pos)

	if not self._animNode:getChildByFullName("CombatAnim") then
		local combatAnim = cc.MovieClip:create("zhandouli_yinglingzhuangbei")

		combatAnim:addTo(self._animNode)
		combatAnim:setName("CombatAnim")
		combatAnim:addEndCallback(function()
			combatAnim:setVisible(false)
			combatAnim:gotoAndStop(0)
		end)
		combatAnim:setVisible(false)

		local panel = combatAnim:getChildByName("combat")
		local combatStr1 = cc.Label:createWithTTF(Strings:get("Strenghten_Text156"), CUSTOM_TTF_FONT_1, 24)

		combatStr1:setAnchorPoint(cc.p(0, 0.5))
		combatStr1:addTo(panel)
		combatStr1:setPosition(cc.p(-105, 3))
		combatStr1:setName("combatStr1")

		local combatStr = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 24)

		combatStr:setAnchorPoint(cc.p(0, 0.5))
		combatStr:addTo(panel)
		combatStr:setPosition(cc.p(combatStr1:getPositionX() + combatStr1:getContentSize().width + 8, 1))
		combatStr:setName("combatStr")
		GameStyle:setGoldCommonEffect(combatStr1, true)
		GameStyle:setGoldCommonEffect(combatStr, true)

		local posX = 200 - (combatStr1:getContentSize().width + combatStr:getContentSize().width + 8) / 2

		combatAnim:setPosition(cc.p(posX, -10))
	end

	if preCombat then
		local mastermodel = self:getSelectedMasterData()
		local combat, attrData = mastermodel:getCombat()

		self._animNode:removeChildByName("combatAddAnim")

		local combatAnim = self._animNode:getChildByName("CombatAnim")

		combatAnim:setVisible(true)
		combatAnim:gotoAndPlay(0)

		local panel = combatAnim:getChildByName("combat")
		local combatStr1 = panel:getChildByName("combatStr1")
		local combatStr = panel:getChildByName("combatStr")

		combatStr:setString(combat)

		local posX = 200 - (combatStr1:getContentSize().width + combatStr:getContentSize().width + 8) / 2

		combatAnim:setPosition(cc.p(posX, -10))

		local combatAdd = combat - preCombat

		if combatAdd > 0 then
			local combatAddAnim = cc.MovieClip:create("shuzi_yinglingzhuangbei")

			combatAddAnim:gotoAndPlay(0)
			combatAddAnim:addTo(self._animNode)
			combatAddAnim:setName("combatAddAnim")
			combatAddAnim:addCallbackAtFrame(30, function()
				combatAddAnim:removeFromParent()
			end)

			local posX = 100 + (combatStr1:getContentSize().width + combatStr:getContentSize().width + 8) / 2

			combatAddAnim:setPosition(cc.p(posX, -20))

			local panel = combatAddAnim:getChildByName("num")
			local num = cc.Label:createWithTTF("+" .. combatAdd, TTF_FONT_FZYH_M, 24)

			num:setAnchorPoint(cc.p(0, 0.5))
			num:addTo(panel)
			num:setPosition(0, 1)
			GameStyle:setGreenCommonEffect(num, true)
		end
	end
end

local dragType = {
	kDragRight = 2,
	kDragLeft = 1,
	kDragNo = 0
}

function MasterMainMediator:initTouchSlide()
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
					view:onClickHelp()
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

function MasterMainMediator:checkTouchType(pos1, pos2)
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

function MasterMainMediator:refreshRightBtnRedpoint()
	for i = 1, #self._tabBtns do
		if self._tabBtns[i] and self._tabBtns[i].redPoint then
			self._tabBtns[i].redPoint:refresh()
		end
	end
end

function MasterMainMediator:onClickTab(name, tag)
	if self._invalidBtns[tag] then
		self:dispatch(ShowTipEvent({
			tip = self._invalidBtns[tag].tip
		}))

		return
	end

	if tag ~= self._tabType then
		self._masterSystem:setDoStageLvUpAnim(false)
	end

	self._tabType = tag
	self._isClick = true

	if not self._ignoreSound then
		self._ignoreSoundEffect = false

		AudioEngine:getInstance():playEffect("Se_Click_Tab_5", false)
	else
		self._ignoreSound = false
	end

	if not self._ignoreRefresh then
		self:updateData()
		self:resetViews()
		self._masterView:reloadData()
	else
		self._ignoreRefresh = false
	end

	if self._tabType == 3 then
		AudioEngine:getInstance():playBackgroundMusic("Mus_Protagonist_Stage")
	else
		local bgImageId = self._settingSystem:getHomeBgId()
		local BGM = ConfigReader:getDataByNameIdAndKey("HomeBackground", bgImageId, "BGM")

		AudioEngine:getInstance():playBackgroundMusic(BGM)
	end
end

function MasterMainMediator:onTouchBottomClicked(sender, eventType, index)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		if self._curMasterList[index] and self._curMasterList[index]:getId() == self._selectedMasterId then
			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

		self._isClick = true
		self._selectedMasterId = self._curMasterList[index]:getId()

		self:updateData()
		self:resetViews()
		self._masterView:reloadData()
	end
end

function MasterMainMediator:switchHero(event)
	self._selectedMasterId = event:getData()

	self:updateData()
	self:resetViews()
	self._masterView:reloadData()
end

function MasterMainMediator:onClickBack()
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function MasterMainMediator:setupClickEnvs()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local starLvUpBtn = self._tabBtns[2]

	if starLvUpBtn then
		storyDirector:setClickEnv("MasterCultivateMediator.tabBtn_2", starLvUpBtn, function(sender, eventType)
			self:onClickTab("tabClone", 2)
		end)
	end

	local leaderStageBtn = self._tabBtns[3]

	if leaderStageBtn then
		storyDirector:setClickEnv("MasterCultivateMediator.tabBtn_4", leaderStageBtn, function(sender, eventType)
			self:onClickTab("tabClone", 3)
		end)
	end

	local tabNum = #self._tabBtns
	local auraLvUpBtn = self._tabBtns[tabNum]

	if auraLvUpBtn then
		storyDirector:setClickEnv("MasterCultivateMediator.tabBtn_3", auraLvUpBtn, function(sender, eventType)
			self:onClickTab("tabClone", tabNum)
		end)
	end
end
