-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/EntranceGodhandMediator.lua

EntranceGodhandMediator = class("EntranceGodhandMediator", DmAreaViewMediator, _M)

EntranceGodhandMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
EntranceGodhandMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")
EntranceGodhandMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
EntranceGodhandMediator:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")
EntranceGodhandMediator:has("_spStageSystem", {
	is = "r"
}):injectWith("SpStageSystem")
EntranceGodhandMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
EntranceGodhandMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")
EntranceGodhandMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")
EntranceGodhandMediator:has("_dreamChallengeSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")
EntranceGodhandMediator:has("_dreamHouseSystem", {
	is = "r"
}):injectWith("DreamHouseSystem")

local configValueKey = ConfigReader:getDataByNameIdAndKey("ConfigValue", "TrialSwitch", "content")
local kCells = {
	kDreamChallenge = "dreamchallenge",
	kSpStage = "spstage",
	kExplore = "explore",
	kCrusade = "crusade",
	kTower = "tower",
	kPractice = "practice",
	kDreamHouse = "dreamhouse"
}
local kFunctionData = {
	[kCells.kPractice] = {
		animName = "practiceCell_shilianrukou",
		switchKey = "fn_train_practice",
		des = Strings:get("Train_Desc"),
		titleStr = Strings:get("TrialTitle_MYYJS")
	},
	[kCells.kSpStage] = {
		animName = "spstageCell_shilianrukou",
		switchKey = "fn_train_stage",
		des = Strings:get("DailyTest_Desc"),
		titleStr = Strings:get("TrialTitle_RCSL")
	},
	[kCells.kExplore] = {
		animName = "exploreCell_shilianrukou",
		switchKey = "fn_train_explore",
		des = Strings:get("Explore_Desc"),
		titleStr = Strings:get("TrialTitle_TS")
	},
	[kCells.kDreamHouse] = {
		animName = "bumengguan_shilianrukou",
		switchKey = "fn_train_dreamhouse",
		des = Strings:get("DreamHouse_Desc"),
		titleStr = Strings:get("DreamHouse_Main_UI04")
	},
	[kCells.kTower] = {
		animName = "pataCell_shilianrukou",
		switchKey = "fn_train_tower",
		des = Strings:get("Tower_Desc"),
		titleStr = Strings:get("TrialTitle_MJ")
	},
	[kCells.kCrusade] = {
		animName = "crusadeCell_shilianrukou",
		switchKey = "fn_train_crusade",
		des = Strings:get("Crusade_UI16"),
		titleStr = Strings:get("TrialTitle_MJYZ")
	},
	[kCells.kDreamChallenge] = {
		animName = "dreamCell_shilianrukou",
		switchKey = "fn_dream_tower",
		des = Strings:get("DreamChallenge_Desc"),
		titleStr = Strings:get("DreamChallenge_Title")
	}
}

function EntranceGodhandMediator:initialize()
	super.initialize(self)
end

function EntranceGodhandMediator:dispose()
	super.dispose(self)
end

function EntranceGodhandMediator:onRegister()
	super.onRegister(self)
end

function EntranceGodhandMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("FUNCTION_ENTRANCE_TITLE1")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function EntranceGodhandMediator:enterWithData()
	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:setupClickEnvs()
end

function EntranceGodhandMediator:resumeWithData()
	self:refreshRed()
	self:refreshDreamActivityRulePanel()
end

function EntranceGodhandMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._scrollView = self._main:getChildByFullName("scrollView")

	self._scrollView:setScrollBarEnabled(false)
	self._scrollView:removeAllChildren()

	self._blockPanel = self._main:getChildByFullName("blockPanel")
	self._cellClone = self._main:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	local backgroundBG = self._main:getChildByFullName("backgroundBG")

	backgroundBG:setPosition(cc.p(568, 310))
	backgroundBG:runAction(cc.MoveTo:create(0.26666666666666666, cc.p(568, 320)))

	local animPanel = self._blockPanel:getChildByFullName("animPanel")
	local slAnim = cc.MovieClip:create("shilianrukou_shilianrukou")

	slAnim:setPosition(cc.p(0, 0))
	animPanel:addChild(slAnim)
	slAnim:addCallbackAtFrame(16, function()
		slAnim:stop()
	end)

	local lightFlash = cc.MovieClip:create("ggyun_zhuxianzhuanchang")

	lightFlash:setPosition(cc.p(0, 0))
	lightFlash:setColorTransform(ColorTransform(1, 1, 1, 0.2))
	animPanel:addChild(lightFlash)

	local offsetX = 0
	local idx = 0

	for i = 1, #configValueKey do
		local key = configValueKey[i]
		local value = kFunctionData[key]

		if CommonUtils.GetSwitch(value.switchKey) then
			idx = idx + 1

			local parentCell = self._cellClone:clone()

			parentCell:setName(key)
			parentCell:addTo(self._scrollView)

			local x = 177 + (idx - 1) * 264
			local y = idx % 2 == 0 and 406 or 327

			parentCell:setPosition(cc.p(x, y))
			parentCell:addClickEventListener(function()
				self:clickPanel(key)
			end)

			local redPoint = parentCell:getChildByFullName("redPoint"):clone()

			parentCell:removeAllChildren()

			local anim = cc.MovieClip:create(value.animName)

			anim:addTo(parentCell):center(parentCell:getContentSize()):offset(0, -30)
			anim:addCallbackAtFrame(33, function()
				anim:stop()
			end)
			anim:setName("ShowAnim")

			if kCells.kDreamChallenge == key then
				if self._dreamChallengeSystem:checkActivityDreamChallengeOpen() then
					self:createDreamChallengeActivityRulePanel(anim)
				else
					self:createRulePanel(anim, value.des)
				end
			else
				self:createRulePanel(anim, value.des)
			end

			if kCells.kExplore == key then
				self:createResourceDoubleView(anim)
			end

			self:createNamePanel(anim, value.titleStr)
			redPoint:addTo(anim):posite(120, -25)
			redPoint:setLocalZOrder(3)

			parentCell.redPoint = redPoint

			parentCell.redPoint:setOpacity(0)
			parentCell.redPoint:fadeIn({
				time = 0.2
			})

			local resShow = self:checkHasRed(key)

			if redPoint then
				redPoint:setVisible(resShow)
			end

			self:runNodeAction(parentCell, idx)

			offsetX = x
		end
	end

	local size = self._scrollView:getContentSize()
	local width = math.max(size.width, offsetX + 177 + AdjustUtils.getAdjustX())

	self._scrollView:setInnerContainerSize(cc.size(width, size.height))
end

function EntranceGodhandMediator:runNodeAction(parentCell, index)
	local delayTime = 0.1

	parentCell:setOpacity(0)
	parentCell:setScale(0.2)

	local delay = cc.DelayTime:create(0.16666666666666666 + (index - 1) * delayTime)
	local fadeIn = cc.FadeIn:create(0.2)
	local scaleTo1 = cc.ScaleTo:create(0.2, 1.1)
	local callfunc = cc.CallFunc:create(function()
		parentCell:setVisible(true)
		parentCell:getChildByFullName("ShowAnim"):gotoAndPlay(0)
	end)
	local spawn = cc.Spawn:create(fadeIn, scaleTo1)
	local scaleTo2 = cc.ScaleTo:create(0.23333333333333334, 0.85)

	parentCell:runAction(cc.Sequence:create(delay, callfunc, spawn, scaleTo2))
end

function EntranceGodhandMediator:createRulePanel(parent, str, notAnim)
	local image = ccui.ImageView:create("asset/common/sl_bg_msd.png")

	image:setAnchorPoint(cc.p(1, 0.5))
	image:addTo(parent):posite(132, -13)
	image:setName("rule")

	local label = cc.Label:createWithTTF(str, TTF_FONT_FZYH_M, 19)

	GameStyle:setCommonOutlineEffect(label, 255)
	label:addTo(image):posite(image:getContentSize().width / 2, 32)
	label:setOverflow(cc.LabelOverflow.SHRINK)
	label:setDimensions(300, 85)
	label:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)

	local language = getCurrentLanguage()

	if language ~= GameLanguageType.CN then
		label:setLineSpacing(-5)
	end

	if not notAnim then
		image:setOpacity(0)
		performWithDelay(self:getView(), function()
			image:fadeIn({
				time = 0.2
			})
		end, 0.5)
	end

	return image
end

function EntranceGodhandMediator:createResourceDoubleView(parent)
	local unlock, tips = self._exploreSystem:checkEnabled()

	if not unlock then
		return
	end

	local gameEvn = ResourceDoubleActivityEvn.kMapStage

	if not self._resourceDoubleWidget then
		local activitySystem = self:getInjector():getInstance(ActivitySystem)
		local resourceDoubleSystem = activitySystem:getResourceDoubleActivitySystem()
		local effectConfig = resourceDoubleSystem:getDoubleResConfigByEvn({
			gameEvn
		})

		self._doubleConfig = effectConfig
		self._resourceDoubleWidget = ResourceDoubleWidget:new(ResourceDoubleWidget:createTitleIcon(effectConfig, {
			textId = "Activity_Xianshi_Hong_1",
			iconType = ResourceDoubleIconType.kRed
		}), parent, function()
			return resourceDoubleSystem:getDoubleResConfigByEvn({
				gameEvn
			})
		end)

		self._resourceDoubleWidget:getView():setPosition(75, -100)
		self._resourceDoubleWidget:getView():setLocalZOrder(950)
	end
end

function EntranceGodhandMediator:createDreamChallengeActivityRulePanel(parent, notAnim)
	local image = ccui.ImageView:create("asset/common/sl_bg_msd.png")
	local str = Strings:get("DreamChallenge_Entry_Tip02")

	image:setAnchorPoint(cc.p(1, 0.5))
	image:addTo(parent):posite(132, -13)
	image:setName("rule")

	local label = cc.Label:createWithTTF(str, TTF_FONT_FZYH_R, 26)

	GameStyle:setCommonOutlineEffect(label, 255)
	label:addTo(image):posite(image:getContentSize().width / 2, 40)
	label:setTextColor(cc.c3b(255, 242, 155))
	label:enableOutline(cc.c4b(3, 1, 4, 255), 1)
	label:setOverflow(cc.LabelOverflow.SHRINK)
	label:setDimensions(300, 45)
	label:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)

	if not notAnim then
		image:setOpacity(0)
		performWithDelay(self:getView(), function()
			image:fadeIn({
				time = 0.2
			})
		end, 0.5)
	end

	return image
end

function EntranceGodhandMediator:refreshDreamActivityRulePanel()
	local anim = self._scrollView:getChildByFullName("dreamchallenge.ShowAnim")

	if anim then
		anim:removeChildByName("rule")

		if self._dreamChallengeSystem:checkActivityDreamChallengeOpen() then
			self:createDreamChallengeActivityRulePanel(anim, true)
		else
			self:createRulePanel(anim, kFunctionData[kCells.kDreamChallenge].des, true)
		end
	end
end

function EntranceGodhandMediator:createNamePanel(parent, str)
	local nameNode = parent:getChildByFullName("nameNode")

	if not nameNode then
		dump(str, "createNamePanel >>>>>>")

		return
	end

	local label = cc.Label:createWithTTF(str, CUSTOM_TTF_FONT_1, 38)

	GameStyle:setCommonOutlineEffect(label, 255)
	label:setAnchorPoint(cc.p(0.5, 0.5))
	label:addTo(nameNode):posite(0, 3)
	label:setOverflow(cc.LabelOverflow.SHRINK)
	label:setDimensions(250, 85)
	label:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)

	local language = getCurrentLanguage()

	if language ~= GameLanguageType.CN then
		label:setLineSpacing(-10)
	end
end

function EntranceGodhandMediator:clickPanel(index)
	if index == kCells.kPractice then
		self:enterPracticeView()
	elseif index == kCells.kSpStage then
		self:enterBlockSpView()
	elseif index == kCells.kExplore then
		self:enterExploreView()
	elseif index == kCells.kTower then
		self:enterTowerView()
	elseif index == kCells.kCrusade then
		self:enterCrusadeView()
	elseif index == kCells.kDreamChallenge then
		self:enterDreamChallenge()
	elseif index == kCells.kDreamHouse then
		self:enterDreamHouse()
	end
end

function EntranceGodhandMediator:refreshRed()
	for i = 1, #configValueKey do
		local key = configValueKey[i]
		local panel = self._scrollView:getChildByFullName(key)

		if panel then
			local redPoint = panel.redPoint
			local resShow = self:checkHasRed(key)

			if redPoint then
				redPoint:setVisible(resShow)
			end
		end
	end
end

function EntranceGodhandMediator:checkHasRed(key)
	local redFunc = {
		[kCells.kPractice] = function()
			return self._stagePracticeSystem:checkAwardRed()
		end,
		[kCells.kSpStage] = function()
			return self._spStageSystem:checkIsShowRedPoint()
		end,
		[kCells.kExplore] = function()
			return self._exploreSystem:checkIsShowRedPoint()
		end,
		[kCells.kTower] = function()
			return false
		end,
		[kCells.kCrusade] = function()
			return self._crusadeSystem:canCrusadeSweep() or self._crusadeSystem:crusadeRedPointState()
		end,
		[kCells.kDreamChallenge] = function()
			return self._dreamChallengeSystem:checkIsShowRedPoint()
		end,
		[kCells.kDreamHouse] = function()
			return self._dreamHouseSystem:checkIsShowRedPoint()
		end
	}

	if redFunc[key] then
		return redFunc[key]()
	end

	return false
end

function EntranceGodhandMediator:enterBlockSpView()
	local unlock, tips = self._spStageSystem:checkEnabled()

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self._spStageSystem:tryEnter()
	end
end

function EntranceGodhandMediator:enterPracticeView()
	local systemKeeper = self:getSystemKeeper()
	local unlock, tips, unLockLevel = systemKeeper:isUnlock("Stage_Practice")

	if unlock then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		local view = self:getInjector():getInstance("StagePracticeEnterView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
	end
end

function EntranceGodhandMediator:enterExploreView()
	local unlock, tips = self._exploreSystem:checkEnabled()

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self._exploreSystem:tryEnter()
	end
end

function EntranceGodhandMediator:enterTowerView()
	local unlock, tips = self._towerSystem:checkEnabled()

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self._towerSystem:tryEnter()
	end
end

function EntranceGodhandMediator:enterCrusadeView()
	local unlock, tips = self._crusadeSystem:checkEnabled()

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self._crusadeSystem:tryEnter()
	end
end

function EntranceGodhandMediator:enterDreamChallenge()
	self._dreamChallengeSystem:tryEnter()
end

function EntranceGodhandMediator:enterDreamHouse()
	local unlock, tips = self._dreamHouseSystem:checkEnabled()

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
		self._dreamHouseSystem:tryEnter()
	end
end

function EntranceGodhandMediator:onClickBack()
	for i = 1, #configValueKey do
		local key = configValueKey[i]
		local panel = self._scrollView:getChildByFullName(key)

		if panel then
			panel:stopAllActions()
		end
	end

	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function EntranceGodhandMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()
	local scriptName = guideAgent:getCurrentScriptName()

	if scriptName and scriptName == "guide_Stage_Practice" then
		local panel = self._scrollView:getChildByFullName("practice")
		local posX = panel:getPositionX()
		local width = self._scrollView:getContentSize().width

		self._scrollView:jumpToPercentHorizontal(math.max(posX - width, 0))
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		for i = 1, #configValueKey do
			local key = configValueKey[i]
			local panel = self._scrollView:getChildByFullName(key)

			if panel then
				storyDirector:setClickEnv("functionEntrance.node_" .. key, panel, function(sender, eventType)
					self:clickPanel(key)
				end)
			end
		end

		storyDirector:notifyWaiting("enter_FunctionEntrance_view")
	end))

	self:getView():runAction(sequence)
end

function EntranceGodhandMediator:didFinishResumeTransition()
	local winSize = cc.Director:getInstance():getWinSize()
	local transitionView = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), winSize.width, winSize.height)

	transitionView:addTo(self:getView())
	transitionView:center(cc.size(1136, 640))
	transitionView:runAction(cc.Sequence:create(cc.FadeTo:create(0.1, 0), cc.CallFunc:create(function()
		transitionView:removeFromParent(true)
	end)))
end
