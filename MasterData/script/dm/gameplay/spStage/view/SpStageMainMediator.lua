-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/view/SpStageMainMediator.lua

SpStageMainMediator = class("SpStageMainMediator", DmAreaViewMediator, _M)

SpStageMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
SpStageMainMediator:has("_spStageSystem", {
	is = "r"
}):injectWith("SpStageSystem")
SpStageMainMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
SpStageMainMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
SpStageMainMediator:has("_customDataSystem", {
	is = "rw"
}):injectWith("CustomDataSystem")

local kBtnHandlers = {
	["bg.main_panel.button_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	},
	button_info = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickInfo"
	}
}
local BGImage = {
	[SpStageType.kGold] = "ziyuanfuben_img_bgbsnh0.jpg",
	[SpStageType.kCrystal] = "ziyuanfuben_img_bgbsg.jpg",
	[SpStageType.kExp] = "bg_story_scene_1_4.jpg",
	[SpStageType.kEquip] = "ziyuanfuben_img_bgdhwz.jpg",
	[SpStageType.kSkill1] = "ziyuanfuben_img_bgbsg1.jpg",
	[SpStageType.kSkill2] = "ziyuanfuben_img_bgbsg1.jpg",
	[SpStageType.kSkill3] = "ziyuanfuben_img_bgbsg1.jpg"
}
local RoleImage = {
	[SpStageType.kExp] = "FTLEShi",
	[SpStageType.kGold] = "SDTZi",
	[SpStageType.kEquip] = "BBLMa",
	[SpStageType.kSkill1] = "TLMi",
	[SpStageType.kSkill2] = "LLan",
	[SpStageType.kSkill3] = "SGHQShou",
	[SpStageType.kCrystal] = "MGNa"
}
local RoleImageScale = {
	[SpStageType.kCrystal] = {
		0.88,
		60,
		30
	}
}
local kTabTypeBg = {
	["bg.expPanel"] = {
		SpStageType.kExp
	},
	["bg.equipPanel"] = {
		SpStageType.kEquip
	},
	["bg.goldPanel"] = {
		SpStageType.kGold
	},
	["bg.skillPanel"] = {
		SpStageType.kSkill1,
		SpStageType.kSkill3,
		SpStageType.kSkill2
	}
}
local kTabTypeBgImage = {
	[SpStageType.kSkill1] = "asset/ui/spStageBg/zyfb_bg_d02.png",
	[SpStageType.kSkill2] = "asset/ui/spStageBg/zyfb_bg_d03.png",
	[SpStageType.kSkill3] = "asset/ui/spStageBg/zyfb_bg_d02.png"
}
local kGameEnvMap = {
	StageSp_Gold = ResourceDoubleActivityEvn.kGoldStage,
	StageSp_Exp = ResourceDoubleActivityEvn.kExpStage,
	StageSp_Crystal = ResourceDoubleActivityEvn.kCrystalStage
}

function SpStageMainMediator:initialize()
	super.initialize(self)
end

function SpStageMainMediator:dispose()
	super.dispose(self)
end

function SpStageMainMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function SpStageMainMediator:bindWidgets()
	self:bindWidget("bg.main_panel.box_panel.button_battle", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickBattle, self)
		}
	})
end

function SpStageMainMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LEAVETIME_CHANGE, self, self.resumeWithData)
end

function SpStageMainMediator:refreshData()
	self._config = self._spStageSystem:getStageConfigList()
	self._kUnlockTypeMap = {}
	self._kTabTypeMap = {}
	self._kLockTip = {}
	self._kUnLockState = {}
	self._isShowRuleView = false

	for i = 1, #self._config do
		local condition = self._config[i].UnlockCondition
		local stageType = self._spStageSystem:getStageTypeById(self._config[i].Id)
		local unlock, tip, unlockLevel = self._systemKeeper:isUnlock(condition)
		local data = kSpStageTeamAndPointType[stageType]

		if data then
			self._kUnlockTypeMap[i] = stageType
			self._kUnLockState[i] = unlock
			self._kLockTip[i] = tip
			self._kTabTypeMap[stageType] = i
		end
	end
end

function SpStageMainMediator:enterWithData(data)
	self:refreshData()

	local inMain = self._spStageSystem:getInSpStageMain()

	if inMain == 0 then
		self._spStageSystem:setInSpStageMain(1)

		if data then
			self._curTabType = data.tabType or 1
		end

		if data and data.spType then
			self._curTabType = self._kTabTypeMap[data.spType]
		end

		self._spStageSystem:setInSpStageType(self._curTabType)
	else
		self._curTabType = self._spStageSystem:getInSpStageType() or 1
	end

	self._spType = self._kUnlockTypeMap[self._curTabType]
	self._refreshView = false

	self:initWidgetInfo()
	self:setupTopInfoWidget()
	self:createTabController()
	self:refreshMainPanel()
	self:refreshBoxPanel()
	self:refreshBg()
	self:refreshSelectTip()
	self:showRule()
	self:setupClickEnvs()
end

function SpStageMainMediator:resumeWithData()
	self:refreshData()
	self:refreshLeftPanel()
	self:refreshSelectTip()
	self:refreshMainPanel()
	self:refreshBoxPanel()
	self:refreshBg()
end

function SpStageMainMediator:initWidgetInfo()
	self._bg = self:getView():getChildByName("bg")
	self._roleNode = self._bg:getChildByName("roleNode")
	self._mainPanel = self._bg:getChildByName("main_panel")
	self._leftPanel = self:getView():getChildByName("left_panel")
	self._boxPanel = self._mainPanel:getChildByName("box_panel")

	self._boxPanel:setLocalZOrder(10)

	self._rewardBg = self._mainPanel:getChildByName("reward_panel")
	self._heroPanel = self._mainPanel:getChildByName("heroPanel")
	self._notice = self._boxPanel:getChildByName("notice")
	self._text1 = self._boxPanel:getChildByName("text1")
	self._text2 = self._boxPanel:getChildByName("text2")

	if getCurrentLanguage() == GameLanguageType.TH then
		self._heroPanel:getChildByName("label_2"):setFontSize(30)
	end

	GameStyle:setCommonOutlineEffect(self._mainPanel:getChildByName("title"))
	GameStyle:setCommonOutlineEffect(self._mainPanel:getChildByName("desc"))
	GameStyle:setCommonOutlineEffect(self._mainPanel:getChildByFullName("heroPanel.label_1"))
	GameStyle:setCommonOutlineEffect(self._mainPanel:getChildByFullName("heroPanel.label_2"))
	GameStyle:setCommonOutlineEffect(self._mainPanel:getChildByFullName("reward_panel.text"))
	GameStyle:setCommonOutlineEffect(self._boxPanel:getChildByName("text1"))
	GameStyle:setCommonOutlineEffect(self._boxPanel:getChildByName("text2"))
	self:ignoreSafeArea()
end

function SpStageMainMediator:ignoreSafeArea()
	return
end

function SpStageMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
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
		title = Strings:get("SPECIAL_STAGE_TEXT_3"),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function SpStageMainMediator:createTabController()
	local config = self:getTabData()
	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 480)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._leftPanel):posite(0, -2)
	view:setLocalZOrder(1100)
	self._tabBtnWidget:scrollTabPanel(self._curTabType)
end

function SpStageMainMediator:getTabData()
	local length = #self._config
	local changeTabType = false

	if self._config[self._curTabType] then
		local stageId = self._config[self._curTabType].Id
		local isOpenByActivity = self._spStageSystem:getOpenByActivity(stageId)
		local isOpen, str = self._spStageSystem:getOpenTimeStr(stageId)

		if not self._kUnLockState[self._curTabType] or not ((isOpenByActivity or nil) and isOpenByActivity) then
			changeTabType = true
		end
	end

	local data = {}

	for i = 1, length do
		local stageId = self._config[i].Id
		local isOpen, str = self._spStageSystem:getOpenTimeStr(stageId)
		local key = self._kUnlockTypeMap[i]
		local lock = not self._kUnLockState[i]
		local dataLength = #data + 1

		data[dataLength] = {
			tabText = Strings:get(self._config[i].Name),
			tabTextTranslate = Strings:get(self._config[i].ENName),
			lock = lock,
			stageId = stageId,
			redPointFunc = function()
				return not lock and self._spStageSystem:getSpStageTabRed(key)
			end
		}
		isOpen = isOpen or self._spStageSystem:getOpenByActivity(stageId)

		if self._kUnLockState[i] then
			local activitySystem = self:getInjector():getInstance(ActivitySystem)
			local resourceDoubleSystem = activitySystem:getResourceDoubleActivitySystem()
			local gameEvn = kGameEnvMap[self._config[i].Id]
			local effectConfig = resourceDoubleSystem:getDoubleResConfigByEvn({
				gameEvn
			})

			if effectConfig then
				data[dataLength].effectConfig = effectConfig
			end
		end

		if self._kUnLockState[i] and isOpen and changeTabType then
			changeTabType = false

			local oldCurTabType = self._spStageSystem:getInSpStageType()

			self._curTabType = oldCurTabType ~= self._curTabType and oldCurTabType or i
			self._spType = self._kUnlockTypeMap[self._curTabType]
		end
	end

	if #data > 5 then
		self._leftPanel:getChildByFullName("Image_1"):setVisible(true)
	else
		self._leftPanel:getChildByFullName("Image_1"):setVisible(false)
	end

	return {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end,
		btnDatas = data
	}
end

function SpStageMainMediator:refreshLeftPanel()
	local config = self:getTabData()

	if self._tabBtnWidget then
		self._tabBtnWidget:refreshView(config, {
			ignoreSound = true,
			noCenterBtn = true
		})
		self._tabBtnWidget:selectTabByTag(self._curTabType)
	end
end

function SpStageMainMediator:refreshSelectTip()
	local length = #self._tabBtnWidget:getTabBtns()

	for i = 1, length do
		local config = self._config[i]
		local stageId = config.Id
		local btn = self._tabBtnWidget:getTabBtns()[i]
		local isOpenByActivity = self._spStageSystem:getOpenByActivity(stageId)
		local isOpen, str = self._spStageSystem:getOpenTimeStr(stageId)

		if not self._kUnLockState[i] then
			str = self._kLockTip[i]
		elseif isOpenByActivity then
			str = Strings:get("SPECIAL_STAGE_TEXT_34", {
				fontName = TTF_FONT_FZYH_R
			})
			isOpen = isOpenByActivity
		end

		btn:removeChildByName("TipLabel")

		if str ~= "" then
			local image = ccui.ImageView:create("zyfb_bg_kfd.png", 1)

			image:addTo(btn, 10)
			image:setName("TipLabel")
			image:setPosition(cc.p(113, 23))

			local desc = ccui.RichText:createWithXML(str, {})

			desc:addTo(image)
			desc:setAnchorPoint(cc.p(0.5, 0.5))
			desc:setPosition(cc.p(71.5, 9))
		end
	end
end

function SpStageMainMediator:refreshMainPanel()
	local config = self._config[self._curTabType]

	if not config then
		return
	end

	local title = Strings:get(config.Name)

	self._mainPanel:getChildByName("title"):setString(title)
	self._mainPanel:getChildByName("desc"):setString("")

	local desc = Strings:get(kSpStageTeamAndPointType[self._spType].rule, {
		fontName = TTF_FONT_FZYH_R
	})
	local defaults = {}
	local label = ccui.RichText:createWithXML(desc, defaults)

	label:renderContent(409, 0)
	self._mainPanel:getChildByName("desc"):removeAllChildren()
	self._mainPanel:getChildByName("desc"):addChild(label)
	label:setAnchorPoint(cc.p(0, 1))

	local offsetHeight = 0
	local var_18_0

	if getCurrentLanguage() ~= GameLanguageType.CN then
		offsetHeight = 35
		var_18_0 = self._mainPanel:getChildByName("desc")
	end

	label:setPosition(cc.p(0, var_18_0:getContentSize().height + offsetHeight))

	local rewards = self:getSpStageSystem():getRewardById(config.Id)
	local index = 0

	for i = 1, 4 do
		local rewardData = rewards[#rewards - index]
		local iconBg = self._rewardBg:getChildByName("icon" .. i)

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

			if rewardData.image and rewardData.image ~= "" then
				local image = ccui.ImageView:create(rewardData.image .. ".png", 1)

				image:setScale9Enabled(true)
				image:setCapInsets(cc.rect(17, 11, 10, 10))
				image:addTo(iconBg):center(iconBg:getContentSize())
				image:offset(2, -30)
				image:setScale(0.8)

				local text = cc.Label:createWithTTF(Strings:get(rewardData.text), TTF_FONT_FZYH_M, (getCurrentLanguage() ~= GameLanguageType.CN or nil) and 13)

				text:addTo(image)
				text:setColor(cc.c3b(255, 255, 255))

				local width = math.max(52, text:getContentSize().width + 18)
				local height = image:getContentSize().height

				image:setContentSize(cc.size(width, height))
				text:setPosition(cc.p(width / 2 - 2.5, height / 2 + 3))
			end
		end
	end

	local descs = self._spStageSystem:getSpecialDesc(config.Id)

	self._heroPanel:getChildByName("label_1"):setString(descs[1])
	self._heroPanel:getChildByName("label_2"):setString(descs[2])

	local jobs = self:getSpStageSystem():getIntroductionJob(config.Id)

	for i = 1, 3 do
		local occupationNode = self._heroPanel:getChildByName("occupation" .. i)

		occupationNode:removeAllChildren()

		if jobs[i] then
			local occupationName, occupationImg = GameStyle:getHeroOccupation(jobs[i])
			local image = ccui.ImageView:create()

			image:loadTexture(occupationImg)
			image:addTo(occupationNode):center(occupationNode:getContentSize()):offset(0, 5)
			image:setScale(0.6)
			occupationNode:setVisible(true)
		else
			occupationNode:setVisible(false)
		end
	end
end

function SpStageMainMediator:refreshBoxPanel()
	local stageId = self._config[self._curTabType].Id
	local spType = self._kUnlockTypeMap[self._curTabType]
	local rewardTimes = self:getSpStageSystem():getExtraRewardTime(stageId, spType)
	local leaveTimes = self:getSpStageSystem():getStageLeaveTime(stageId)
	local rewardTimesLimit = ConfigReader:getDataByNameIdAndKey("Reset", SpExtraResetId[stageId], "ResetSystem").max or rewardTimes or 1
	local leaveTimesLimit = ConfigReader:getDataByNameIdAndKey("Reset", SpStageResetId[stageId], "ResetSystem").max or leaveTimes or 1

	self._text2:setString(Strings:get("BLOCKSP_UI19", {
		num1 = rewardTimes,
		num2 = rewardTimesLimit
	}))
	self._text1:setString(Strings:get("BLOCKSP_UI3", {
		num1 = leaveTimes,
		num2 = leaveTimesLimit
	}))

	local unlock, tips = self._systemKeeper:isUnlock(stageId)
	local isOpenByActivity, str = self:getSpStageSystem():getOpenByActivity(stageId)
	local isOpen, timeStr = self._spStageSystem:getOpenTimeStr(stageId)

	self._notice:setString("")
	self._notice:setVisible(false)
	self._notice:removeAllChildren()

	local desc = ccui.RichText:createWithXML(timeStr, {})

	desc:addTo(self._notice)
	desc:setAnchorPoint(cc.p(0, 0))
	desc:setPosition(cc.p(0, 0))

	local visible = unlock and (isOpenByActivity or isOpen)

	self._text1:setVisible(visible)
	self._text2:setVisible(visible)
	self._notice:setVisible(unlock and not isOpenByActivity and not isOpen)

	if not unlock then
		self._notice:setVisible(false)
	end
end

function SpStageMainMediator:refreshBg()
	local bg = self._bg:getChildByFullName("backGround")
	local stageType = self._kUnlockTypeMap[self._curTabType]
	local bgImage = BGImage[stageType]
	local bgImage1 = kTabTypeBgImage[stageType]
	local roleImage = RoleImage[stageType]

	if bgImage then
		bg:loadTexture("asset/scene/" .. bgImage)
		bg:setVisible(true)
	else
		bg:setVisible(false)
	end

	self._roleNode:removeAllChildren()

	if roleImage then
		local roleModel = IconFactory:getRoleModelByKey("HeroBase", roleImage)
		local img = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = roleModel
		})

		self._roleNode:addChild(img)

		local data = RoleImageScale[stageType]

		if data then
			img:setScale(data[1])
			img:offset(data[2], data[3])
		end
	end

	for res, keys in pairs(kTabTypeBg) do
		local panel = self:getView():getChildByFullName(res)

		if table.indexof(keys, stageType) then
			panel:setVisible(true)

			local bg1 = panel:getChildByName("bg")

			if bgImage1 and bg1 then
				bg1:loadTexture(bgImage1)
			end
		else
			panel:setVisible(false)
		end
	end
end

function SpStageMainMediator:onLeaveTimeChange()
	self:refreshData()
	self:refreshLeftPanel()
	self:refreshSelectTip()
	self:refreshMainPanel()
	self:refreshBoxPanel()
	self:refreshBg()
end

function SpStageMainMediator:onClickTab(name, tag)
	self._spStageSystem:resetSpStageTabRed(self._kUnlockTypeMap[tag])

	if not self._refreshView then
		self._refreshView = true

		return
	end

	if tag == self._curTabType then
		return
	end

	local stageId = self._config[tag].Id
	local isOpen, str = self._spStageSystem:getOpenTimeStr(stageId)
	local isOpenByActivity = self._spStageSystem:getOpenByActivity(stageId)

	if not self._kUnLockState[tag] then
		self:dispatch(ShowTipEvent({
			tip = self._kLockTip[tag]
		}))

		return
	elseif not isOpenByActivity and not isOpen then
		self:dispatch(ShowTipEvent({
			tip = str
		}))
	end

	self._curTabType = tag

	self._spStageSystem:setInSpStageType(self._curTabType)

	self._spType = self._kUnlockTypeMap[self._curTabType]

	self:refreshSelectTip()
	self:refreshMainPanel()
	self:refreshBoxPanel()
	self:refreshBg()
	self:showRule()
end

function SpStageMainMediator:showRule()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	if guideAgent:isGuiding() then
		return
	end

	local customKey = "Marking_GuidePic"
	local cjson = require("cjson.safe")
	local customData = cjson.decode(self._customDataSystem:getValue(PrefixType.kGlobal, "GameIntroduce", "{}"))

	if customData[customKey] == nil or customData[customKey] == 0 then
		self:onClickInfo()
	end
end

function SpStageMainMediator:onClickRule()
	if self._isShowRuleView then
		return
	end

	self._isShowRuleView = true

	local this = self
	local view = self:getInjector():getInstance("SpStageRuleView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		title = Strings:get(self._config[self._curTabType].Name),
		rules = self._config[self._curTabType].RuleDesc,
		callback = function()
			if DisposableObject:isDisposed(self) then
				return
			end

			this._isShowRuleView = false
		end
	}, nil))
end

function SpStageMainMediator:onClickInfo()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Marking_Rule", "content")

	RuleFactory:showRules(self, {
		rule = Rule
	}, "Marking_GuidePic")
end

function SpStageMainMediator:onClickRank()
	return
end

function SpStageMainMediator:onClickBattle(sender, eventType)
	local id = self._config[self._curTabType].Id
	local leaveTimes = self:getSpStageSystem():getStageLeaveTime(id)
	local unlock, tips = self._systemKeeper:isUnlock(id)

	if not unlock then
		self:dispatch(ShowTipEvent({
			tip = tips
		}))

		return true
	end

	local isOpenByActivity, str = self:getSpStageSystem():getOpenByActivity(id)

	if not isOpenByActivity then
		local isOpen, str = self:getSpStageSystem():getOpenTimeStr(id)

		if not isOpen then
			self:dispatch(ShowTipEvent({
				tip = str
			}))

			return true
		end
	end

	if leaveTimes <= 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("SPECIAL_STAGE_TEXT_8")
		}))

		return true
	end

	local function callback()
		local data = {}

		data.stageType = self._spType
		data.stageId = id

		local view = self:getInjector():getInstance("SpStageDftView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, nil))
	end

	local params = {}

	params.spType = self:getSpStageSystem():getStageTypeById(id)

	self:getSpStageSystem():requesetGetBestReports(params, true, callback, self)
end

function SpStageMainMediator:onClickBack(sender, eventType)
	self._spStageSystem:setInSpStageMain(0)
	self._spStageSystem:resetRedPointStatus()
	self:dismiss()
end

function SpStageMainMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	if guideAgent:isGuiding() then
		local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			storyDirector:setClickEnv("SpStageMainMediator.rewardBg", self._rewardBg, nil)
			storyDirector:setClickEnv("SpStageMainMediator.heroPanel", self._heroPanel, nil)
			storyDirector:setClickEnv("SpStageMainMediator.boxPanel", self._boxPanel, nil)

			local button_battle = self._boxPanel:getChildByFullName("button_battle")

			storyDirector:setClickEnv("SpStageMainMediator.button_battle", button_battle, function()
				AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
				self:onClickBattle()
			end)
			storyDirector:notifyWaiting("enter_SpStageMainMediator")
		end))

		self:getView():runAction(sequence)
	end
end
