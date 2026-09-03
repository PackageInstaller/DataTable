-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreMapAddPowerMediator.lua

ExploreMapAddPowerMediator = class("ExploreMapAddPowerMediator", DmPopupViewMediator, _M)

ExploreMapAddPowerMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreMapAddPowerMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreMapAddPowerMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {
	["main.bg_node.backBtn"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	},
	["main.tipBtn"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickTip"
	}
}

function ExploreMapAddPowerMediator:initialize()
	super.initialize(self)
end

function ExploreMapAddPowerMediator:dispose()
	super.dispose(self)
end

function ExploreMapAddPowerMediator:onRemove()
	super.onRemove(self)
end

function ExploreMapAddPowerMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SELL_ITEM_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_SETTEAM_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_ADDPOWER_SUCC, self, self.updateView)

	self._battleBtn = self:bindWidget("main.usePanel.battleBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickBattle, self)
		},
		btnSize = {
			width = 235,
			height = 115
		}
	})
	self._useBtn = self:bindWidget("main.usePanel.useBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickUse, self)
		},
		btnSize = {
			width = 235,
			height = 115
		}
	})
end

function ExploreMapAddPowerMediator:enterWithData(data)
	data = data or {}
	self._pointId = data.id or self._developSystem:getExplore():getCurPointId()
	self._hpMax = self._exploreSystem:getHpMax()
	self._gainHp = self._exploreSystem:getItemRecoverNum()
	self._useItem = self._exploreSystem:getCostItemMap()
	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()
	self._maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum", "content") + self._developSystem:getBuildingCardEffValue()

	self:updateData()
	self:initView()
	self:initUseView()
	self:initTeamList()
	self:updateView()
	self:updateTeam()
end

function ExploreMapAddPowerMediator:refreshView()
	self:updateData()
	self:updateView()
end

function ExploreMapAddPowerMediator:initView()
	self._main = self:getView():getChildByName("main")
	self._teamPanel = self._main:getChildByName("info_bg")
	self._iconPanel = self._main:getChildByName("iconPanel")
	self._usePanel = self._main:getChildByName("usePanel")
	self._teamStatus = self._iconPanel:getChildByFullName("teamStatus")
	self._emptyCell = self._main:getChildByName("emptyCell")

	self._emptyCell:setVisible(false)

	self._usingTip = self._main:getChildByName("usingTip")

	self._usingTip:setVisible(false)
	self:setEffect()
end

function ExploreMapAddPowerMediator:initUseView()
	local language = getCurrentLanguage()
	local desc = self._usePanel:getChildByFullName("desc")

	desc:setString("")
	desc:removeAllChildren()

	local str = Strings:get("EXPLORE_UI76", {
		main = self._gainHp.main,
		minor = self._gainHp.minor,
		fontName = TTF_FONT_FZYH_R
	})
	local descLabel = ccui.RichText:createWithXML(str, {})
	local width = desc:getContentSize().width

	if language ~= GameLanguageType.CN then
		width = width + 60
	end

	descLabel:renderContent(width, 0)
	descLabel:addTo(desc)
	descLabel:setAnchorPoint(cc.p(0, 1))
	descLabel:setPosition(cc.p(0, desc:getContentSize().height))

	if language ~= GameLanguageType.CN then
		descLabel:setVerticalSpace(-18)
	else
		descLabel:setVerticalSpace(8)
	end
end

function ExploreMapAddPowerMediator:initTeamList()
	local teamList = self._pointData:getTeams()

	for i = 1, #teamList do
		local teamPanel = self._teamPanel:getChildByFullName("team_" .. i)

		if teamPanel then
			teamPanel:setVisible(true)
			teamPanel:addClickEventListener(function()
				self:onClickTeamChoose(i)
			end)
		end
	end
end

function ExploreMapAddPowerMediator:initLockIcons()
	local lockDesc = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum_Desc", "content")
	local maxShowNum = 10

	for i = self._maxTeamPetNum + 1, maxShowNum do
		local iconBg = self._iconPanel:getChildByName("node_" .. i)
		local emptyIcon = self._emptyCell:clone()

		emptyIcon:setVisible(true)
		emptyIcon:addTo(iconBg)
		emptyIcon:setName("EmptyTip")

		local tipLabel = emptyIcon:getChildByFullName("text")

		tipLabel:setString(Strings:get(lockDesc[i]))
	end
end

function ExploreMapAddPowerMediator:updateData()
	self._pointData = self._exploreSystem:getMapPointObjById(self._pointId)
	self._currentTeamId = self._pointData:getCurrentTeamId() ~= "" and tonumber(self._pointData:getCurrentTeamId()) or 1
	self._currentTeam = self._pointData:getTeams()[self._currentTeamId]
end

function ExploreMapAddPowerMediator:updateView()
	local teamList = self._pointData:getTeams()

	for i = 1, #teamList do
		local team = teamList[i]
		local teamPanel = self._teamPanel:getChildByFullName("team_" .. i)

		if teamPanel then
			teamPanel:setVisible(true)

			local curHp = team:getHp()
			local loadingBar = teamPanel:getChildByFullName("loadingBar")

			loadingBar:setPercent(curHp / self._hpMax * 100)
			loadingBar:setScale9Enabled(true)
			loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

			local progress = teamPanel:getChildByFullName("progress")

			progress:setString(curHp .. "/" .. self._hpMax)

			local statusImg = teamPanel:getChildByFullName("statusImg")
			local status = self._exploreSystem:getHpBuff(curHp)

			if status == "" then
				statusImg:setVisible(false)
			else
				statusImg:setVisible(true)
				statusImg:loadTexture(status .. ".png", 1)
			end

			if self._currentTeamId == i then
				self._usingTip:changeParent(teamPanel):posite(44, 64)
				self._usingTip:setVisible(true)
			end
		end
	end

	local useItemNum = self._usePanel:getChildByFullName("useItemNum")

	if not useItemNum:getChildByFullName("UseIcon") then
		useItemNum:removeAllChildren()

		local icon = IconFactory:createItemPic({
			scaleRatio = 0.5,
			id = self._useItem
		})

		icon:setAnchorPoint(cc.p(1, 0.5))
		icon:addTo(useItemNum)
		icon:setPosition(cc.p(10, 17))
		icon:setName("UseIcon")
	end

	local count = self._exploreSystem:getItemCount(self._useItem)

	useItemNum:setString(count)

	if self._useBtn then
		self._useBtn:getButton():setGray(count == 0)
		self._useBtn:getButton():setTouchEnabled(count ~= 0)
	end

	self._teamStatus:setString("")
	self._teamStatus:removeAllChildren()

	local curHp = self._currentTeam:getHp()
	local _, desc = self._exploreSystem:getHpBuff(curHp)
	local str = Strings:get(desc, {
		fontName = TTF_FONT_FZYH_R
	})
	local descLabel = ccui.RichText:createWithXML(str, {})

	descLabel:addTo(self._teamStatus)
	descLabel:setAnchorPoint(cc.p(0, 0))
	descLabel:setPosition(cc.p(0, 0))
	ajustRichTextCustomWidth(descLabel, 685)
end

function ExploreMapAddPowerMediator:updateTeam()
	local teamList = self._pointData:getTeams()

	for i = 1, #teamList do
		local teamPanel = self._teamPanel:getChildByFullName("team_" .. i)

		if teamPanel then
			local select = i == self._currentTeamId

			teamPanel:getChildByFullName("selectImg"):setVisible(select)
		end
	end

	local heroes = self._currentTeam:getHeroes()

	for i = 1, self._maxTeamPetNum do
		local iconBg = self._iconPanel:getChildByName("node_" .. i)

		iconBg:removeChildByName("Icon")
		iconBg:setTag(i)

		local empty = iconBg:getChildByFullName("EmptyTip")

		if heroes[i] then
			if empty then
				empty:setVisible(false)
			end

			local heroInfo = self:getHeroInfoById(heroes[i])

			if heroInfo then
				local pet = IconFactory:createHeroLargeIcon(heroInfo, {
					hideStar = true,
					hideLevel = true,
					hideName = true
				})

				pet:setScale(0.64)
				pet:addTo(iconBg):offset(0, -10)
				pet:setName("Icon")
			end
		elseif empty then
			empty:setVisible(true)
		else
			local emptyIcon = self._emptyCell:clone()

			emptyIcon:setVisible(true)
			emptyIcon:addTo(iconBg)
			emptyIcon:setName("EmptyTip")

			local tipLabel = emptyIcon:getChildByFullName("text")

			tipLabel:setString("")
		end
	end

	local totalCost = 0
	local totalCombat = 0
	local averageCost = 0

	for k, v in pairs(heroes) do
		local heroInfo = self._heroSystem:getHeroById(v)

		totalCost = totalCost + heroInfo:getCost()
		totalCombat = totalCombat + heroInfo:getCombat()
	end

	local masterData = self._masterSystem:getMasterById(self._currentTeam:getMasterId())

	totalCombat = masterData and totalCombat + masterData:getCombat() or totalCombat
	averageCost = #heroes == 0 and 0 or math.floor(totalCost * 10 / #heroes + 0.5) / 10

	local combatLabel = self._iconPanel:getChildByFullName("combatLabel")

	combatLabel:setString(totalCombat)

	local cost = self._iconPanel:getChildByFullName("cost")
	local cost1 = self._iconPanel:getChildByFullName("cost_1")
	local cost2 = self._iconPanel:getChildByFullName("cost_2")

	cost:setString(totalCost)
	cost2:setString(averageCost)
	cost1:setString("/" .. self._costMaxNum)

	if getCurrentLanguage() ~= GameLanguageType.CN then
		cost2:setFontSize(24)
		cost1:setFontSize(25)
		cost:setFontSize(28)
	end

	if self._battleBtn then
		-- block empty
	end
end

function ExploreMapAddPowerMediator:getHeroInfoById(id)
	local heroInfo = self._heroSystem:getHeroById(id)

	if not heroInfo then
		return nil
	end

	return {
		id = heroInfo:getId(),
		level = heroInfo:getLevel(),
		star = heroInfo:getStar(),
		quality = heroInfo:getQuality(),
		rarity = heroInfo:getRarity(),
		qualityLevel = heroInfo:getQualityLevel(),
		name = heroInfo:getName(),
		roleModel = heroInfo:getModel(),
		type = heroInfo:getType(),
		cost = heroInfo:getCost()
	}
end

function ExploreMapAddPowerMediator:setEffect()
	GameStyle:setCommonOutlineEffect(self._teamPanel:getChildByFullName("team_1.progress"), 154)
	GameStyle:setCommonOutlineEffect(self._teamPanel:getChildByFullName("team_2.progress"), 154)
	GameStyle:setCommonOutlineEffect(self._teamPanel:getChildByFullName("team_3.progress"), 154)
	GameStyle:setCommonOutlineEffect(self._usePanel:getChildByFullName("useItemNum"), 154)
	GameStyle:setCommonOutlineEffect(self._emptyCell:getChildByFullName("text"))

	local combatLabel1 = self._iconPanel:getChildByFullName("combatLabel")
	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}

	combatLabel1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	GameStyle:setCommonOutlineEffect(self._iconPanel:getChildByFullName("text"))
	GameStyle:setCommonOutlineEffect(self._iconPanel:getChildByFullName("text1"))
	GameStyle:setCommonOutlineEffect(self._iconPanel:getChildByFullName("cost"))
	GameStyle:setCommonOutlineEffect(self._iconPanel:getChildByFullName("cost_1"))
	GameStyle:setCommonOutlineEffect(self._iconPanel:getChildByFullName("cost_2"))
	GameStyle:setCommonOutlineEffect(self._iconPanel:getChildByFullName("teamStatus"))
end

function ExploreMapAddPowerMediator:onClickClose(sender, eventType)
	self:close()
end

function ExploreMapAddPowerMediator:onClickUse()
	if self._currentTeam:getHp() >= self._hpMax then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("EXPLORE_UI44")
		}))

		return
	end

	self._exploreSystem:requestUseHpItem(nil, {
		mainId = tostring(self._currentTeamId)
	})
end

function ExploreMapAddPowerMediator:onClickBattle()
	AudioTimerSystem:playStartBattleVoice(self._currentTeam)
	AudioEngine:getInstance():playEffect("Se_Click_Battle", false)
	self._exploreSystem:requestSetCurTeam(function()
		return
	end, {
		teamId = tostring(self._currentTeamId)
	})
end

function ExploreMapAddPowerMediator:onClickTeamChoose(teamId)
	self._currentTeamId = teamId
	self._currentTeam = self._pointData:getTeams()[self._currentTeamId]

	self:updateTeam()
end

function ExploreMapAddPowerMediator:onClickTip()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Map_Team_Rule", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end

function ExploreMapAddPowerMediator:onTouchMaskLayer()
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self:close()
end
