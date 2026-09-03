-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/view/CrusadeMainMediator.lua

CrusadeMainMediator = class("CrusadeMainMediator", DmAreaViewMediator, _M)

CrusadeMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CrusadeMainMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
CrusadeMainMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")
CrusadeMainMediator:has("_bagSystem", {
	is = "r"
}):injectWith("BagSystem")
CrusadeMainMediator:has("_crusade", {
	is = "r"
}):injectWith("Crusade")

local kBtnHandlers = {
	["main.bg_bottom.button_sweep"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSweep"
	},
	["main.bg_bottom.button_recruit"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRecruit"
	},
	button_rule = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["main.bg_bottom.Node_9.reward_rule_new"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickAward"
	},
	["main.namePanel.powerPanel.nameBg_0"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onOpenPowerView"
	}
}
local checkPointState = {
	normalTypeAfter = 5,
	fristTypeAfter = 2,
	normalTypeBefore = 4,
	fristTypeBefore = 1,
	normalTypeIng = 6,
	fristTypeIng = 3
}
local tipsPos = {
	cc.p(150.11, 249.63),
	cc.p(60.6, 277.12),
	cc.p(60.6, 277.12),
	cc.p(60.6, 277.12),
	(cc.p(60.6, 277.12))
}
local btnPos = {
	button_sweep_1 = cc.p(1073, 53),
	button_sweep_2 = cc.p(1073, 323),
	button_recruit_1 = cc.p(1003, 53),
	button_recruit_2 = cc.p(1003, 53)
}

function CrusadeMainMediator:initialize()
	super.initialize(self)
end

function CrusadeMainMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function CrusadeMainMediator:onRegister()
	super.onRegister(self)

	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
	self._customDataSystem = self:getInjector():getInstance(CustomDataSystem)

	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
	self:getView():getChildByFullName("main.bg_bottom.btn_openPower"):setVisible(false)
	self:getView():getChildByFullName("main.namePanel.powerPanel.nameBg_0"):setTouchEnabled(true)
end

function CrusadeMainMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CRUSADE_SYNC_DIFF, self, self.updateView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CRUSADE_RESET_DIFF, self, self.resumeWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CRUSADEWIPE, self, self.CrusadeWipe)
end

function CrusadeMainMediator:CrusadeWipe()
	self._sweepBtn:setVisible(false)
end

function CrusadeMainMediator:updateView(event)
	self:initData()
	self:updateBottom()
	self:createTableView()
	self:refreshProgress()
end

function CrusadeMainMediator:resumeWithData()
	self._crusadeSystem:requestGetCrusadeInfo()
	self:showGetReward()
end

function CrusadeMainMediator:enterWithData(data)
	self._currencyId = CurrencyIdKind.kCrusadeEnergy
	data = data or {}

	if data.ignoreRefresh then
		local function callback()
			self:onAnimEffect()
		end

		self._crusadeSystem:requestGetCrusadeInfo(callback)
		self:showGetReward()
		self:initData()
		self:setupView()
		self._crusadeSystem:checkCrusadeRedPointState()

		return
	end

	data.ignoreRefresh = true

	self:initData()
	self:setupView()
	self._crusadeSystem:checkCrusadeRedPointState()
	self:onAnimEffect()
end

function CrusadeMainMediator:initData()
	self._crusadeWeekModel = self._crusadeSystem:getCrusadeWeekModel()
	self._crusadeFloorModel = self._crusadeSystem:getCurCrusadeFloorModel()
	self._crusadePointModel = self._crusadeSystem:getCurCrusadePointModel()
end

function CrusadeMainMediator:setupView()
	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:createTableView()
	self:updateBottom()
	self:refreshProgress()
end

function CrusadeMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Crusade")
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
		title = Strings:get("Crusade_UI1"),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 33 or nil
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local button_rule = self:getView():getChildByFullName("button_rule")

	button_rule:setPositionX(self._topInfoWidget:getTitleWidth() + 20)
end

function CrusadeMainMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByName("main")
	self._maskTouchLayout = self:getView():getChildByName("maskTouchLayout")
	self._rolePanel = self._mainPanel:getChildByName("rolePanel")
	self._bg = self._mainPanel:getChildByName("bg")
	self._cloneCell = self:getView():getChildByName("cloneCell")

	self._cloneCell:setVisible(false)

	self._progressPanel = self._mainPanel:getChildByName("progressPanel")
	self._rewardPanel = self._mainPanel:getChildByFullName("bg_bottom.rewardPanel")
	self._namePanel = self._mainPanel:getChildByFullName("namePanel")
	self._sweepBtn = self._mainPanel:getChildByFullName("bg_bottom.button_sweep")
	self._recruitBtn = self._mainPanel:getChildByFullName("bg_bottom.button_recruit")

	self._recruitBtn:getChildByName("redPoint"):setVisible(false)

	local lineGradiantVec1 = {
		{
			ratio = 0.4,
			color = cc.c4b(251, 251, 251, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(167, 186, 255, 255)
		}
	}

	self._mainPanel:getChildByFullName("bg_bottom.button_sweep.text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
end

function CrusadeMainMediator:createTableView()
	local subPoint = self._crusadeFloorModel:getSubPoint()
	local curIndex = self._crusadePointModel and self._crusadePointModel:getIndex() or 10
	local rolePanel = self._mainPanel:getChildByFullName("rolePanel")
	local pointPanel = rolePanel:getChildByFullName("pointPanel")

	for i = 1, 5 do
		local lineNode = pointPanel:getChildByFullName("line_" .. i)
		local pointNode = pointPanel:getChildByFullName("point_" .. i)

		pointNode:removeAllChildren()

		local node = rolePanel:getChildByFullName("role_" .. i)
		local light = rolePanel:getChildByFullName("light_" .. i)

		light:setLocalZOrder(40)
		node:removeAllChildren()

		if lineNode then
			lineNode:loadTexture("img_mjyz_route_unact.png", 1)
		end

		local subPointId = subPoint[i]

		if subPointId then
			local floorNum = self._crusadeSystem:getFloorNumByFloorId(self._crusadeFloorModel:getId())
			local point = self._crusadeFloorModel:getCrusadePointById(subPointId)
			local curCheckPointState = checkPointState.normalTypeIng
			local isFrist = self._crusadeSystem:checkIsFirstPass(self._crusadeSystem:getFloorNumByFloorId(), i)

			if curIndex == i then
				curCheckPointState = isFrist and checkPointState.fristTypeIng or checkPointState.normalTypeIng
			elseif i < curIndex then
				curCheckPointState = isFrist and checkPointState.fristTypeAfter or checkPointState.normalTypeAfter
			elseif curIndex < i then
				curCheckPointState = isFrist and checkPointState.fristTypeBefore or checkPointState.normalTypeBefore
			end

			if isFrist then
				local var_14_0 = self._crusadeSystem:getCurPointFirstReward(floorNum, i)

				if not var_14_0 then
					var_14_0 = self._crusadeSystem:getCurPointNormalReward(subPointId)

					local rewards = var_14_0
					local style = {
						curIndex = curIndex,
						i = i,
						point = point,
						lineNode = lineNode,
						pointNode = pointNode,
						curCheckPointState = curCheckPointState,
						rewards = rewards,
						isFrist = isFrist
					}

					self:updateCheckPointView(node, style)
				end
			end
		end
	end
end

function CrusadeMainMediator:updateCheckPointView(node, style)
	self._maskTouchLayout:setVisible(true)

	local curIndex = style.curIndex
	local i = style.i
	local point = style.point
	local lineNode = style.lineNode
	local pointNode = style.pointNode
	local curCheckPointState = style.curCheckPointState
	local rewards = style.rewards
	local isFrist = style.isFrist
	local panel = self._cloneCell:clone()

	panel:setVisible(true)
	panel:addTo(node):posite(0, 0)
	panel:addClickEventListener(function()
		self:onClickRole(i, curIndex, isFrist)
	end)

	local infoPanel = panel:getChildByFullName("panel")
	local rewardPanel = infoPanel:getChildByFullName("rewardPanel")
	local numImage = infoPanel:getChildByFullName("numImage")
	local winImage = panel:getChildByFullName("winImage")
	local selectImage = panel:getChildByFullName("selectImage")
	local battleBg = panel:getChildByFullName("battleBg")
	local combatLabel = panel:getChildByFullName("combatLabel")
	local panelTips = panel:getChildByFullName("panelTips")
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(129, 118, 113, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	combatLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))

	local imageFile = string.format("img_mjyz_sign_%d.png", i)

	numImage:loadTexture(imageFile, 1)
	panel:setScale(i == 5 and 0.85 or 0.76)

	local index = point:getIndex()
	local win = index < curIndex
	local color = win and cc.c3b(120, 120, 120) or cc.c3b(255, 255, 255)

	infoPanel:setColor(color)
	winImage:setVisible(win)
	selectImage:setVisible(index == curIndex)
	battleBg:setVisible(false)

	local battleAnim = panel:getChildByFullName("battleAnim")

	battleAnim:removeAllChildren()

	if index == curIndex then
		local delay1 = cc.DelayTime:create(0.6)
		local callFun = cc.CallFunc:create(function()
			self._maskTouchLayout:setVisible(false)
			self:addAttackBtnAnim(battleAnim)
		end)
		local seq = cc.Sequence:create(delay1, callFun)

		battleAnim:runAction(seq)
	end

	panel:setTouchEnabled(not win)
	panelTips:setVisible(index == curIndex)
	panelTips:setAnchorPoint(cc.p(1, 0.5))

	if i == 1 then
		panelTips:setAnchorPoint(cc.p(0, 0.5))
	end

	panelTips:setPosition(tipsPos[i])
	panelTips:setScale(0)

	if index == curIndex then
		node:setLocalZOrder(30)

		local tipslbl = panelTips:getChildByFullName("tipslbl")
		local str = self._crusadePointModel:getBubble()

		tipslbl:setString(Strings:get(str))

		local delay1 = cc.DelayTime:create(1)
		local scaleTo1 = cc.ScaleTo:create(0.1, 1)
		local delay2 = cc.DelayTime:create(3)
		local scaleTo2 = cc.ScaleTo:create(0.3, 0)
		local callFun = cc.CallFunc:create(function()
			panelTips:setVisible(false)
		end)
		local seq = cc.Sequence:create(delay1, scaleTo1, delay2, scaleTo2, callFun)

		panelTips:runAction(seq)
	else
		node:setLocalZOrder(20)
	end

	local role = infoPanel:getChildByFullName("role")
	local info = {
		frameId = "bustframe7_2",
		id = point:getRoleModel(),
		useAnim = index == curIndex
	}
	local icon = IconFactory:createRoleIconSpriteNew(info)

	icon:setAnchorPoint(cc.p(0.5, 0.5))
	icon:addTo(role):center(role:getContentSize()):offset(0, -50)
	icon:setScale(0.9)
	role:setGray(curCheckPointState == checkPointState.fristTypeBefore or curCheckPointState == checkPointState.normalTypeBefore)

	local isSetColor = curCheckPointState == checkPointState.fristTypeAfter or curCheckPointState == checkPointState.normalTypeAfter

	panel:setColor(isSetColor and cc.c3b(230, 230, 230) or cc.c3b(255, 255, 255))

	local name = infoPanel:getChildByFullName("name")
	local isFrist = curCheckPointState == checkPointState.fristTypeBefore or curCheckPointState == checkPointState.fristTypeAfter or curCheckPointState == checkPointState.fristTypeIng

	name:setString((isFrist or nil) and (Strings:get("Crusade_Point_1") or Strings:get("Crusade_Point_2")))

	local offsetX = #rewards == 2 and 34 or 0

	for i = 1, #rewards do
		local reward = rewards[i]

		if reward then
			local rewardIcon = IconFactory:createRewardIcon(reward, {
				isWidget = true
			})

			rewardPanel:addChild(rewardIcon)
			rewardIcon:setAnchorPoint(cc.p(0, 0.5))
			rewardIcon:setPosition(cc.p(offsetX + 5 + (i - 1) * 75, 35))
			rewardIcon:setScaleNotCascade(0.55)
			IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})
		end
	end

	local combat = self._crusadeSystem:getCurPointCombat(i)

	combatLabel:setString(combat)

	if lineNode then
		local imageFile = index <= curIndex and "img_mjyz_route_act.png" or "img_mjyz_route_unact.png"

		lineNode:loadTexture(imageFile, 1)
	end

	local anim = pointNode:getChildByName("curAnim")

	if anim then
		anim:removeFromParent()
	end

	if index < curIndex then
		local image = ccui.ImageView:create("img_mjyz_site_done.png", 1)

		image:addTo(pointNode):posite(0, 0)
	elseif index == curIndex then
		self:addCurPointAnim(pointNode)

		local image = ccui.ImageView:create("img_mjyz_site_activate.png", 1)

		image:addTo(pointNode):posite(0.2, 6.2)
	else
		local image = ccui.ImageView:create("img_mjyz_site_undo.png", 1)

		image:addTo(pointNode):posite(-0.4, -3.4)
	end
end

function CrusadeMainMediator:updateBottom()
	local timeLabel = self._progressPanel:getChildByName("time")
	local remoteTimestamp = self._crusadeSystem:getCurrentTime()

	self._refreshTime = self._crusadeSystem:getResetTime() + remoteTimestamp

	if not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = self._crusadeSystem:getCurrentTime()

			local remainTime = self._refreshTime - remoteTimestamp
			local num = math.modf(tonumber(remainTime))

			if num == 0 then
				self:dispatch(ShowTipEvent({
					duration = 0.35,
					tip = Strings:get("Crusade_UpWeek")
				}))
			end

			if remainTime <= 0 then
				self._canRefresh = true

				self._timer:stop()

				self._timer = nil

				timeLabel:setString("")

				return
			end

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

			timeLabel:setString(Strings:get("Crusade_UI3", {
				time = str
			}))
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end

	self._rewardPanel:removeAllChildren()

	local rewards = self._crusadeSystem:getfloorReward()

	for i = 1, #rewards do
		local reward = rewards[i]

		if reward then
			local rewardIcon = IconFactory:createRewardIcon(reward, {
				isWidget = true
			})

			self._rewardPanel:addChild(rewardIcon)
			rewardIcon:setName("rewardIcon" .. i)
			rewardIcon:setAnchorPoint(cc.p(0, 0.5))
			rewardIcon:setPosition(cc.p(15 + (i - 1) * 80, 0))
			rewardIcon:setScaleNotCascade(0.55)
			IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})
		end
	end

	local quality = self._crusadeFloorModel:getQuality()
	local name = self._crusadeFloorModel:getName()
	local nameLabel = self._namePanel:getChildByFullName("nameBg.name")

	nameLabel:setString(name)
	GameStyle:setQualityText(nameLabel, quality, true)

	if self._crusadeSystem:canCrusadeSweep() then
		self._sweepBtn:setVisible(true)
		self._sweepBtn:setPosition(btnPos.button_sweep_1)
		self._recruitBtn:setPosition(btnPos.button_recruit_1)
	else
		self._sweepBtn:setVisible(false)
		self._recruitBtn:setPosition(btnPos.button_recruit_2)
	end

	local curRule = self._namePanel:getChildByFullName("curRule")
	local str = Strings:get(self._crusadeSystem:getCurFloorBuff())

	curRule:setString(str)
	self:updataPower()

	local bgName = self._crusadeFloorModel:getBackground()

	self._bg:loadTexture("asset/ui/crusade/" .. bgName .. ".png", ccui.TextureResType.localType)
	self:setRecommendHeroView()
	self._bagSystem:bindSchedulerOnView(self)
	self._crusadeSystem:showPassCurFloorRewardView()
end

function CrusadeMainMediator:updataPower()
	local powerNum = self._namePanel:getChildByFullName("powerPanel.powerNum")
	local powerDes = self._namePanel:getChildByFullName("powerPanel.powerDes")

	powerNum:setString(self._crusadeSystem:getCrusadeEnergy())
	powerDes:setString(Strings:get(self._crusadeSystem:getCurBuffDesc()))
end

function CrusadeMainMediator:setRecommendHeroView()
	local recommendHero = self._crusadeSystem:getCurFloorRecommendHero()
	local starBuff = self._crusadeSystem:getCurFloorStarBuffDesc()
	local aweakenBuff = self._crusadeSystem:getCurFloorAweakenBuffDesc()
	local bgBottom = self._mainPanel:getChildByFullName("bg_bottom")
	local recommendHero1 = bgBottom:getChildByFullName("recommendHero1")
	local recommendHero2 = bgBottom:getChildByFullName("recommendHero2")
	local recommendHero3 = bgBottom:getChildByFullName("recommendHero3")

	bgBottom:getChildByFullName("Node_recommend.text"):setString(Strings:get("EXPLORE_UI22") .. "\n" .. Strings:get("GALLERY_UI1"))

	for i = 1, 3 do
		if recommendHero[i] then
			local iconNode = recommendHero1:getChildByFullName("iconNode" .. i)
			local attackText = iconNode:getChildByFullName("attackText")

			attackText:setString("")

			local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", recommendHero[i].Effect)

			if effectConfig then
				attackText:setString(Strings:get(effectConfig.EffectDesc))
			end

			if iconNode:getChildByFullName("iconHero") then
				iconNode:getChildByFullName("iconHero"):removeFromParent()
			end

			local config = ConfigReader:getRecordById("HeroBase", recommendHero[i].Hero[1])
			local heroImg = IconFactory:createRoleIconSpriteNew({
				id = config.RoleModel
			})

			iconNode:addChild(heroImg)
			heroImg:setName("iconHero")
			heroImg:setScale(0.25)
		end
	end

	recommendHero2:getChildByFullName("attackText"):setString(starBuff)
	recommendHero3:getChildByFullName("attackText"):setString(aweakenBuff)
end

function CrusadeMainMediator:refreshProgress()
	return
end

function CrusadeMainMediator:onClickRole(index, curIndex, isFrist)
	if curIndex < index then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Crusade_UI10")
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._crusadeSystem:showCrusadeTeamView(isFrist)
end

function CrusadeMainMediator:onClickAward(sender, eventType)
	self._crusadeSystem:showCrusadeAwardView()
end

function CrusadeMainMediator:onClickRank(sender, eventType)
	self._crusadeSystem:showRankView()
end

function CrusadeMainMediator:onClickRule()
	self._crusadeSystem:showCrusadeRuleView()
end

function CrusadeMainMediator:onOpenPowerView()
	self._crusadeSystem:openPowerView()
end

function CrusadeMainMediator:onClickSweep()
	self._crusadeSystem:showCrusadeSweepView()
end

function CrusadeMainMediator:onClickRecruit(sender, eventType)
	local recruitSystem = self:getInjector():getInstance(RecruitSystem)
	local data = {
		recruitType = RecruitPoolType.kPve
	}

	recruitSystem:tryEnter(data)
end

function CrusadeMainMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function CrusadeMainMediator:showGetReward()
	if #self._crusadeSystem:getShowAwardAfterBattle() > 0 then
		local delegate, outself = {}, self

		function delegate:willClose(popupMediator, data)
			local playerId = outself._developSystem:getPlayer():getRid()
			local volume = cc.UserDefault:getInstance():getStringForKey(playerId .. UserDefaultKey.kCrusadeFloorNum)

			if outself._crusade:getCrusadeFloorId() == outself._crusadeSystem:getFloorIdByFloorNum(11) and volume ~= "11" then
				local storyDirector = outself:getInjector():getInstance(story.StoryDirector)
				local storyLink = "guide_plot_expedition"
				local storyAgent = storyDirector:getStoryAgent()

				storyAgent:setSkipCheckSave(true)
				storyAgent:trigger(storyLink, nil, function()
					outself._crusadeSystem:showWorldRuleView()
				end)
				cc.UserDefault:getInstance():setStringForKey(playerId .. UserDefaultKey.kCrusadeFloorNum, "11")
			end
		end

		local rewards = self._crusadeSystem:getShowAwardAfterBattle()
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			needClick = true,
			rewards = rewards
		}, delegate))
		self._crusadeSystem:setShowAwardAfterBattle({})
	end
end

function CrusadeMainMediator:onAnimEffect()
	local anim = cc.MovieClip:create("ytgkaz_mengjingyuanzheng")

	anim:addTo(self._mainPanel):center(self._mainPanel:getContentSize())

	for i = 1, 5 do
		local animNode = self._rolePanel:getChildByFullName("role_" .. i)
		local nodeToActionMap = {}

		nodeToActionMap[animNode] = anim:getChildByFullName("point_" .. i)

		local startFunc2, stopFunc2 = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode, false)

		startFunc2()
		anim:addCallbackAtFrame(40, function()
			self._maskTouchLayout:setVisible(false)
			stopFunc2()
		end)
	end

	for i = 1, 5 do
		local animNode = self._rolePanel:getChildByFullName("light_" .. i)
		local nodeToActionMap = {}

		nodeToActionMap[animNode] = anim:getChildByFullName("light_" .. i)

		local startFunc2, stopFunc2 = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode, false)

		startFunc2()
		anim:addCallbackAtFrame(40, function()
			stopFunc2()
		end)
	end

	local animxiaotubiao = cc.MovieClip:create("xiaotubiao_mengjingyuanzheng")

	animxiaotubiao:addTo(self._mainPanel):center(self._mainPanel:getContentSize())

	local bgBottom = self._mainPanel:getChildByFullName("bg_bottom")
	local recommendHero = bgBottom:getChildByFullName("recommendHero1")

	for i = 1, 3 do
		local nodeToActionMap = {}

		nodeToActionMap[recommendHero] = animxiaotubiao:getChildByFullName("buff_" .. i)

		local startFunc2, stopFunc2 = CommonUtils.bindNodeToActionNode(nodeToActionMap, recommendHero, false)

		startFunc2()
		animxiaotubiao:addCallbackAtFrame(30, function()
			stopFunc2()
		end)
	end

	for i = 1, 2 do
		local rewardIcon = self._rewardPanel:getChildByFullName("rewardIcon" .. i)

		if rewardIcon then
			local donguzo = animxiaotubiao:getChildByFullName("reward_" .. i)

			self:addAnimToNode(rewardIcon, donguzo, animxiaotubiao)
		end
	end

	for i = 4, 5 do
		local recommendHero = bgBottom:getChildByFullName("recommendHero" .. i - 2)

		if recommendHero then
			local donguzo = animxiaotubiao:getChildByFullName("buff_" .. i)

			self:addAnimToNode(recommendHero, donguzo, animxiaotubiao)
		end
	end

	local mengjingyuanzheng = cc.MovieClip:create("mengjingyuanzheng_mengjingyuanzheng")

	mengjingyuanzheng:addTo(self._mainPanel):center(self._mainPanel:getContentSize())

	local powerAct = mengjingyuanzheng:getChildByFullName("powerAct")
	local powerPanel = self._namePanel:getChildByFullName("powerPanel")

	self:addAnimToNode(powerPanel, powerAct, mengjingyuanzheng)
	mengjingyuanzheng:addCallbackAtFrame(40, function()
		mengjingyuanzheng:stop()
	end)
	self._mainPanel:getChildByFullName("bg_bottom.Node_9"):setVisible(false)
	mengjingyuanzheng:addCallbackAtFrame(17, function()
		local tuijian = cc.MovieClip:create("tuijian_mengjingyuanzheng")
		local recommend = self._mainPanel:getChildByFullName("bg_bottom.Node_9")

		recommend:setVisible(true)
		tuijian:addTo(recommend):center(recommend:getContentSize())
		tuijian:addCallbackAtFrame(12, function()
			tuijian:stop()
		end)

		local tuijianAct = tuijian:getChildByFullName("tuijianAct")
		local text = self._mainPanel:getChildByFullName("bg_bottom.Node_9.text")

		self:addAnimToNode(text, tuijianAct, mengjingyuanzheng)
	end)

	local nameBg = self._namePanel:getChildByFullName("nameBg")
	local nameAct = mengjingyuanzheng:getChildByFullName("nameAct")

	self:addAnimToNode(nameBg, nameAct, mengjingyuanzheng)

	local rolePanel = self._mainPanel:getChildByFullName("rolePanel")
	local pointPanel = rolePanel:getChildByFullName("pointPanel")
	local keyPointAct = mengjingyuanzheng:getChildByFullName("keyPointAct")

	self:addAnimToNode(pointPanel, keyPointAct, mengjingyuanzheng)

	local curRule = self._namePanel:getChildByFullName("curRule")
	local curRuleAct = mengjingyuanzheng:getChildByFullName("curRuleAct")

	self:addAnimToNode(curRule, curRuleAct, mengjingyuanzheng)

	local tuijian = cc.MovieClip:create("tuijian_mengjingyuanzheng")
	local recommend = self._mainPanel:getChildByFullName("bg_bottom.Node_recommend")

	tuijian:addTo(recommend):center(recommend:getContentSize())
	tuijian:addCallbackAtFrame(12, function()
		tuijian:stop()
	end)

	local tuijianAct = tuijian:getChildByFullName("tuijianAct")
	local text = self._mainPanel:getChildByFullName("bg_bottom.Node_recommend.text")

	self:addAnimToNode(text, tuijianAct, mengjingyuanzheng)

	local timeAct = mengjingyuanzheng:getChildByFullName("timeAct")

	self:addAnimToNode(self._progressPanel, timeAct, mengjingyuanzheng)

	local bgAct = mengjingyuanzheng:getChildByFullName("bgAct")

	self:addAnimToNode(self._bg, bgAct, mengjingyuanzheng)

	if self._crusadeSystem:canCrusadeSweep() then
		self._sweepBtn:setVisible(true)
		self._sweepBtn:setPosition(btnPos.button_sweep_2)
		self._recruitBtn:setPosition(btnPos.button_recruit_2)

		local saodangAct = mengjingyuanzheng:getChildByFullName("saodangAct")

		self:addAnimToNode(self._sweepBtn, saodangAct, mengjingyuanzheng)
	else
		self._sweepBtn:setVisible(false)
		self._recruitBtn:setPosition(btnPos.button_recruit_1)
	end
end

function CrusadeMainMediator:addAnimToNode(node, donguzo, anim)
	local nodeToActionMap = {}

	nodeToActionMap[node] = donguzo

	local startFunc2, stopFunc2 = CommonUtils.bindNodeToActionNode(nodeToActionMap, node, false)

	startFunc2()
	anim:addCallbackAtFrame(30, function()
		if not tolua.isnull(node) then
			stopFunc2()
		end
	end)
end

function CrusadeMainMediator:addCurPointAnim(pointNode)
	local jiedianguang = cc.MovieClip:create("jiedianguang_mengjingyuanzheng")

	jiedianguang:addTo(pointNode):posite(-1.94, 30)

	local jiediankuo = cc.MovieClip:create("jiediankuo_mengjingyuanzheng")

	jiediankuo:addTo(pointNode):posite(-1.94, 9)
end

function CrusadeMainMediator:addAttackBtnAnim(node)
	local tzzkuo = cc.MovieClip:create("tzzkuo_mengjingyuanzheng")

	tzzkuo:addTo(node):center(node:getContentSize())

	local tzz = cc.MovieClip:create("tzz_mengjingyuanzheng")
	local TZtext = tzz:getChildByFullName("TZtext")

	tzz:addTo(node):center(node:getContentSize())
	tzz:addCallbackAtFrame(6, function()
		if TZtext and getCurrentLanguage() ~= GameLanguageType.CN then
			TZtext:setPositionX(-25)
		end

		tzz:stop()
	end)
	tzzkuo:setName("tzzkuo")
	tzz:setName("tzz")
end
