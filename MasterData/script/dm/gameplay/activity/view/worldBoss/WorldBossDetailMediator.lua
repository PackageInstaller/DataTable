-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/worldBoss/WorldBossDetailMediator.lua

WorldBossDetailMediator = class("WorldBossDetailMediator", DmPopupViewMediator, _M)

WorldBossDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WorldBossDetailMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
WorldBossDetailMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {
	["main.rightPanel.challenge_btn"] = {
		ignoreClickAudio = true,
		func = "onClickChallenge"
	},
	["main.rightPanel.Panel_buff"] = {
		ignoreClickAudio = true,
		func = "onClickBuff"
	},
	["main.rightPanel.addbtn"] = {
		ignoreClickAudio = true,
		func = "onClickBuyTimes"
	}
}
local kPartyIcon = {
	BSNCT = "asset/heroRect/heroForm/sl_businiao.png",
	MNJH = "asset/heroRect/heroForm/sl_smzs.png",
	DWH = "asset/heroRect/heroForm/sl_dongwenhui.png",
	XD = "asset/heroRect/heroForm/sl_seed.png",
	UNKNOWN = "asset/heroRect/heroForm/sl_unknown.png",
	WNSXJ = "asset/heroRect/heroForm/sl_weinasi.png",
	SSZS = "asset/heroRect/heroForm/sl_shimengzhishe.png"
}

function WorldBossDetailMediator:initialize()
	super.initialize(self)
end

function WorldBossDetailMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function WorldBossDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function WorldBossDetailMediator:enterWithData(data)
	self._data = data
	self._enterBattle = false
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)
	self._pointType = data.pointType
	self._pointId = self._activity:getPointIdByType(self._pointType)
	self._pointConfig = ConfigReader:getRecordById("WolrdBossBlockBattle", self._pointId)
	self._masterSystem = self._developSystem:getMasterSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._buffList = self._activity:getBuffOpenTime()

	self:glueFieldAndUi()
	self:setupView()
	self:initAnim()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ARENA_CHANGE_TEAM_SUCC, self, self.changeTeamSuc)
end

function WorldBossDetailMediator:glueFieldAndUi()
	local view = self:getView()

	self._main = view:getChildByFullName("main")

	local function callFunc()
		self:onClickBack()
	end

	local touchView = self._main:getChildByName("touchPanel")

	mapButtonHandlerClick(nil, touchView, {
		clickAudio = "Se_Click_Close_2",
		func = callFunc
	})

	self._rightPanel = self._main:getChildByFullName("rightPanel")

	self._rightPanel:setLocalZOrder(101)

	self._combatPanel = self._rightPanel:getChildByFullName("Panel_combat")
	self._challengeBtn = self._rightPanel:getChildByFullName("challenge_btn")
	self._teamPanel = self._rightPanel:getChildByName("Panel_team")
	self._teamCombatPanel = self._rightPanel:getChildByName("team_combat")
	self._titleLabel = self._rightPanel:getChildByFullName("title_text")
	self._rolePanel = self._main:getChildByName("bg_renwu")
	self._descPanel = self._rightPanel:getChildByFullName("Panel_desc")
	self._informationPanel = self._rightPanel:getChildByFullName("Panel_information")
	self._informationClone = self._rightPanel:getChildByFullName("Panel_3")

	self._informationClone:setVisible(false)

	self._buffPanel = self._rightPanel:getChildByName("Panel_buff")

	local function callFunc(sender, eventType)
		self:onClickTeam()
	end

	mapButtonHandlerClick(nil, self._teamPanel, {
		func = callFunc
	})
end

function WorldBossDetailMediator:initAnim()
	local mc = cc.MovieClip:create("guankaxiangqing_zhuxianguanka_UIjiaohudongxiao")

	mc:addCallbackAtFrame(30, function()
		mc:stop()
	end)
	mc:stop()
	mc:addTo(self._main)
	mc:setPosition(cc.p(568, 320))
	mc:setLocalZOrder(100)
	mc:addCallbackAtFrame(21, function()
		local btnAnim = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

		btnAnim:setScale(0.8)
		btnAnim:addTo(mc)
		btnAnim:setPosition(cc.p(443.5, -83))
		btnAnim:setOpacity(0)
		btnAnim:runAction(cc.FadeIn:create(0.5))

		self._challengeAnim = btnAnim

		local act = cc.Sequence:create(cc.DelayTime:create(0.4375), cc.FadeIn:create(0.3125))

		self._challengeBtn:runAction(act:clone())
		self._challengeBtn:changeParent(self._challengeAnim)
		self._challengeBtn:center(self._challengeAnim:getContentSize())
	end)

	local starMc = mc:getChildByName("stardi")

	starMc:removeAllChildren()

	local teamMc = mc:getChildByFullName("team")

	self._teamPanel:changeParent(teamMc):center(teamMc:getContentSize())

	local descMc = mc:getChildByFullName("desc")

	self._descPanel:changeParent(descMc)
	self._descPanel:setPosition(cc.p(-213, -63))

	local titleMc = mc:getChildByFullName("title")

	self._titleLabel:changeParent(titleMc)
	self._titleLabel:setPosition(cc.p(120, 4))

	local teamCombatPanel = mc:getChildByFullName("teamCombat")

	self._teamCombatPanel:changeParent(teamCombatPanel):center(teamCombatPanel:getContentSize())

	local heroRole = mc:getChildByFullName("hero")

	self._rolePanel:changeParent(heroRole)
	self._challengeBtn:setOpacity(0)
	mc:gotoAndPlay(1)

	local originX, originY = self._informationPanel:getPosition()

	self._informationPanel:setPositionX(originX + 400)
	self._informationPanel:runAction(cc.MoveTo:create(0.3, cc.p(originX, originY)))

	local originX, originY = self._buffPanel:getPosition()

	self._buffPanel:setPositionX(originX + 400)
	self._buffPanel:runAction(cc.MoveTo:create(0.3, cc.p(originX, originY)))

	self._mainAnim = mc
end

function WorldBossDetailMediator:addContent(content, listView)
	local textData = string.split(content, "<font")

	if #textData <= 1 then
		content = string.format("<font face='asset/font/CustomFont_FZYH_M.TTF' size='18' color='#D2D2D2'>%s</font>", content)
	end

	local layout = ccui.Layout:create()
	local context = ccui.RichText:createWithXML("", {})

	context:setString(content)
	context:setAnchorPoint(cc.p(0, 1))
	context:renderContent(405, 0, true)

	local length = context:getContentSize().height + 10

	context:addTo(layout):posite(0, length)
	layout:setContentSize(cc.size(listView:getContentSize().width, length))
	listView:pushBackCustomItem(layout)
end

function WorldBossDetailMediator:setupView()
	self._rolePanel:removeAllChildren()

	local pointHead = self._pointConfig.PointHead
	local heroSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = pointHead
	})

	heroSprite:addTo(self._rolePanel):setTag(951)
	heroSprite:setScale(0.92)
	heroSprite:setPosition(cc.p(88, 0))
	self._titleLabel:setString(Strings:get(self._pointConfig.Name))
	self:refreshTimes()
	self:changeTeamSuc()

	local descListView = self._descPanel:getChildByName("ListView")

	self:addContent(Strings:get(self._pointConfig.Desc), descListView)

	if not self._pointConfig.BlockInformation then
		local information = {}

		self._informationPanel:setVisible(next(information) ~= nil)

		if next(information) then
			local listView = self._informationPanel:getChildByName("ListView")

			listView:setScrollBarEnabled(false)
			listView:setVisible(next(information.SpecialRule or {}) ~= nil)
			listView:removeAllChildren()

			for i, v in ipairs(information.SpecialRule or {}) do
				local clone = self._informationClone:clone()

				clone:setVisible(true)
				listView:pushBackCustomItem(clone)

				local config = ConfigReader:getRecordById("PicGuide", v)

				clone:getChildByName("Text_title"):setString(Strings:get(config.Name))

				local img = clone:getChildByName("Image_12")

				img:ignoreContentAdaptWithSize(false)
				img:loadTexture(config.Icon .. ".png", ccui.TextureResType.plistType)

				local function callFunc()
					self:clickSpecialRule(v)
				end

				mapButtonHandlerClick(nil, clone:getChildByName("Image_11"), {
					clickAudio = "Se_Click_Select_1",
					func = callFunc
				})
			end
		end

		self:checkBuff()
	end
end

function WorldBossDetailMediator:refreshTimes()
	local remainTimes = self._rightPanel:getChildByName("remainTimes")

	remainTimes:setString(Strings:get("Activity_Darts_Residualtimes") .. tostring(self._activity:getFightTimes(self._pointType)))

	local addBtn = self._rightPanel:getChildByName("addbtn")

	addBtn:setVisible(self._activity:isCanBuyTimes(self._pointType))
end

function WorldBossDetailMediator:refreshTeamView()
	local developSystem = self:getInjector():getInstance("DevelopSystem")
	local team = self._activity:getTeam()
	local curCombat = team:getCombat()
	local teamCombatText = self._teamCombatPanel:getChildByName("combat_text")

	teamCombatText:setString(curCombat)
	self._teamPanel:getChildByName("teamName"):setString(team:getName())

	local masterSystem = developSystem:getMasterSystem()
	local masterData = masterSystem:getMasterById(team:getMasterId())
	local roleModel = masterData:getModel()
	local masterIcon = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe4_4",
		id = roleModel
	})
	local masterPanel = self._teamPanel:getChildByName("masterIcon")

	masterPanel:removeAllChildren()
	masterIcon:addTo(masterPanel):center(masterPanel:getContentSize())
end

function WorldBossDetailMediator:checkBuff()
	if self._timer then
		return
	end

	local function checkTimeFunc()
		local curTime = self._gameServerAgent:remoteTimestamp()
		local hasBuff = false

		for i, v in pairs(self._buffList) do
			if curTime > v.startTime and curTime < v.endTime and self._activity:isPointCanChallenge(v.pointType) then
				hasBuff = true
				self._buffIndex = i

				break
			end
		end

		self._buffPanel:setVisible(hasBuff)
		self:refreshBuffPanel()
	end

	self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

	checkTimeFunc()
end

function WorldBossDetailMediator:refreshBuffPanel()
	if self._buffPanel:isVisible() then
		local iconNode = self._buffPanel:getChildByName("icon")

		iconNode:removeAllChildren()

		local buffData = self._buffList[self._buffIndex]
		local count = 0

		if buffData.HeroId then
			for i, v in pairs(buffData.HeroId) do
				count = count + 1

				local icon = IconFactory:createHeroIconForReward({
					star = 0,
					id = v
				})

				icon:addTo(iconNode):posite(33 + (count - 1) * 70, 30)
				icon:setScale(0.5)

				local image = ccui.ImageView:create("jjc_bg_ts_new.png", 1)

				image:addTo(icon):posite(92, 20):setScale(1.2)
			end
		end

		if buffData.Party then
			for i, v in pairs(buffData.Party) do
				count = count + 1

				local icon = ccui.ImageView:create(kPartyIcon[v])

				icon:addTo(iconNode):posite(33 + (count - 1) * 70, 30)
			end
		end

		local diImg = self._buffPanel:getChildByName("Image_1")

		diImg:setContentSize(cc.size(count * 70 + 20, 101))
	end
end

function WorldBossDetailMediator:onClickBack(sender, eventType)
	self:close()
end

function WorldBossDetailMediator:onClickChallenge()
	if not self._challengeAnim then
		return
	end

	if self._enterBattle then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Battle", false)

	self._enterBattle = true

	performWithDelay(self:getView(), function()
		self._enterBattle = false
	end, 0.5)

	local maxHurtNum

	self._activity:setOldMaxHurtNum(self._data.pointType == WorldBossPointType.kVanguard and self._activity:getMaxVanguardHurt() or self._activity:getMaxBossHurt())

	local team = self._activity:getTeam()

	AudioTimerSystem:playStartBattleVoice(team)
	self._activitySystem:setBattleTeamInfo(team)
	self._activitySystem:requestDoActivity(self._activityId, {
		doActivityType = 102,
		pointType = self._pointType
	}, function(rsdata)
		if checkDependInstance(self) and rsdata.resCode == GS_SUCCESS then
			self:close()

			rsdata.data.isWorldBoss = true

			self._activitySystem:enterActstageBattle(rsdata.data, self._activityId, nil, true)
		end
	end, true)
end

function WorldBossDetailMediator:onClickTeam()
	self._activitySystem:enterTeam(self._activityId, self._activity, {
		isWorldBoss = true,
		doActivityType = 105,
		type = self._pointType,
		pointId = self._pointId,
		parent = self
	})
end

function WorldBossDetailMediator:changeTeamSuc()
	self:refreshTeamView()
end

function WorldBossDetailMediator:onTouchMaskLayer()
	return
end

function WorldBossDetailMediator:clickSpecialRule(ruleId)
	local view = self:getInjector():getInstance("ActivityPointDetailRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {}, {
		ruleId = ruleId
	})

	self:dispatch(event)
end

function WorldBossDetailMediator:onClickBuff()
	local view = self:getInjector():getInstance("WorldBossBuffView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		activityId = self._activityId,
		buffData = self._buffList[self._buffIndex],
		nextBuffData = self._buffList[self._buffIndex + 1]
	}))
end

function WorldBossDetailMediator:onClickBuyTimes()
	local cost = self._activity:getCostBuyTimes(self._pointType)
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
				pointType = outSelf._pointType
			}, function()
				if not checkDependInstance(outSelf) then
					return
				end

				outSelf:refreshTimes()
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
