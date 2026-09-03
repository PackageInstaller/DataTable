-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityCommonMainMediator.lua

ActivityCommonMainMediator = class("ActivityCommonMainMediator", DmAreaViewMediator, _M)

ActivityCommonMainMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityCommonMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityCommonMainMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kBtnHandlers = {
	["main.stagePanel.button"] = {
		ignoreClickAudio = true,
		func = "onClickStage"
	},
	["main.addEffectPanel.heroTouch"] = {
		ignoreClickAudio = true,
		func = "onClickAttrAdd"
	},
	["main.addEffectPanel.starAddImg"] = {
		ignoreClickAudio = true,
		func = "onClickAttrAdd"
	},
	["main.surfacebtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSurface"
	},
	["main.taskBtn"] = {
		ignoreClickAudio = true,
		func = "onClickTask"
	},
	["main.teamBtn"] = {
		ignoreClickAudio = true,
		func = "onClickTeam"
	},
	["main.eggBtn"] = {
		ignoreClickAudio = true,
		func = "onClickEgg"
	},
	tipBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["main.btnNode.rightBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	},
	["main.btnNode.leftBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["main.rolePanel"] = {
		ignoreClickAudio = true,
		func = "onClickRolePanel"
	}
}
local kModelType = {
	kSurface = "Surface",
	kHero = "Hero"
}
local kModelBtnRes = {
	[kModelType.kSurface] = "common_btn_skin.png",
	[kModelType.kHero] = "wsj_yyyjs.png"
}
local KMapIds = {}

function ActivityCommonMainMediator:initialize()
	super.initialize(self)

	self._timer = {}
	self._richTextRemainTime = {}
end

function ActivityCommonMainMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityCommonMainMediator:stopTimer()
	for index, mapId in pairs(KMapIds) do
		if self._timer[mapId] then
			self._timer[mapId]:stop()

			self._timer[mapId] = nil
		end
	end

	if self._roleTimer then
		self._roleTimer:stop()

		self._roleTimer = nil
	end
end

function ActivityCommonMainMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._main = self:getView():getChildByName("main")
	self._imageBg = self._main:getChildByName("Imagebg")
	self._imageBgFront = self._main:getChildByName("Imagebg_1")
	self._titleImage = self._main:getChildByName("titleImage")

	self._titleImage:ignoreContentAdaptWithSize(true)

	self._surfaceBtn = self._main:getChildByName("surfacebtn")
	self._tipNode = self._main:getChildByName("tipNode")
	self._roleNode = self._main:getChildByName("roleNode")
	self._btnNode = self._main:getChildByName("btnNode")
	self._timeNode = self._main:getChildByName("timeNode")
	self._stagePanel = self._main:getChildByName("stagePanel")
	self._addEffectPanel = self._main:getChildByName("addEffectPanel")
	self._starAddImg = self._addEffectPanel:getChildByName("starAddImg")
	self._taskBtn = self._main:getChildByName("taskBtn")
	self._eggBtn = self._main:getChildByName("eggBtn")
	self._teamBtn = self._main:getChildByName("teamBtn")
	self._loginBtn = self._main:getChildByName("loginBtn")
	self._animNode = self._main:getChildByName("animNode")
	self._rightBtn = self._main:getChildByFullName("btnNode.rightBtn")
	self._leftBtn = self._main:getChildByFullName("btnNode.leftBtn")

	self._starAddImg:setVisible(false)

	if self._loginBtn then
		self._teamBtn:setVisible(false)
		self._loginBtn:setTouchEnabled(true)
		self._loginBtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickLogin()
			end
		end)
	end

	self._tipBtn = self:getView():getChildByName("tipBtn")
	self._infoPanel = self._main:getChildByName("infoPanel")

	if self._infoPanel then
		self._tipBtn:setVisible(false)
		self._infoPanel:setTouchEnabled(true)
		self._infoPanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
				self:onClickRule()
			end
		end)
	end

	self._voteBtn = self._main:getChildByName("voteBtn")

	if self._voteBtn then
		self._voteBtn:setTouchEnabled(true)
		self._voteBtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickVote()
			end
		end)
	end

	self._miniGameBtn = self._main:getChildByFullName("btn_minigame")

	if self._miniGameBtn then
		self._miniGameBtn:setTouchEnabled(true)
		self._miniGameBtn:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickMiniGame()
			end
		end)
	end

	local btnRoadWay = self:getView():getChildByFullName("main.btnRoadWay")

	if btnRoadWay then
		btnRoadWay:setVisible(false)
	end
end

function ActivityCommonMainMediator:setTimerString(timeStr, timeTip, key)
	if not self._richTextRemainTime["_stagePanel" .. key] then
		local remainLabel = self["_stagePanel" .. key]:getChildByName("remainTime")

		remainLabel:setString("")

		self._richTextRemainTime["_stagePanel" .. key] = ccui.RichText:createWithXML("", {})

		self._richTextRemainTime["_stagePanel" .. key]:setAnchorPoint(remainLabel:getAnchorPoint())
		self._richTextRemainTime["_stagePanel" .. key]:setPosition(cc.p(remainLabel:getPosition()))
		self._richTextRemainTime["_stagePanel" .. key]:addTo(remainLabel:getParent())
	end

	local txt = "<outline color='#2A1100' size = '2'><font face='asset/font/CustomFont_FZYH_R.TTF' size='20' color='#FFD200'>" .. timeStr .. "</font><font face='asset/font/CustomFont_FZYH_R.TTF' size='20' color='#FFFFFF'>" .. timeTip .. "</font></outline>"

	self._richTextRemainTime["_stagePanel" .. key]:setString(txt)
end

function ActivityCommonMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local title = Strings:get(self._activity:getTitle())
	local hideLine = false

	if self._activity:getTitlePath() then
		title = ""
		hideLine = true
	end

	local config = {
		style = 1,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		currencyInfo = self._activity:getResourcesBanner(),
		title = title,
		hideLine = hideLine
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivityCommonMainMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlock
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self:setupTopInfoWidget()
	self:mapButtonHandlersClick(kBtnHandlers)

	self._canChangeHero = true

	self:initData()
	self:initView()
	self:setStageView()
	self:showStoryReward(data.rewards)
end

function ActivityCommonMainMediator:showStoryReward(rewards)
	if not rewards then
		return
	end

	local delegate, outSelf = {}, self

	function delegate:willClose(popupMediator, data)
		return
	end

	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = rewards
	}, delegate))
end

function ActivityCommonMainMediator:resumeWithData()
	self:doReset()
end

function ActivityCommonMainMediator:initData()
	self._activityConfig = self._activity:getActivityConfig()
	self._blockActivity = {}
	self._blockActivityBaseData = {}
	KMapIds = self._activity:getBlockMapIds()

	for index, mapId in pairs(KMapIds) do
		self._blockActivity[mapId] = self._activity:getBlockMapActivity(mapId)
		self._blockActivityBaseData[mapId] = self._activity:getSubActivityBaseData(mapId)
	end

	self._taskActivities = self._activity:getTaskActivities()
	self._loginActivity = self._activity:getLoginActivities()
	self._jumpActivity = self._activity:getJumpActivity()
	self._roleIndex = 1
	self._roles = self._activity:getRoleParams()
end

function ActivityCommonMainMediator:initView()
	self:initInfo()
	self:initTimer()
	self:initRoleTimer()
	self:updateRolePanel()
	self:playBackgroundMusic()
	self:updateStage()
	self._rightBtn:setVisible(#self._roles > 1)
	self._leftBtn:setVisible(#self._roles > 1)
	self:initMiniGameButton()
end

function ActivityCommonMainMediator:initMiniGameButton()
	if self._activityConfig.MiniGameActivity then
		local config = self._activityConfig.MiniGameActivity

		if type(config) == "string" then
			if self._miniGameBtn then
				local redPoint = self._miniGameBtn:getChildByName("redPoint")
				local miniGameActivity = self._activitySystem:getActivityById(self._activityConfig.MiniGameActivity)

				redPoint:setVisible(miniGameActivity:hasRedPoint())
				self._miniGameBtn:getChildByName("Text_45"):setString(Strings:get(miniGameActivity:getTitle()))
			end
		elseif type(config) == "table" then
			if self._miniGameBtn then
				self._miniGameBtn:setVisible(false)
			end

			if not self._miniGameBtnList then
				self._miniGameBtnList = {}

				for i, v in pairs(config) do
					local button = ccui.Button:create(v.Icon, v.Icon, "", 1)

					button:addTo(self._main, 10):posite(70, 455 - (i - 1) * 80)

					local miniGameActivity = self._activitySystem:getActivityById(v.Activity)
					local nameText = ccui.Text:create(Strings:get(miniGameActivity:getTitle()), CUSTOM_TTF_FONT_1, 24)

					nameText:setAnchorPoint(cc.p(0.5, 0.5))
					nameText:addTo(button):posite(50, 26)
					nameText:getVirtualRenderer():setHorizontalAlignment(2)
					nameText:setTextVerticalAlignment(2)
					nameText:setTextAreaSize(cc.size(100, 35))

					local virtualRenderer = nameText:getVirtualRenderer()

					virtualRenderer:setOverflow(cc.LabelOverflow.NONE)
					virtualRenderer:setOverflow(cc.LabelOverflow.SHRINK)
					button:setTouchEnabled(true)
					button:addTouchEventListener(function(sender, eventType)
						if eventType == ccui.TouchEventType.ended then
							self:onClickMiniGame(v.url)
						end
					end)

					local redPointImg = RedPoint:createDefaultNode()

					redPointImg:setScale(0.8)

					local redPoint = RedPoint:new(redPointImg, button, function()
						return miniGameActivity:hasRedPoint()
					end)

					redPoint:offset(-5, 0)

					button.config = v
					self._miniGameBtnList[#self._miniGameBtnList + 1] = button

					AdjustUtils.adjustLayoutByType(button, AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Top)
				end
			end
		end
	end
end

function ActivityCommonMainMediator:playBackgroundMusic()
	local bgm = self._activity:getBgm()

	AudioEngine:getInstance():playBackgroundMusic(bgm)
end

function ActivityCommonMainMediator:initInfo()
	self._imageBg:loadTexture(self._activity:getBgPath())

	if self._imageBgFront and self._activity:getFrontBgPath() ~= "" then
		self._imageBgFront:loadTexture(self._activity:getFrontBgPath())
	end

	if self._activity:getTitlePath() then
		self._titleImage:setVisible(true)
		self._titleImage:loadTexture(self._activity:getTitlePath(), 1)
	end

	local tipStr = self._activityConfig.SubActivityEndTip

	self._endTip = {}

	for index, mapId in pairs(KMapIds) do
		local redPoint = self._stagePanel:getChildByName("redPoint")

		redPoint:setVisible(self._blockActivity[mapId] and self._blockActivity[mapId]:hasRedPoint())
	end

	local itemNode = self._addEffectPanel:getChildByName("itemNode")

	itemNode:removeAllChildren()

	local heroNode = self._addEffectPanel:getChildByName("heroNode")

	heroNode:removeAllChildren()

	local rewards = self._blockActivityBaseData[KMapIds[1]].ActivityConfig.ShowReward

	rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewards, "Content")

	if rewards then
		local length = math.ceil(#rewards / 4)

		for i = 1, length do
			for jj = 1, 4 do
				local index = 4 * (i - 1) + jj
				local reward = rewards[index]

				if reward then
					local icon = IconFactory:createRewardIcon(reward, {
						showAmount = false,
						isWidget = true,
						notShowQulity = false
					})

					icon:addTo(itemNode):setScale(0.5)
					IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
						needDelay = true
					})

					local x = 60 * (jj - 1) + 15
					local y = -30 * (i - 1)

					icon:setPosition(cc.p(x, y))
				end
			end
		end
	end

	local bonusHero = self._blockActivityBaseData[KMapIds[1]].ActivityConfig.BonusHero

	if bonusHero then
		local length = #bonusHero

		for i = 1, length do
			local id = bonusHero[i]
			local icon = IconFactory:createHeroIconForReward({
				star = 0,
				id = id
			})

			icon:addTo(heroNode):setScale(0.5)

			local x = (i - 1) * 62

			icon:setPositionX(x)

			local image = ccui.ImageView:create("jjc_bg_ts_new.png", 1)

			image:addTo(icon):posite(92, 20):setScale(1.2)
		end
	end

	local redPoint = self._eggBtn:getChildByName("redPoint")

	redPoint:setVisible(self._jumpActivity and self._jumpActivity:hasRedPoint())

	local image = self._eggBtn:getChildByName("image")

	image:ignoreContentAdaptWithSize(true)

	local text = self._eggBtn:getChildByName("text")

	if self._activityConfig.ButtonIcon then
		image:loadTexture(self._activityConfig.ButtonIcon .. ".png", 1)
	end

	if self._activityConfig.ButtonText then
		text:setString(Strings:get(self._activityConfig.ButtonText))
	end

	local redPoint = self._teamBtn:getChildByName("redPoint")

	redPoint:setVisible(false)

	self._endTip.taskEndTip = Strings:get(tipStr, {
		activityId = Strings:get("ActivityBlock_UI_10")
	})

	local redPoint = self._taskBtn:getChildByName("redPoint")
	local hasRed = false

	if self._taskActivities then
		for i = 1, #self._taskActivities do
			if self._taskActivities[i]:hasRedPoint() then
				hasRed = true

				break
			end
		end
	end

	redPoint:setVisible(hasRed)

	if self._loginBtn then
		local redPoint = self._loginBtn:getChildByName("redPoint")

		redPoint:setVisible(self._loginActivity and self._loginActivity:hasRedPoint())
	end

	local ui = self._activity:getUI()

	if ui == ActivityType_UI.KActivityDeepSea and getCurrentLanguage() ~= GameLanguageType.CN then
		local title = self._stagePanel:getChildByName("title_shenhai")

		if title then
			title:setString(Strings:get("ActivityBlock_DeepSea_Map_Name_1_1"))
		end

		local titles = {
			"title",
			"title_0",
			"title_1"
		}

		for i, v in ipairs(titles) do
			local title = self._stagePanel:getChildByName(v)

			if title then
				title:setString("")
			end
		end
	end

	if ui == ActivityType_UI.KActivityAnimal and getCurrentLanguage() ~= GameLanguageType.CN then
		local titles = {
			"title",
			"title_0",
			"title_1"
		}

		for i, v in ipairs(titles) do
			local title = self._stagePanel:getChildByName(v)

			if title then
				title:setString("")
			end
		end

		local title = self._stagePanel:getChildByName("title_0")

		if title then
			title:setAnchorPoint(0.5, 0.5)
			title:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
			title:setString(Strings:get("ActivityBlock_Animal_Map_Name_1_1"))
			title:setPositionX(200)
		end
	end

	if ui == ActivityType_UI.KActivitySamurai then
		local titles = {
			"title",
			"title_0"
		}

		for i, v in ipairs(titles) do
			local title = self._stagePanel:getChildByName(v)

			if title then
				title:setString("")
			end
		end

		local title = self._stagePanel:getChildByName("title")

		if title then
			title:setAnchorPoint(0.5, 0.5)
			title:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
			title:setString(Strings:get("ActivityBlock_Samurai_Map_Name_1_1"))
			title:setPositionX(200)
		end
	end

	if self._voteBtn then
		self._voteBtn:setVisible(self._activity:isVote())
	end
end

local MAPOPENSTATUS = {
	KNoOpenNotAllPass = 2,
	KNoOpenTime = 1,
	KGoing = 3,
	KEnd = 4
}

function ActivityCommonMainMediator:getStatus(mapId)
	local isOpen = self._activity:subActivityIsOpen(mapId)

	if not isOpen then
		return {
			status = MAPOPENSTATUS.KNoOpenTime,
			times = self._activity:getSubActivityOpenTimes(self._blockActivityBaseData[mapId]).startTime
		}
	end

	local act = self._blockActivity[mapId]
	local config = act:getActivityConfig()

	if config.PreMapId then
		local pass = self._blockActivity[config.PreMapId]:isAllPointPass()

		if not pass then
			return {
				status = MAPOPENSTATUS.KNoOpenNotAllPass
			}
		end
	end

	local isOver = self._activity:subActivityIsOver(mapId)

	if isOver then
		return {
			status = MAPOPENSTATUS.KEnd
		}
	end

	return {
		status = MAPOPENSTATUS.KGoing,
		times = act:getEndTime() / 1000
	}
end

function ActivityCommonMainMediator:initTimer()
	local text = self._timeNode:getChildByName("time")

	text:setString(self._activity:getTimeStr1())

	for index, mapId in pairs(KMapIds) do
		if self._blockActivity[mapId] then
			local remoteTimestamp = self._activitySystem:getCurrentTime()
			local endTime = self._blockActivity[mapId]:getEndTime() / 1000

			if remoteTimestamp < endTime then
				if self._timer[mapId] then
					return
				end

				local function checkTimeFunc()
					if DisposableObject:isDisposed(self) then
						return
					end

					remoteTimestamp = self._activitySystem:getCurrentTime()

					local remainTime = endTime - remoteTimestamp

					if remainTime <= 0 then
						self._timer[mapId]:stop()

						self._timer[mapId] = nil

						self:setTimerString("", Strings:get("ActivityBlock_UI_8"), "")

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

					if timeTab.day > 0 then
						str = timeTab.day .. Strings:get("TimeUtil_Day")
					elseif timeTab.hour > 0 then
						str = timeTab.hour .. Strings:get("TimeUtil_Hour")
					else
						timeTab.min = math.max(1, timeTab.min)
						str = timeTab.min .. Strings:get("TimeUtil_Min")
					end

					self:setTimerString(str, Strings:get("ActivityBlock_UI_24", {
						time = ""
					}), "")
				end

				self._timer[mapId] = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

				checkTimeFunc()
			else
				self:setTimerString("", Strings:get("ActivityBlock_UI_8"), "")
			end
		else
			local status = self:getStatus(mapId)

			if status == MAPOPENSTATUS.KEnd then
				self:setTimerString("", Strings:get("ActivityBlock_UI_8"), "")
			else
				self:setTimerString("", "", "")
			end
		end
	end
end

function ActivityCommonMainMediator:initRoleTimer()
	if self._roleTimer then
		self._roleTimer:stop()
	end

	local function checkTimeFunc()
		self._roleIndex = self._roleIndex + 1

		if self._roleIndex > #self._roles then
			self._roleIndex = 1
		end

		self:updateRolePanel()
	end

	self._roleTimer = LuaScheduler:getInstance():schedule(checkTimeFunc, 5, false)
end

function ActivityCommonMainMediator:updateRolePanel()
	local type_ = self._roles[self._roleIndex].type
	local model = self._roles[self._roleIndex].model

	self._roleUrl = self._roles[self._roleIndex].url

	local desc = Strings:get(self._roles[self._roleIndex].desc)

	self._tipNode:getChildByName("text"):setString(desc)

	local showTip = true

	if self._roleUrl then
		local showSurface = self._roleUrl ~= ""

		if type_ == kModelType.kSurface then
			local surfaces = self._surfaceSystem:getSurfaceById(model)

			if surfaces:getUnlock() then
				showTip = false
			end

			model = ConfigReader:getDataByNameIdAndKey("Surface", model, "Model")
		elseif type_ == kModelType.kHero then
			local hero = self._heroSystem:getHeroById(model)

			if hero then
				showTip = false
			end

			model = IconFactory:getRoleModelByKey("HeroBase", model)
		end

		self._roleNode:removeAllChildren()

		local img, jsonPath = IconFactory:createRoleIconSpriteNew({
			useAnim = true,
			frameId = "bustframe9",
			id = model
		})

		img:addTo(self._roleNode):posite(20, -80)
		img:setScale(0.9)
		self._surfaceBtn:setVisible(showTip and showSurface)
		self._tipNode:setVisible(showTip)
		self._surfaceBtn:getChildByName("Image_71"):loadTexture(kModelBtnRes[type_], ccui.TextureResType.plistType)
	end
end

function ActivityCommonMainMediator:doReset()
	self:stopTimer()

	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivityCommonMainMediator:refreshView()
	self:doReset()
end

function ActivityCommonMainMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivityCommonMainMediator:onClickStage(sender)
	local tag = sender:getTag()
	local mapId = KMapIds[1]

	if tag > 20 then
		mapId = KMapIds[2]
	end

	dump(KMapIds, "KMapIds")
	dump(mapId, "mapId-___")

	local title = Strings:get(self._blockActivityBaseData[mapId].Title)
	local st = self:getStatus(mapId)

	if st.status == MAPOPENSTATUS.KNoOpenTime then
		local tips = self._activityConfig.SubActivityStartTip
		local times = TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", st.times)

		self:dispatch(ShowTipEvent({
			tip = Strings:get(tips, {
				title = title,
				time = times
			})
		}))

		return
	end

	if st.status == MAPOPENSTATUS.KNoOpenNotAllPass then
		self:dispatch(ShowTipEvent({
			tip = Strings:get(self._activityConfig.SubActivityPassPointTip, {
				title = title
			})
		}))

		return
	end

	if st.status == MAPOPENSTATUS.KEnd then
		self:dispatch(ShowTipEvent({
			tip = Strings:get(self._activityConfig.SubActivityEndTip, {
				activityId = title
			})
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Story_Dream", false)
	self._activitySystem:enterBlockMap(self._activityId, mapId)
end

function ActivityCommonMainMediator:onClickAttrAdd()
	if not self._blockActivityBaseData[KMapIds[1]] then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._blockActivityBaseData[KMapIds[1]].ActivityConfig.BonusHeroDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityCommonMainMediator:onClickRule()
	local rules = self._activityConfig.RuleDesc
	local start = self._blockActivityBaseData[KMapIds[1]].TimeFactor.start[1]
	local startTime = TimeUtil:formatStrToRemoteTImestamp(start)
	local date = TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", startTime)

	self._activitySystem:showActivityRules(rules, nil, {
		time = date
	})
end

function ActivityCommonMainMediator:onClickTask()
	if #self._taskActivities == 0 then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.taskEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSupportTaskView(self._activityId)
end

function ActivityCommonMainMediator:onClickTeam()
	local start = false
	local over = true

	for index, mapId in pairs(KMapIds) do
		local st = self:getStatus(mapId)

		if st.status ~= MAPOPENSTATUS.KNoOpenTime then
			start = true
		end

		if st.status ~= MAPOPENSTATUS.KEnd then
			over = false
		end
	end

	if not start then
		self:dispatch(ShowTipEvent({
			tip = Strings:get(self._activityConfig.SubActivityTip1)
		}))

		return
	end

	if over then
		self:dispatch(ShowTipEvent({
			tip = Strings:get(self._activityConfig.SubActivityTip)
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterTeam(self._activityId, self._blockActivity[KMapIds[1]])
end

function ActivityCommonMainMediator:onClickLogin()
	local url = self._activityConfig.EightDaysUrl

	if url then
		local context = self:getInjector():instantiate(URLContext)
		local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

		if not entry then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Function_Not_Open")
			}))
		else
			entry:response(context, params)
		end

		return
	end
end

function ActivityCommonMainMediator:onClickEgg()
	local url = self._activityConfig.ExchangeUrl

	if url then
		local context = self:getInjector():instantiate(URLContext)
		local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

		if not entry then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Function_Not_Open")
			}))
		else
			entry:response(context, params)
		end

		return
	end

	if not self._jumpActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.eggEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterEasterEgg({
		activityId = self._activityId
	})
end

function ActivityCommonMainMediator:onClickSurface()
	if not self._roleUrl or self._roleUrl == "" then
		return
	end

	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(self._roleUrl)

	if not entry then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Function_Not_Open")
		}))
	else
		entry:response(context, params)
	end
end

function ActivityCommonMainMediator:onClickLeft()
	if not self._canChangeHero then
		return
	end

	self:initRoleTimer()

	self._canChangeHero = false

	performWithDelay(self:getView(), function()
		self._canChangeHero = true
	end, 0.3)

	self._roleIndex = self._roleIndex - 1

	if self._roleIndex < 1 then
		self._roleIndex = #self._roles
	end

	self:updateRolePanel()
end

function ActivityCommonMainMediator:onClickRight()
	if not self._canChangeHero then
		return
	end

	self:initRoleTimer()

	self._canChangeHero = false

	performWithDelay(self:getView(), function()
		self._canChangeHero = true
	end, 0.3)

	self._roleIndex = self._roleIndex + 1

	if self._roleIndex > #self._roles then
		self._roleIndex = 1
	end

	self:updateRolePanel()
end

function ActivityCommonMainMediator:updateStage()
	if not KMapIds[2] then
		return
	end

	local status = self:getStatus(KMapIds[2])

	if status.status == MAPOPENSTATUS.KNoOpenTime or status.status == MAPOPENSTATUS.KNoOpenNotAllPass then
		self._stagePanel11:setVisible(true)
		self._stagePanel21:setVisible(true)
		self._stagePanel12:setVisible(false)
		self._stagePanel22:setVisible(false)
		self._richTextRemainTime._stagePanel21:setVisible(false)
	else
		self._stagePanel11:setVisible(false)
		self._stagePanel21:setVisible(false)
		self._stagePanel12:setVisible(true)
		self._stagePanel22:setVisible(true)
		self._imageBg:loadTexture(self._activity:getChangeBgPath())

		if self._imageBgFront and self._activity:getFrontBgPath() ~= "" then
			self._imageBgFront:loadTexture(self._activity:getFrontBgPath())
		end
	end

	self:playStageAnim()
	self._starAddImg:setVisible(false)
end

function ActivityCommonMainMediator:playStageAnim()
	self._animNode:removeAllChildren()
	self._stagePanel11:getChildByName("image"):setVisible(false)
	self._stagePanel12:getChildByName("image"):setVisible(false)
	self._stagePanel21:getChildByName("image"):setVisible(false)
	self._stagePanel22:getChildByName("image"):setVisible(false)

	local button11 = self._stagePanel11:getChildByName("button")
	local button12 = self._stagePanel12:getChildByName("button")
	local button21 = self._stagePanel21:getChildByName("button")
	local button22 = self._stagePanel22:getChildByName("button")

	local function play1()
		button11:removeAllChildren()

		local anim = cc.MovieClip:create("shimeng_xigejiemian")

		anim:setPosition(cc.p(139, 114))
		anim:addTo(button11)
		self._stagePanel21:getChildByName("image"):setVisible(true)
	end

	local function play2()
		button22:removeAllChildren()

		local anim = cc.MovieClip:create("zhou_xigejiemian")

		anim:setPosition(cc.p(110, 25))
		anim:addTo(button22)
		self._stagePanel12:getChildByName("image"):setVisible(true)
		self._richTextRemainTime._stagePanel12:setScale(0.8)
	end

	local function play3()
		local title = self._stagePanel12:getChildByName("title")
		local title_0 = self._stagePanel12:getChildByName("title_0")
		local remainTime = self._richTextRemainTime._stagePanel12

		title:setScale(2)
		title_0:setScale(2)
		remainTime:setScale(2)
		title:runAction(cc.ScaleTo:create(0.1, 1))
		title_0:runAction(cc.ScaleTo:create(0.1, 1))
		remainTime:runAction(cc.ScaleTo:create(0.1, 0.8))

		local title = self._stagePanel22:getChildByName("title")
		local title_0 = self._stagePanel22:getChildByName("title_0")
		local remainTime = self._richTextRemainTime._stagePanel22

		title:setScale(0)
		title_0:setScale(0)
		remainTime:setScale(0)

		local sequence = cc.Sequence:create(cc.DelayTime:create(0.1), cc.ScaleTo:create(0.2, 1))

		title:runAction(sequence)

		local sequence = cc.Sequence:create(cc.DelayTime:create(0.1), cc.ScaleTo:create(0.2, 1))

		title_0:runAction(sequence)

		local sequence = cc.Sequence:create(cc.DelayTime:create(0.1), cc.ScaleTo:create(0.2, 1))

		remainTime:runAction(sequence)

		local anim = cc.MovieClip:create("jiemian_xigejiemian")

		anim:setPosition(cc.p(-360, -90))
		anim:addTo(self._animNode)
		anim:addCallbackAtFrame(10, function()
			anim:stop()
			play2()
			self._animNode:removeAllChildren()
		end)
	end

	local st2 = self:getStatus(KMapIds[2])

	if st2.status ~= MAPOPENSTATUS.KNoOpenTime and st2.status ~= MAPOPENSTATUS.KNoOpenNotAllPass then
		local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
		local gameServerAgent = DmGame:getInstance()._injector:getInstance(GameServerAgent)
		local idStr = string.split(developSystem:getPlayer():getRid(), "_")
		local userStr = "PlayChangeMapAnim" .. KMapIds[2] .. idStr[1]
		local stamp = cc.UserDefault:getInstance():getIntegerForKey(userStr, 0)

		if stamp > 0 then
			play2()

			return
		end

		play3()
		cc.UserDefault:getInstance():setIntegerForKey(userStr, gameServerAgent:remoteTimestamp())
	else
		play1()
	end
end

function ActivityCommonMainMediator:onClickRolePanel()
	local model = self._roles[self._roleIndex].model
	local type_ = self._roles[self._roleIndex].type
	local modelId, heroId

	if type_ == kModelType.kSurface then
		modelId = ConfigReader:getDataByNameIdAndKey("Surface", model, "Model")
		heroId = ConfigReader:getDataByNameIdAndKey("Surface", model, "Hero")
	elseif type_ == kModelType.kHero then
		modelId = IconFactory:getRoleModelByKey("HeroBase", model)
		heroId = model
	end

	local view = self:getInjector():getInstance("HeroInfoView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		heroId = heroId
	}))
end

function ActivityCommonMainMediator:setStageView()
	local ui = self._activity:getUI()
	local title = ActivityMainMapTitleConfig.title[ui]

	if title then
		for key, lineGradiantVec2 in pairs(title) do
			local title = self._stagePanel:getChildByName(key)

			title:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
				x = 0,
				y = -1
			}))
		end
	end

	local anim = ActivityMainMapTitleConfig.anim[ui]

	if not self._stageAnim and anim then
		self._stageAnim = cc.MovieClip:create(anim.name)

		self._stageAnim:setPosition(anim.position)
		self._stageAnim:addTo(self._stagePanel:getChildByName("button"))

		if self._stagePanel:getChildByName("image") and not anim.showDiImg then
			self._stagePanel:getChildByName("image"):setVisible(false)
		end

		if ui == ActivityType_UI.KActivitySummerRe and self._stageAnim then
			local zidi = self._stageAnim:getChildByName("zidi")
			local zi = self._stageAnim:getChildByName("zi")

			if getCurrentLanguage() ~= GameLanguageType.CN then
				zidi:setRotation(-90)
				zi:setRotation(-90)
			end
		end

		if anim.runAction then
			anim.runAction(self._stageAnim)
		end

		if anim.bgAnim then
			local bgAnim = cc.MovieClip:create(anim.bgAnim)

			bgAnim:addTo(self._imageBg):setPosition(anim.bgAnimPos)
		end
	end
end

function ActivityCommonMainMediator:onClickVote()
	self._activity:checkVote()
end

function ActivityCommonMainMediator:onClickMiniGame(url)
	local url = url or self._activityConfig.MiniGameUrl
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end
