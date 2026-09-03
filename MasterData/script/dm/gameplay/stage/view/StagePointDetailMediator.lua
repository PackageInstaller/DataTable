-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/StagePointDetailMediator.lua

StagePointDetailMediator = class("StagePointDetailMediator", DmPopupViewMediator, _M)

StagePointDetailMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
StagePointDetailMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
StagePointDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.rightPanel.challenge_btn"] = {
		ignoreClickAudio = true,
		func = "onClickChallenge"
	},
	["main.rightPanel.Panel_team.foldBtn"] = {
		clickAudio = "Se_Click_Fold_2",
		func = "showTeamList"
	}
}
local eliteWipeTimes = 5
local normalWipeTimes = 10

function StagePointDetailMediator:initialize()
	super.initialize(self)
end

function StagePointDetailMediator:dispose()
	if self._schedule then
		self:getView():getScheduler():unscheduleScriptEntry(self._schedule)

		self._schedule = nil
	end

	super.dispose(self)
end

function StagePointDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:glueFieldAndUi()

	self._bagSystem = self:getInjector():getInstance("DevelopSystem"):getBagSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGE_RESETTIMES, self, self.refreshChallengeTimes)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ARENA_CHANGE_TEAM_SUCC, self, self.changeTeamSuc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.onCompChanged)
end

function StagePointDetailMediator:enterWithData(data)
	self._data = data
	self._enterBattle = false
	self._point = self:getStageSystem():getPointById(data.pointId)
	self._isDailyFirstEnter = self._point:getIsDailyFirstEnter()

	self._point:setIsDailyFirstEnter(false)

	self._masterSystem = self._developSystem:getMasterSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._costLimit = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()

	if self._data.isPracticePoint then
		self:setupViewWithPracticePoint()
		self:initAnimWithPracticePoint()
	else
		self:setupView()
		self:initAnim()
	end

	self:refreshChallengeTimes()
	self:setupClickEnvs()
end

function StagePointDetailMediator:initAnim()
	local mc = cc.MovieClip:create("guankaxiangqing_zhuxianguanka_UIjiaohudongxiao")

	mc:addCallbackAtFrame(30, function()
		mc:stop()
	end)
	mc:stop()
	mc:addTo(self._main)
	mc:setPosition(cc.p(568, 320))
	mc:setLocalZOrder(100)
	mc:addCallbackAtFrame(6, function()
		local buffIconPanel = mc:getChildByName("buffIcon")

		self:bindBuffIcon(buffIconPanel)
	end)
	mc:addCallbackAtFrame(15, function()
		local guidePanel = mc:getChildByName("guildNode")

		self:bindGuildPopView(guidePanel)
	end)
	mc:addCallbackAtFrame(17, function()
		local dropListView = self._dropPanel:getChildByFullName("dropListView")
		local items = dropListView:getItems()

		for i = 1, #items do
			local node = items[i]

			node:runAction(cc.Sequence:create(cc.DelayTime:create(i * 0.06), cc.ScaleTo:create(0.1, 1)))
		end
	end)
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
		self:setUpQuickPass()
	end)

	for i = 1, 3 do
		local starMc = mc:getChildByName("star" .. i)
		local star = self._conditionPanel:getChildByName("star" .. i)

		star:changeParent(starMc):center(starMc:getContentSize())

		local tipsMc = mc:getChildByName("tips" .. i)
		local tips = self._conditionPanel:getChildByName("tip" .. i)

		tips:changeParent(tipsMc)
		tips:setPosition(-83, 0)

		local diamondNode = self._conditionPanel:getChildByName("diamond" .. i)

		diamondNode:changeParent(tipsMc)
		diamondNode:setPosition(260, 0)
	end

	local teamMc = mc:getChildByFullName("team")

	self._teamPanel:changeParent(teamMc):center(teamMc:getContentSize())

	local descMc = mc:getChildByFullName("desc")
	local descTextPanel = self._rightPanel:getChildByFullName("descTextPanel")

	descTextPanel:changeParent(descMc)
	descTextPanel:setPosition(cc.p(-213, -53))

	local rewardMc = mc:getChildByFullName("rewardPanel")

	self._dropPanel:changeParent(rewardMc)
	self._dropPanel:setPosition(cc.p(30, -48))

	local titleMc = mc:getChildByFullName("title")

	self._titleLabel:changeParent(titleMc)
	self._titleLabel:setPosition(cc.p(-90, 4))

	local combatPanel = mc:getChildByFullName("reqCombat")

	self._combatPanel:changeParent(combatPanel):center(combatPanel:getContentSize())

	local teamCombatPanel = mc:getChildByFullName("teamCombat")

	self._teamCombatPanel:changeParent(teamCombatPanel):center(teamCombatPanel:getContentSize())

	local heroRole = mc:getChildByFullName("hero")

	self._rolePanel:changeParent(heroRole)
	self._challengeBtn:setOpacity(0)
	mc:gotoAndPlay(1)

	self._mainAnim = mc
end

function StagePointDetailMediator:setUpQuickPass()
	if not self._challengeAnim then
		return
	end

	local isquickEnable = self._stageSystem:isPointQuickCrossEnabled(self._data.pointId)
	local isCombatEnable = self._stageSystem:isPointQuickCombatEnabled(self._data.pointId)
	local quickPassBtn = ccui.ImageView:create("gongdou_but_jujue.png", 1)
	local quickPassIcon = ccui.ImageView:create("main_txt_btn_kstz.png", 1)
	local quickPassLock = ccui.ImageView:create("img_common_lock.png", 1)

	if self.quickPassBtn then
		self.quickPassBtn:removeFromParent()

		self.quickPassBtn = nil
	end

	if self._challengeAnimOrgState then
		self._challengeAnim:setScale(self._challengeAnimOrgState.scale)
		self._challengeAnim:setPosition(self._challengeAnimOrgState.position)
	end

	quickPassBtn:setTouchEnabled(true)
	quickPassBtn:setScale(0.88)
	quickPassBtn:addTo(self._mainAnim)
	quickPassIcon:addTo(quickPassBtn)
	quickPassLock:addTo(quickPassBtn)
	quickPassLock:setPosition(115, 125)
	quickPassIcon:center(quickPassBtn:getContentSize())
	quickPassIcon:offset(0, 3)
	quickPassIcon:setScale(1.2)
	quickPassBtn:setPosition(cc.p(300, -83))
	quickPassBtn:addClickEventListener(function(sender, eventType)
		self:quickCrossPoint()
	end)
	quickPassBtn:setOpacity(0)

	local act = cc.Sequence:create(cc.FadeIn:create(0.3125))

	quickPassBtn:runAction(act:clone())

	self.quickPassBtn = quickPassBtn
	self._quickCrossEnable = false
	self._quickCrossEnableErroMsg = ""
	self._challengeAnimOrgState = {
		scale = self._challengeAnim:getScale(),
		position = cc.p(self._challengeAnim:getPosition())
	}

	local function adJustBtnPos()
		self._challengeAnim:setScale(0.8)
		quickPassBtn:setScale(0.8)
		self._challengeAnim:offset(50, -50)
		quickPassBtn:offset(80, 20)
	end

	if self._canwipeOnce then
		adJustBtnPos()
		quickPassIcon:loadTexture("main_txt_btn_sd.png", 1)
		quickPassLock:setVisible(false)

		return
	end

	local unlock, tips = self:getInjector():getInstance("SystemKeeper"):isUnlock("QuickChallenge")

	if not unlock then
		quickPassBtn:stopAllActions()
		quickPassBtn:setVisible(false)

		return
	end

	if not isquickEnable then
		self._quickCrossEnableErroMsg = "Error_11196"

		adJustBtnPos()
		quickPassBtn:setGray(true)

		return
	end

	if not isCombatEnable then
		self._quickCrossEnableErroMsg = "Error_11197"

		adJustBtnPos()
		quickPassBtn:setGray(true)

		return
	end

	adJustBtnPos()
	quickPassLock:setVisible(false)

	self._quickCrossEnable = true
end

function StagePointDetailMediator:checkCostEnergyEnble()
	if self._bagSystem:getPower() < self._point:getCostEnergy() then
		local view = self:getInjector():getInstance("CurrencyBuyPopView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			_currencyType = CurrencyType.kActionPoint
		}, self))

		return false
	end

	return true
end

function StagePointDetailMediator:quickCrossPoint()
	if not self._quickCrossEnable then
		if self._canwipeOnce then
			if not self:checkCostEnergyEnble() then
				return
			end

			if self._point:getType() == StageType.kElite and self._point:getChallengeTimes() == 0 then
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:find("Time_UseingUp")
				}))

				return
			end

			self:showSweepBox()
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get(self._quickCrossEnableErroMsg)
			}))
		end

		return
	end

	if not self:checkCostEnergyEnble() then
		return
	end

	if self._enterBattle then
		return
	end

	if self._point:getType() == StageType.kElite and self._point:getChallengeTimes() == 0 then
		local data = {}

		data.mapId = self._data.mapId
		data.pointId = self._data.pointId
		data.resetTimes = self._point:getResetTimes()
		data.resetCost = self._point:getResetCost()

		local view = self:getInjector():getInstance("StageResetView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Battle", false)

	self._enterBattle = true

	local _teamType = self:getTeamByPointType()
	local team = self._developSystem:getTeamByType(_teamType)

	self._stageSystem:setBattleTeamInfo(team)

	local anim = cc.MovieClip:create("dajia_zhujuedajia")

	anim:addTo(self:getView()):center(self:getView():getContentSize())

	local delay = cc.DelayTime:create(1)
	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		self._stageSystem:requestStageQuickCrossEnter({
			pointId = self._data.pointId
		}, function(rsdata)
			return
		end, true)
		self:close()
	end))

	self:getView():runAction(sequence)
end

function StagePointDetailMediator:onCompChanged(data)
	if not self._data.isPracticePoint then
		self:setUpQuickPass()
	end
end

function StagePointDetailMediator:initAnimWithPracticePoint()
	local mc = cc.MovieClip:create("guankaxiangqing_zhuxianguanka_UIjiaohudongxiao")

	mc:addCallbackAtFrame(9, function()
		mc:getChildByName("starKuang"):setOpacity(0)
	end)
	mc:addCallbackAtFrame(17, function()
		local dropListView = self._dropPanel:getChildByFullName("dropListView")
		local items = dropListView:getItems()

		for i = 1, #items do
			local node = items[i]

			node:runAction(cc.Sequence:create(cc.DelayTime:create(i * 0.06), cc.ScaleTo:create(0.1, 1)))
		end
	end)
	mc:addCallbackAtFrame(30, function()
		mc:stop()
	end)
	mc:stop()
	mc:addTo(self._main)
	mc:setPosition(cc.p(568, 320))
	mc:setLocalZOrder(100)

	local btnAnim = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

	btnAnim:getChildByName("delectPanel"):setVisible(false)

	self._challengeAnim = btnAnim

	local insertPanel = btnAnim:getChildByName("insertPanel")
	local practiceMc = cc.MovieClip:create("zhuxianxunlian_zhuxianxunlian")

	practiceMc:addTo(insertPanel):setPosition(cc.p(-440, -31))
	btnAnim:addTo(mc)
	btnAnim:setPosition(cc.p(443.5, -83))

	local descMc = mc:getChildByFullName("desc")
	local descTextPanel = self._rightPanel:getChildByFullName("descTextPanel")

	descTextPanel:changeParent(descMc)
	descTextPanel:setPosition(cc.p(-213, -53))

	local rewardMc = mc:getChildByFullName("rewardPanel")

	self._dropPanel:changeParent(rewardMc)
	self._dropPanel:setPosition(cc.p(30, 85))
	self._pracPointPanel:changeParent(rewardMc)
	self._pracPointPanel:setPosition(cc.p(-8, 20))

	local titleMc = mc:getChildByFullName("title")

	self._titleLabel:changeParent(titleMc)
	self._titleLabel:setPosition(cc.p(-90, 4))

	local heroRole = mc:getChildByFullName("hero")

	self._rolePanel:changeParent(heroRole)
	self._challengeBtn:offset(0, 50)
	btnAnim:offset(0, 50)
	self._challengeBtn:setOpacity(0)
	btnAnim:setOpacity(0)

	local act = cc.Sequence:create(cc.DelayTime:create(0.4375), cc.FadeIn:create(0.3125))

	self._challengeBtn:runAction(act:clone())
	btnAnim:runAction(act:clone())
	mc:gotoAndPlay(1)
end

function StagePointDetailMediator:bindBuffIcon(parentNode)
	if self._point:getStarCount() < 3 then
		return
	end

	local _tab = GameStyle:getStageBuffInfo(BuffTypeSet.NormalBlock)

	if _tab then
		local icon = ccui.ImageView:create(_tab.iconName)

		AdjustUtils.adjustLayoutByType(icon, AdjustUtils.kAdjustType.Right)
		icon:setTouchEnabled(true)
		IconFactory:bindTouchHander(icon, BuffTouchHandler:new(self), _tab, {})
		icon:addTo(parentNode):center(parentNode:getContentSize())
	end
end

function StagePointDetailMediator:bindGuildPopView(parentNode)
	local descs = self._point:getGuideDesc()

	if not descs or #descs == 0 then
		return
	end

	local icon = self:getView():getChildByName("guildBtn")
	local text = icon:getChildByName("text")

	text:getVirtualRenderer():setMaxLineWidth(50)
	text:setLineSpacing(-5)
	icon:changeParent(parentNode)
	icon:setPosition(cc.p(45, 4))

	local function callFunc()
		local view = self:getInjector():getInstance("StagePracticeSpecialRuleView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
			remainLastView = true,
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			ruleList = descs
		})

		self:dispatch(event)
	end

	mapButtonHandlerClick(nil, icon, {
		ignoreClickAudio = true,
		func = callFunc
	})

	if not self._point:isPass() and self._isDailyFirstEnter and not self._enterBattle then
		self._enterBattle = true

		callFunc()
		performWithDelay(self:getView(), function()
			self._enterBattle = false
		end, 0.5)
	end
end

function StagePointDetailMediator:setupView()
	local point = self._point

	self._pracPointPanel:setVisible(false)

	self._conditionPanel = self._rightPanel:getChildByFullName("3starTip")

	self._conditionPanel:setLocalZOrder(948)

	local starState = point:getStarState() or {}
	local descs = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Block_StarConditionDesc", "content")
	local starDiamondCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BlockStarDiamond", "content").num
	local starCondition = point:getStarCondition()

	for i = 1, 3 do
		local tip = self._conditionPanel:getChildByName("tip" .. i)

		tip:setContentSize(cc.size(310, 44))
		tip:setString(Strings:get(descs[starCondition[i].type], {
			value = starCondition[i].value
		}))

		local tipStar = self._conditionPanel:getChildByName("star" .. i)
		local diamondNode = self._conditionPanel:getChildByName("diamond" .. i)

		if starState[i] then
			tipStar:loadTexture("asset/common/yinghun_xingxing.png", ccui.TextureResType.localType)
			tip:setTextColor(cc.c3b(255, 255, 255))
			diamondNode:setColor(cc.c3b(125, 125, 125))
			diamondNode:getChildByName("diamondNum"):setVisible(false)
			diamondNode:getChildByName("onFinish"):setVisible(true)
		else
			tipStar:loadTexture("asset/common/yinghun_xingxing2.png", ccui.TextureResType.localType)
			tip:setTextColor(cc.c3b(160, 160, 160))
			tipStar:setScale(0.3)
			diamondNode:setColor(cc.c3b(255, 255, 255))
			diamondNode:getChildByName("onFinish"):setVisible(false)

			local diamondNum = diamondNode:getChildByName("diamondNum")

			diamondNum:setVisible(true)
			diamondNum:setString("+" .. starDiamondCount)
		end
	end

	self._rolePanel:removeAllChildren()

	local pointHead = point:_getConfig().PointHead
	local heroSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = pointHead
	})

	heroSprite:addTo(self._rolePanel):setTag(951)
	heroSprite:setScale(0.92)
	heroSprite:setPosition(cc.p(88, 0))
	self._descLabel:setString(point:getDesc())
	self._descLabel:enableShadow(cc.c4b(0, 0, 0, 137.70000000000002), cc.size(2, -2), 3)
	self._descLabel:getVirtualRenderer():setLineHeight(24)
	self._descLabel:setLineSpacing(0)

	local mapIndex = self._stageSystem:mapId2Index(self._data.mapId)
	local pointIndex = self._stageSystem:pointId2Index(self._data.pointId)

	self._titleLabel:setString(mapIndex .. "." .. pointIndex .. " " .. Strings:get(point:getName()))

	local rewardTitle = self._dropPanel:getChildByFullName("node_1.title_reward")
	local rewards = point:getShowFirstKillReward()
	local isFirst = false

	if point:isPass() or rewards == nil then
		rewards = point:getShowRewards()

		rewardTitle:setString(Strings:get("STAGE_NORMAL_DROP_TITLE"))
	else
		isFirst = true

		rewardTitle:setString(Strings:get("STAGE_FIRST_DROP_TITLE"))
	end

	local dropListView = self._dropPanel:getChildByFullName("dropListView")

	if rewards then
		local size = cc.size(69, 69)

		for index, reward in ipairs(rewards) do
			local icon = IconFactory:createRewardIcon(reward, {
				isWidget = true,
				showAmount = isFirst
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})

			local iconPanel = ccui.Layout:create()

			iconPanel:setAnchorPoint(cc.p(0.5, 0.5))
			iconPanel:setContentSize(size)
			icon:addTo(iconPanel):center(size)
			icon:setScaleNotCascade(0.5)
			iconPanel:setScale(0.01)
			dropListView:pushBackCustomItem(iconPanel)
		end
	end

	self:refreshCostView()
	self:checkCostChange()
	self._combatPanel:setLocalZOrder(947)

	local combatText = self._combatPanel:getChildByFullName("combat_text")
	local Text1 = self._combatPanel:getChildByFullName("Text_1")
	local combatbg = self._combatPanel:getChildByFullName("my_combat_bg")

	combatText:setString(point:getRecommendCombat())

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local allWidth = Text1:getContentSize().width + combatText:getContentSize().width + 30

		allWidth = allWidth > 172 and allWidth + 10 or 172

		combatText:setPositionX(Text1:getPositionX() + Text1:getContentSize().width + combatText:getContentSize().width)
		combatbg:setContentSize(cc.size(allWidth, combatbg:getContentSize().height))
	end

	local wipeOnecId, wipeTimes

	if point:getType() == StageType.kNormal then
		wipeOnecId = "Normal_OnceRaid"
		wipeTimes = "Normal_Raid"
	else
		wipeOnecId = "Elite_OnceRaid"
		wipeTimes = "Elite_Raid"
	end

	self._canwipeOnce, self._wipeOneTip = self:getSystemKeeper():isUnlock(wipeOnecId)
	self._canwipeTime, self._wipeTimeTip = self:getSystemKeeper():isUnlock(wipeTimes)
	self._canwipeOnce = self._canwipeOnce and point:canWipeOnce()
	self._canwipeTime = self._canwipeTime and point:canWipeOnce()

	self:changeTeamSuc()
end

function StagePointDetailMediator:setupViewWithPracticePoint()
	self._pracPointPanel:setVisible(true)
	self._rolePanel:removeAllChildren()

	local pointHead = self._point:getShowHero()
	local roleModel = ConfigReader:getDataByNameIdAndKey("HeroBase", pointHead, "RoleModel")
	local heroSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = roleModel
	})

	heroSprite:addTo(self._rolePanel):setTag(951)
	heroSprite:setScale(0.8)
	heroSprite:setPosition(cc.p(0, 0))
	self._descLabel:setString(self._point:getDesc())
	self._descLabel:enableShadow(cc.c4b(0, 0, 0, 137.70000000000002), cc.size(2, -2), 3)
	self._descLabel:getVirtualRenderer():setLineHeight(20)
	self._descLabel:setLineSpacing(0)
	self._titleLabel:setString(Strings:get("BlockPractice_word1") .. self._point:getName())

	local rewardTitle = self._dropPanel:getChildByFullName("node_1.title_reward")
	local rewards = self._point:getFirstReward()
	local isFirst = false

	if self._point:isPass() or rewards == nil then
		rewards = self._point:getCommonReward()

		rewardTitle:setString(Strings:get("STAGE_NORMAL_DROP_TITLE"))
	else
		isFirst = true

		rewardTitle:setString(Strings:get("STAGE_FIRST_DROP_TITLE"))
	end

	local cloneCell = self._dropPanel:getChildByFullName("icon1")
	local dropListView = self._dropPanel:getChildByFullName("dropListView")

	if rewards then
		for index, reward in ipairs(rewards) do
			local iconRect = cloneCell:clone()

			iconRect:removeAllChildren()

			local icon = IconFactory:createRewardIcon(reward, {
				isWidget = true,
				showAmount = isFirst
			})

			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})
			icon:setAnchorPoint(cc.p(0.5, 0.5))
			icon:setScaleNotCascade(0.6)
			icon:addTo(iconRect):center(iconRect:getContentSize())
			iconRect:setScale(0.01)
			dropListView:pushBackCustomItem(iconRect)
		end
	end

	self._teamPanel:setVisible(false)
	self._combatPanel:setVisible(false)
	self._teamCombatPanel:setVisible(false)
	self:refreshCostView()
	self:checkCostChange()
end

function StagePointDetailMediator:refreshChallengeTimes()
	do
		local ResetChallenge = self._rightPanel:getChildByFullName("ResetChallenge")

		ResetChallenge:setVisible(false)

		return
	end

	local point = self._point
	local ResetChallenge = self._rightPanel:getChildByFullName("ResetChallenge")

	if StageType.kNormal == point:getType() then
		ResetChallenge:setVisible(false)

		return
	end

	local changeTimes = point:getChallengeTimes()
	local MaxChallengeTimes = point:getMaxChallengeTimes()
	local remainTimes = ResetChallenge:getChildByName("remainTimes")

	remainTimes:setString(changeTimes .. "/" .. MaxChallengeTimes)
end

function StagePointDetailMediator:refreshTeamView()
	local developSystem = self:getInjector():getInstance("DevelopSystem")
	local _teamType = self:getTeamByPointType()
	local team = developSystem:getTeamByType(_teamType)
	local curTeamId = team:getId()
	local curCombat = team:getCombat()
	local teamCombatText = self._teamCombatPanel:getChildByName("combat_text")

	teamCombatText:setString(curCombat)

	if curCombat >= self._point:getRecommendCombat() then
		teamCombatText:setTextColor(cc.c3b(170, 235, 29))
	else
		teamCombatText:setTextColor(cc.c3b(255, 85, 85))
	end

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

	local teams = developSystem:getAllUnlockTeams()
	local teamPanel = self._teamPanel:getChildByName("teamsPanel")
	local panelCell = self:getView():getChildByName("teamClone")
	local cellSize = panelCell:getContentSize()

	teamPanel:removeAllChildren()
	teamPanel:setContentSize(cc.size(cellSize.width, cellSize.height * #teams))

	for k, _team in ipairs(teams) do
		if #_team:getHeroes() == 0 then
			return
		end

		local _teamPanel = panelCell:clone()
		local nameStr = _teamPanel:getChildByName("teamName")

		nameStr:setString(Strings:get(_team._name))
		_teamPanel:setPosition(cc.p(0, (k - 1) * cellSize.height))
		_teamPanel:addTo(teamPanel)

		local function callFunc()
			local curTeamId = curTeamId

			if curTeamId == _team:getId() then
				return
			else
				local param = {}

				param.teamType = self:getTeamByPointType()
				param.teamId = _team:getId()

				self._stageSystem:requestStageTeam(param, function()
					self:showTeamList()
				end, true)
			end
		end

		mapButtonHandlerClick(nil, _teamPanel, {
			ignoreClickAudio = true,
			func = callFunc
		})
	end
end

function StagePointDetailMediator:refreshCostView()
	local point = self._point
	local costText = self._challengeBtn:getChildByFullName("cost_text")

	costText:setString("X" .. point:getCostEnergy())

	self._curPower = self._bagSystem:getPower()

	if self._curPower < point:getCostEnergy() then
		costText:setTextColor(GameStyle:getColor(7))
	else
		costText:setTextColor(GameStyle:getColor(1))
	end
end

local checkTime = 1

function StagePointDetailMediator:checkCostChange()
	local function checkTimeFunc()
		local newPower = self._bagSystem:getPower()

		if newPower ~= self._curPower then
			self:refreshCostView()
		end
	end

	self._schedule = self._schedule or self:getView():getScheduler():scheduleScriptFunc(checkTimeFunc, checkTime, false)

	checkTimeFunc()
end

function StagePointDetailMediator:glueFieldAndUi()
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
	self._dropPanel = self._rightPanel:getChildByFullName("Panel_drop")
	self._challengeBtn = self._rightPanel:getChildByFullName("challenge_btn")
	self._teamPanel = self._rightPanel:getChildByName("Panel_team")
	self._teamCombatPanel = self._rightPanel:getChildByName("team_combat")
	self._pracPointPanel = self._rightPanel:getChildByName("panel_pracPoint")

	local dropListView = self._dropPanel:getChildByName("dropListView")

	dropListView:setScrollBarEnabled(false)

	self._descLabel = self._rightPanel:getChildByFullName("descTextPanel.desc_text")
	self._titleLabel = self._rightPanel:getChildByFullName("title_text")
	self._rolePanel = self._main:getChildByName("bg_renwu")

	local function callFunc(sender, eventType)
		self:onClickTeam()
	end

	mapButtonHandlerClick(nil, self._teamPanel, {
		func = callFunc
	})
end

function StagePointDetailMediator:onClickBack(sender, eventType)
	self:close()
end

function StagePointDetailMediator:showSweepBox()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if not data then
			return
		end

		if data.returnValue == 1 then
			outSelf:onChallenge()
		elseif data.returnValue == 2 then
			outSelf:onClickWipeTimes()
		elseif data.returnValue == 3 then
			outSelf:onClickWipeOnce()
		end
	end

	local data = {
		normalType = 1
	}

	if self._point:getType() == StageType.kElite then
		data.stageType = StageType.kElite
		data.challengeTimes = eliteWipeTimes
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("SweepBoxPopView"), {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function StagePointDetailMediator:onClickWipeOnce()
	if self._point:getType() == StageType.kElite and self._point:getChallengeTimes() == 0 then
		local data = {}

		data.mapId = self._data.mapId
		data.pointId = self._data.pointId
		data.resetTimes = self._point:getResetTimes()
		data.resetCost = self._point:getResetCost()

		local view = self:getInjector():getInstance("StageResetView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._stageSystem:requestStageSweep(self._data.mapId, self._data.pointId, 1, nil, function(data)
		data.param = {
			wipeTimes = 1,
			mapId = self._data.mapId,
			pointId = self._data.pointId
		}
		data.itemId = self._point:getMainItemId()

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("StageSweepView"), {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))
	end)
end

function StagePointDetailMediator:onClickWipeTimes()
	if not self._point:canWipeOnce() then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = self._wipeTimeTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if self._point:getType() == StageType.kElite and self._point:getChallengeTimes() == 0 then
		local data = {}

		data.mapId = self._data.mapId
		data.pointId = self._data.pointId
		data.resetTimes = self._point:getResetTimes()
		data.resetCost = self._point:getResetCost()

		local view = self:getInjector():getInstance("StageResetView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))

		return
	end

	local times = math.modf(self._bagSystem:getPower() / self._point:getCostEnergy())

	if self._point:getType() == StageType.kNormal then
		if not normalWipeTimes then
			local realTimes = eliteWipeTimes

			if times < 1 then
				AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:find("CUSTOM_ENERGY_NOT_ENOUGH")
				}))

				return
			end

			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self._stageSystem:requestStageSweep(self._data.mapId, self._data.pointId, realTimes, nil, function(data)
				data.param = {
					mapId = self._data.mapId,
					pointId = self._data.pointId,
					wipeTimes = realTimes
				}
				data.itemId = self._point:getMainItemId()

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("StageSweepView"), {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data))
			end)
		end
	end
end

function StagePointDetailMediator:onClickChallenge()
	if not self._challengeAnim then
		return
	end

	if not self:checkCostEnergyEnble() then
		return
	end

	if self._data.isPracticePoint then
		self:enterTimeEditView()
	else
		self:onChallenge()
	end
end

function StagePointDetailMediator:onChallenge()
	if self._enterBattle then
		return
	end

	local data = self._data

	if self._point:getType() == StageType.kElite and self._point:getChallengeTimes() == 0 then
		local data = {}

		data.mapId = self._data.mapId
		data.pointId = self._data.pointId
		data.resetTimes = self._point:getResetTimes()
		data.resetCost = self._point:getResetCost()

		local view = self:getInjector():getInstance("StageResetView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data))

		return
	end

	AudioTimerSystem:playStartBattleVoice(self:getTeamByPointType())
	AudioEngine:getInstance():playEffect("Se_Click_Battle", false)

	self._enterBattle = true

	local _teamType = self:getTeamByPointType()
	local team = self._developSystem:getTeamByType(_teamType)

	self._stageSystem:setBattleTeamInfo(team)
	self._stageSystem:requestStageEnter(data, function(rsdata)
		data.battleHistory = rsdata.battleHistory or false

		local stageSystem = self:getStageSystem()

		self:close()
		stageSystem:enterBattle(data.pointId, rsdata.playerData, data, rsdata.enemyBuff)
	end, true)
end

function StagePointDetailMediator:enterTimeEditView()
	local view = self:getInjector():getInstance("StagePracticeTeamView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		practiceType = 2,
		stagePoint = self._point
	}))
	self:close()
end

function StagePointDetailMediator:showTeamList()
	local sender = self._teamPanel:getChildByName("foldBtn")
	local teamPanel = self._teamPanel:getChildByName("teamsPanel")

	if sender:isFlippedY() then
		sender:setFlippedY(false)
		teamPanel:setVisible(true)
	else
		sender:setFlippedY(true)
		teamPanel:setVisible(false)
	end
end

function StagePointDetailMediator:onClickTeam()
	local unlock, tips = self._systemKeeper:isUnlock("Hero_Group")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	local view = self:getInjector():getInstance("StageTeamView")
	local _teamType = self:getTeamByPointType()
	local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		stageType = _teamType
	})

	self:dispatch(Event:new(EVT_RETURN_VIEW))
	self:dispatch(event)
end

function StagePointDetailMediator:changeTeamSuc()
	self:refreshTeamView()
end

function StagePointDetailMediator:getTeamByPointType()
	if self._point:getType() == StageType.kNormal then
		return StageTeamType.STAGE_NORMAL
	else
		return StageTeamType.STAGE_ELITE
	end
end

function StagePointDetailMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		storyDirector:setClickEnv("stagePointDetail.challengeBtn", self._challengeBtn, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Battle", false)
			self:onClickChallenge()
		end)
		storyDirector:notifyWaiting("enter_stagePointDetail_view")
	end))

	self:getView():runAction(sequence)
end

function StagePointDetailMediator:onTouchMaskLayer()
	return
end
