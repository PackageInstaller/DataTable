-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityOrientMainMediator.lua

ActivityOrientMainMediator = class("ActivityOrientMainMediator", DmAreaViewMediator, _M)

ActivityOrientMainMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityOrientMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityOrientMainMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kBtnHandlers = {
	["main.stagePanel.button"] = {
		ignoreClickAudio = true,
		func = "onClickStage"
	},
	["main.surfacebtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSurface"
	},
	["main.taskBtn"] = {
		ignoreClickAudio = true,
		func = "onClickTask"
	},
	["main.eggBtn"] = {
		ignoreClickAudio = true,
		func = "onClickEgg"
	},
	["main.tipBtn"] = {
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

function ActivityOrientMainMediator:initialize()
	super.initialize(self)

	self._timer = {}
	self._richTextRemainTime = {}
end

function ActivityOrientMainMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityOrientMainMediator:stopTimer()
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

function ActivityOrientMainMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._main = self:getView():getChildByName("main")
	self._imageBg = self._main:getChildByName("Imagebg")
	self._surfaceBtn = self._main:getChildByName("surfacebtn")
	self._tipNode = self._main:getChildByName("tipNode")
	self._roleNode = self._main:getChildByName("roleNode")
	self._btnNode = self._main:getChildByName("btnNode")
	self._timeNode = self._main:getChildByName("timeNode")
	self._stagePanel = self._main:getChildByName("stagePanel")
	self._taskBtn = self._main:getChildByName("taskBtn")
	self._eggBtn = self._main:getChildByName("eggBtn")
	self._loginBtn = self._main:getChildByName("loginBtn")
	self._animNode = self._main:getChildByName("animNode")
	self._rightBtn = self._main:getChildByFullName("btnNode.rightBtn")
	self._leftBtn = self._main:getChildByFullName("btnNode.leftBtn")

	if self._loginBtn then
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
end

function ActivityOrientMainMediator:setTimerString(timeStr, timeTip, key)
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

function ActivityOrientMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = self._activity:getResourcesBanner(),
		title = Strings:get(self._activity:getTitle()),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local yunImg = self._activity:getActivityConfig().DingTong

	if yunImg then
		local img = ccui.ImageView:create(yunImg .. ".png", 1)

		img:addTo(self._topInfoWidget:getView()):center(self._topInfoWidget:getView():getContentSize()):offset(0, 10)
	end
end

function ActivityOrientMainMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlock
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self._canChangeHero = true

	self:initData()
	self:setupTopInfoWidget()
	self:mapButtonHandlersClick(kBtnHandlers)
	self:initView()
	self:setStageView()
	self:showStoryReward(data.rewards)
	self:playBackgroundMusic()
end

function ActivityOrientMainMediator:showStoryReward(rewards)
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

function ActivityOrientMainMediator:resumeWithData()
	self._animPlay = false

	self:doReset()
	self:playBackgroundMusic()
end

function ActivityOrientMainMediator:initData()
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

function ActivityOrientMainMediator:initView()
	self:initInfo()
	self:initTimer()
	self:initRoleTimer()
	self:updateRolePanel()
	self._rightBtn:setVisible(#self._roles > 1)
	self._leftBtn:setVisible(#self._roles > 1)
end

function ActivityOrientMainMediator:playBackgroundMusic()
	local bgm = self._activity:getBgm()

	AudioEngine:getInstance():playBackgroundMusic(bgm)
end

function ActivityOrientMainMediator:initInfo()
	self._imageBg:loadTexture(self._activity:getBgPath())

	local tipStr = self._activityConfig.SubActivityEndTip

	self._endTip = {}

	for index, mapId in pairs(KMapIds) do
		local redPoint = self._stagePanel:getChildByName("redPoint")

		redPoint:setVisible(self._blockActivity[mapId] and self._blockActivity[mapId]:hasRedPoint())
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

function ActivityOrientMainMediator:getStatus(mapId)
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

function ActivityOrientMainMediator:initTimer()
	local text = self._timeNode:getChildByName("time")

	text:setString(self._activity:getTimeStr2())

	do return end

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

function ActivityOrientMainMediator:initRoleTimer()
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

function ActivityOrientMainMediator:updateRolePanel()
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

		img:addTo(self._roleNode):posite(20, 0)
		img:setScale(0.65)
		self._surfaceBtn:setVisible(showTip and showSurface)
		self._tipNode:setVisible(showTip)
		self._surfaceBtn:getChildByName("Image_71"):loadTexture(kModelBtnRes[type_], ccui.TextureResType.plistType)
	end
end

function ActivityOrientMainMediator:doReset()
	self:stopTimer()

	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivityOrientMainMediator:refreshView()
	self:doReset()
end

function ActivityOrientMainMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivityOrientMainMediator:onClickStage(sender)
	if self._animPlay then
		return
	end

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

	if not self._transitionAnim then
		self._transitionAnim = cc.MovieClip:create("zhuanc_huijiadeluzhuyefuben")

		self._transitionAnim:addTo(self:getView()):center(self:getView():getContentSize())
	end

	self._animPlay = true

	self._transitionAnim:gotoAndPlay(1)

	local node = self._transitionAnim:getChildByName("node")
	local initX, initY = self._main:getPosition()
	local initX2, initY2 = self._topInfoWidget:getView():getPosition()

	self._main:changeParent(node):center(node:getContentSize())

	local pos = self:getView():convertToWorldSpace(cc.p(initX2, initY2))
	local pos2 = node:convertToNodeSpace(pos)

	self._topInfoWidget:getView():changeParent(node):setPosition(pos2)
	self._transitionAnim:addCallbackAtFrame(34, function()
		self._transitionAnim:stop()
		self._main:changeParent(self:getView()):posite(initX, initY)
		self._topInfoWidget:getView():changeParent(self:getView()):posite(initX2, initY2)
		self._activitySystem:enterBlockMap(self._activityId, mapId)
		self._transitionAnim:clearCallbacks()
	end)
end

function ActivityOrientMainMediator:onClickRule()
	local rules = self._activityConfig.RuleDesc
	local start = self._blockActivityBaseData[KMapIds[1]].TimeFactor.start[1]
	local startTime = TimeUtil:formatStrToRemoteTImestamp(start)
	local date = TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", startTime)

	self._activitySystem:showActivityRules(rules, nil, {
		time = date
	})
end

function ActivityOrientMainMediator:onClickTask()
	if #self._taskActivities == 0 then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.taskEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSupportTaskView(self._activityId)
end

function ActivityOrientMainMediator:onClickLogin()
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

function ActivityOrientMainMediator:onClickEgg()
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

function ActivityOrientMainMediator:onClickSurface()
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

function ActivityOrientMainMediator:onClickLeft()
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

function ActivityOrientMainMediator:onClickRight()
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

function ActivityOrientMainMediator:onClickRolePanel()
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

function ActivityOrientMainMediator:setStageView()
	local ui = self._activity:getUI()
	local anim = OrientActivityMainConfig.anim[ui]

	if not self._stageAnim and anim then
		self._stageAnim = cc.MovieClip:create(anim.name)

		self._stageAnim:setPosition(anim.position)
		self._stageAnim:addTo(self._stagePanel:getChildByName("button"))

		if self._stagePanel:getChildByName("image") then
			self._stagePanel:getChildByName("image"):setVisible(false)
		end

		if anim.runAction then
			anim.runAction(self._stageAnim)
		end
	end
end

function ActivityOrientMainMediator:onClickVote()
	self._activity:checkVote()
end
