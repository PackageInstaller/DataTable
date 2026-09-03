-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityCollapsedMainMediator.lua

ActivityCollapsedMainMediator = class("ActivityCollapsedMainMediator", DmAreaViewMediator, _M)

ActivityCollapsedMainMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityCollapsedMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityCollapsedMainMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kBtnHandlers = {
	["main.stagePanel11.button"] = {
		ignoreClickAudio = true,
		func = "onClickStage"
	},
	["main.stagePanel12.button"] = {
		ignoreClickAudio = true,
		func = "onClickStage"
	},
	["main.stagePanel21.button"] = {
		ignoreClickAudio = true,
		func = "onClickStage"
	},
	["main.stagePanel22.button"] = {
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
local KMapIds = {
	"ActivityBlock_Collapsed_Map_1",
	"ActivityBlock_Collapsed_Map_2"
}

function ActivityCollapsedMainMediator:initialize()
	super.initialize(self)

	self._timer = {}
	self._richTextRemainTime = {}
end

function ActivityCollapsedMainMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityCollapsedMainMediator:stopTimer()
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

function ActivityCollapsedMainMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:setupTopInfoWidget()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._main = self:getView():getChildByName("main")
	self._imageBg = self._main:getChildByName("Imagebg")
	self._titleImage = self._main:getChildByName("titleImage")

	self._titleImage:ignoreContentAdaptWithSize(true)

	self._surfaceBtn = self._main:getChildByName("surfacebtn")
	self._tipNode = self._main:getChildByName("tipNode")
	self._roleNode = self._main:getChildByName("roleNode")
	self._btnNode = self._main:getChildByName("btnNode")
	self._timeNode = self._main:getChildByName("timeNode")
	self._stagePanel11 = self._main:getChildByName("stagePanel11")
	self._stagePanel12 = self._main:getChildByName("stagePanel12")
	self._stagePanel21 = self._main:getChildByName("stagePanel21")
	self._stagePanel22 = self._main:getChildByName("stagePanel22")
	self._addEffectPanel = self._main:getChildByName("addEffectPanel")
	self._starAddImg = self._addEffectPanel:getChildByName("starAddImg")
	self._taskBtn = self._main:getChildByName("taskBtn")
	self._eggBtn = self._main:getChildByName("eggBtn")
	self._teamBtn = self._main:getChildByName("teamBtn")
	self._animNode = self._main:getChildByName("animNode")

	local title11 = self._stagePanel11:getChildByName("title")
	local title12 = self._stagePanel12:getChildByName("title")
	local title21 = self._stagePanel21:getChildByName("title")
	local title22 = self._stagePanel22:getChildByName("title")
	local title11_0 = self._stagePanel11:getChildByName("title_0")
	local title12_0 = self._stagePanel12:getChildByName("title_0")
	local title21_0 = self._stagePanel21:getChildByName("title_0")
	local title22_0 = self._stagePanel22:getChildByName("title_0")
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(154, 164, 243, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 255, 255, 255)
		}
	}

	title11:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	title12:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	title21:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	title22:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	title11_0:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	title12_0:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	title21_0:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	title22_0:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function ActivityCollapsedMainMediator:setTimerString(timeStr, timeTip, key)
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

function ActivityCollapsedMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivityCollapsedMainMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		hideLine = true,
		style = 1,
		currencyInfo = self._activity:getResourcesBanner()
	}

	self._topInfoWidget:updateView(config)
end

function ActivityCollapsedMainMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlock
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self:mapButtonHandlersClick(kBtnHandlers)
	self:updateInfoWidget()

	self._canChangeHero = true

	self:initData()
	self:initView()
end

function ActivityCollapsedMainMediator:resumeWithData()
	self:doReset()
end

function ActivityCollapsedMainMediator:initData()
	self._activityConfig = self._activity:getActivityConfig()
	self._blockActivity = {}
	self._blockActivityBaseData = {}

	for index, mapId in pairs(KMapIds) do
		self._blockActivity[mapId] = self._activity:getBlockMapActivity(mapId)
		self._blockActivityBaseData[mapId] = self._activity:getSubActivityBaseData(mapId)
	end

	self._taskActivities = self._activity:getTaskActivities()
	self._jumpActivity = self._activity:getJumpActivity()
	self._roleIndex = 1
	self._roles = self._activity:getRoleParams()
end

function ActivityCollapsedMainMediator:initView()
	self:initInfo()
	self:initTimer()
	self:initRoleTimer()
	self:updateRolePanel()
	self:playBackgroundMusic()
	self:updateStage()
end

function ActivityCollapsedMainMediator:playBackgroundMusic()
	local bgm = self._activity:getBgm()

	AudioEngine:getInstance():playBackgroundMusic(bgm)
end

function ActivityCollapsedMainMediator:initInfo()
	self._imageBg:loadTexture(self._activity:getBgPath())
	self._titleImage:loadTexture(self._activity:getTitlePath(), 1)

	local tipStr = self._activityConfig.SubActivityEndTip

	self._endTip = {}

	for index, mapId in pairs(KMapIds) do
		for i = 1, 2 do
			local redPoint = self["_stagePanel" .. index .. i]:getChildByName("redPoint")

			redPoint:setVisible(self._blockActivity[mapId] and self._blockActivity[mapId]:hasRedPoint())
		end
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
						notShowQulity = true
					})

					icon:addTo(itemNode):setScale(0.6)
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
end

local MAPOPENSTATUS = {
	KNoOpenNotAllPass = 2,
	KNoOpenTime = 1,
	KGoing = 3,
	KEnd = 4
}

function ActivityCollapsedMainMediator:getStatus(mapId)
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

function ActivityCollapsedMainMediator:initTimer()
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
					remoteTimestamp = self._activitySystem:getCurrentTime()

					local remainTime = endTime - remoteTimestamp

					if remainTime <= 0 then
						self._timer[mapId]:stop()

						self._timer[mapId] = nil

						self:setTimerString("", Strings:get("ActivityBlock_UI_8"), index .. "1")
						self:setTimerString("", Strings:get("ActivityBlock_UI_8"), index .. "2")

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
					}), index .. "1")
					self:setTimerString(str, Strings:get("ActivityBlock_UI_24", {
						time = ""
					}), index .. "2")
				end

				self._timer[mapId] = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

				checkTimeFunc()
			else
				self:setTimerString("", Strings:get("ActivityBlock_UI_8"), index .. "1")
				self:setTimerString("", Strings:get("ActivityBlock_UI_8"), index .. "2")
			end
		else
			local status = self:getStatus(mapId)

			if status == MAPOPENSTATUS.KEnd then
				self:setTimerString("", Strings:get("ActivityBlock_UI_8"), index .. "1")
				self:setTimerString("", Strings:get("ActivityBlock_UI_8"), index .. "2")
			else
				self:setTimerString("", "", index .. "1")
				self:setTimerString("", "", index .. "2")
			end
		end
	end
end

function ActivityCollapsedMainMediator:initRoleTimer()
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

function ActivityCollapsedMainMediator:updateRolePanel()
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

		img:addTo(self._roleNode):posite(20, -70)
		img:setScale(0.9)
		self._surfaceBtn:setVisible(showTip and showSurface)
		self._tipNode:setVisible(showTip)
		self._surfaceBtn:getChildByName("Image_71"):loadTexture(kModelBtnRes[type_], ccui.TextureResType.plistType)
	end
end

function ActivityCollapsedMainMediator:doReset()
	self:stopTimer()

	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivityCollapsedMainMediator:refreshView()
	self:doReset()
end

function ActivityCollapsedMainMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivityCollapsedMainMediator:onClickStage(sender)
	local tag = sender:getTag()
	local mapId = KMapIds[1]

	if tag > 20 then
		mapId = KMapIds[2]
	end

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

function ActivityCollapsedMainMediator:onClickAttrAdd()
	if not self._blockActivityBaseData[KMapIds[1]] then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._blockActivityBaseData[KMapIds[1]].ActivityConfig.BonusHeroDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityCollapsedMainMediator:onClickRule()
	local rules = self._activityConfig.RuleDesc
	local start = self._blockActivityBaseData[KMapIds[2]].TimeFactor.start[1]
	local startTime = TimeUtil:formatStrToRemoteTImestamp(start)
	local date = TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", startTime)

	self._activitySystem:showActivityRules(rules, nil, {
		time = date
	})
end

function ActivityCollapsedMainMediator:onClickTask()
	if #self._taskActivities == 0 then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.taskEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSupportTaskView(self._activityId)
end

function ActivityCollapsedMainMediator:onClickTeam()
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

function ActivityCollapsedMainMediator:onClickEgg()
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

function ActivityCollapsedMainMediator:onClickSurface()
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

function ActivityCollapsedMainMediator:onClickLeft()
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

function ActivityCollapsedMainMediator:onClickRight()
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

function ActivityCollapsedMainMediator:updateStage()
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
	end

	self:playStageAnim()
	self._starAddImg:setVisible(false)
end

function ActivityCollapsedMainMediator:playStageAnim()
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
