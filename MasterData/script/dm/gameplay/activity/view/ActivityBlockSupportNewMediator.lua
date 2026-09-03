-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockSupportNewMediator.lua

ActivityBlockSupportNewMediator = class("ActivityBlockSupportNewMediator", DmAreaViewMediator, _M)

ActivityBlockSupportNewMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockSupportNewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockSupportNewMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kBtnHandlers = {
	["main.supportPanel.button"] = {
		ignoreClickAudio = true,
		func = "onClickSupport"
	},
	["main.surfacebtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSurface"
	},
	["main.blockBtn"] = {
		ignoreClickAudio = true,
		func = "onClickTask"
	},
	tipBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["btnPanel.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["btnPanel.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
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

function ActivityBlockSupportNewMediator:initialize()
	super.initialize(self)
end

function ActivityBlockSupportNewMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityBlockSupportNewMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._roleTimer then
		self._roleTimer:stop()

		self._roleTimer = nil
	end
end

function ActivityBlockSupportNewMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:setupTopInfoWidget()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._topPanel = self:getView():getChildByName("topPanel")
	self._main = self:getView():getChildByName("main")
	self._imageBg = self._main:getChildByName("Imagebg")
	self._titleImage = self._main:getChildByName("titleImage")

	if self._titleImage then
		self._titleImage:ignoreContentAdaptWithSize(true)
	end

	self._surfaceBtn = self._main:getChildByName("surfacebtn")
	self._tipNode = self._main:getChildByName("tipNode")

	self._tipNode:setVisible(false)

	self._roleNode = self._main:getChildByName("roleNode")
	self._btnNode = self._main:getChildByName("btnNode")
	self._timeNode = self._main:getChildByName("timeNode")
	self._supportPanel = self._main:getChildByName("supportPanel")
	self._taskBtn = self._main:getChildByName("taskBtn")
	self._blockBtn = self._main:getChildByName("blockBtn")
	self._teamBtn = self._main:getChildByName("teamBtn")

	self._taskBtn:getChildByFullName("text"):setString("")
	self._taskBtn:getChildByFullName("text1"):setString("")

	if self._blockBtn:getChildByFullName("text") then
		self._blockBtn:getChildByFullName("text"):getVirtualRenderer():setLineSpacing(-15)
	end

	self._teamBtn:getChildByFullName("text"):setString("")
	self._teamBtn:getChildByFullName("text1"):setString("")
end

function ActivityBlockSupportNewMediator:setupTopInfoWidget()
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

function ActivityBlockSupportNewMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local currencyInfo = self._supportActivity:getResourcesBanner() or {
		CurrencyIdKind.kDiamond,
		CurrencyIdKind.kPower,
		CurrencyIdKind.kCrystal,
		CurrencyIdKind.kGold
	}
	local config = {
		hideLine = true,
		style = 1,
		currencyInfo = currencyInfo
	}

	self._topInfoWidget:updateView(config)

	if self._topPanel then
		self._topPanel:setContentSize(cc.size(#currencyInfo * 150 + 152, 75))
	end
end

function ActivityBlockSupportNewMediator:enterWithData(data)
	if data then
		self._resumeName = data.resumeName or nil
	end

	self._activityId = data.activityId
	self._supportActivity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._supportActivity then
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
	self:runBtnAnim()
	self:showWinnerView()
end

function ActivityBlockSupportNewMediator:resumeWithData()
	self:doReset()
end

function ActivityBlockSupportNewMediator:initData()
	self._blockActivity = self._supportActivity:getBlockMapActivity()
	self._taskActivities = self._supportActivity:getTaskActivities()
	self._roleIndex = 1
	self._roles = self._supportActivity:getRoleParams()
	self._clickSupport = false
end

function ActivityBlockSupportNewMediator:initView()
	self:initInfo()
	self:initTimer()
	self:initRoleTimer()
	self:updateRolePanel()
	self:playBackgroundMusic()
end

function ActivityBlockSupportNewMediator:playBackgroundMusic()
	local bgm = self._supportActivity:getBgm()

	if bgm then
		AudioEngine:getInstance():playBackgroundMusic(bgm)
	end
end

function ActivityBlockSupportNewMediator:initInfo()
	self._imageBg:loadTexture(self._supportActivity:getBgPath())

	if self._titleImage then
		self._titleImage:loadTexture(self._supportActivity:getTitlePath(), 1)
	end

	local btns = self._supportActivity:getButtonConfig()
	local tipStr = self._supportActivity:getActivityConfig().SubActivityEndTip

	self._endTip = {}

	local redPoint = self._supportPanel:getChildByName("redPoint")

	redPoint:setVisible(self._supportActivity and self._supportActivity:activityHasRedPoint())
	redPoint:setLocalZOrder(99)

	local text1 = self._supportPanel:getChildByName("text1")
	local text2 = self._supportPanel:getChildByName("text2")

	if btns.supportParams then
		local title = btns.supportParams.title
		local length = utf8.len(title)
		local name1 = utf8.sub(title, 1, 2)
		local name2 = utf8.sub(title, 3, length)

		text1:setString(name1)
		text2:setString(name2)

		self._endTip.supportEndTip = Strings:get(tipStr, {
			activityId = title
		})
	end

	local redPoint = self._teamBtn:getChildByName("redPoint")

	redPoint:setVisible(false)

	local redPoint = self._taskBtn:getChildByName("redPoint")

	redPoint:setVisible(false)

	self._endTip.taskEndTip = Strings:get(tipStr, {
		activityId = Strings:get("ActivityBlock_UI_10")
	})

	local redPoint = self._blockBtn:getChildByName("redPoint")
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

	local anim = self._blockBtn:getChildByFullName("anim")

	anim:removeChildByName("blockAnim")

	local blockAnim = cc.MovieClip:create("deng_wuxiuzhuye")

	blockAnim:addTo(anim):posite(0, -150)
	blockAnim:setName("blockAnim")

	local titleNode = blockAnim:getChildByName("title")

	titleNode:removeAllChildren()

	local img = ccui.ImageView:create("zbrzhan_rw_rukou.png", 1)

	img:addTo(titleNode):center(titleNode:getContentSize())

	local anim = self._supportPanel:getChildByFullName("anim")

	anim:removeChildByName("supportAnim")

	local supportAnim = cc.MovieClip:create("daluo_wuxiuzhuye")

	supportAnim:addTo(anim):posite(0, 0)
	supportAnim:setName("supportAnim")
end

function ActivityBlockSupportNewMediator:initTimer()
	local text = self._timeNode:getChildByName("time")

	text:setString(self._supportActivity:getTimeStr())

	local remainLabel = self._supportPanel:getChildByName("remainTime")

	if self._supportActivity then
		local remoteTimestamp = self._activitySystem:getCurrentTime()

		self._endTime = self._supportActivity:getLastPeriodEndTime() / 1000 - self._supportActivity:getLastPeriodRestTime()

		if remoteTimestamp < self._endTime then
			if self._timer then
				return
			end

			local function checkTimeFunc()
				remoteTimestamp = self._activitySystem:getCurrentTime()

				local remainTime = self._endTime - remoteTimestamp

				if remainTime <= 0 then
					if DisposableObject:isDisposed(self) then
						return
					end

					self._timer:stop()

					self._timer = nil

					remainLabel:setString(Strings:get("Activity_Saga_UI_2"))

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

				remainLabel:setString(Strings:get("Activity_Saga_UI_1_wxh", {
					time = str
				}))
			end

			self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

			checkTimeFunc()
		else
			remainLabel:setString(Strings:get("Activity_Saga_UI_2"))
		end
	else
		remainLabel:setString(Strings:get("Activity_Saga_UI_2"))
	end
end

function ActivityBlockSupportNewMediator:initRoleTimer()
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

function ActivityBlockSupportNewMediator:updateRolePanel()
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

		img:addTo(self._roleNode):posite(50, -50)
		img:setScale(0.78)
		self._surfaceBtn:setVisible(showTip and showSurface)
		self._tipNode:setVisible(false)
	end
end

function ActivityBlockSupportNewMediator:doReset()
	self:stopTimer()

	self._supportActivity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._supportActivity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivityBlockSupportNewMediator:refreshView()
	self:doReset()
end

function ActivityBlockSupportNewMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivityBlockSupportNewMediator:onClickStage()
	if not self._blockActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.blockEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Daochang", false)
	self._activitySystem:enterSupportStage(self._activityId)
end

function ActivityBlockSupportNewMediator:onClickRule()
	local rules = self._supportActivity:getActivityConfig().RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockSupportNewMediator:onClickTask()
	if #self._taskActivities == 0 then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.taskEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
	self._activitySystem:enterSupportTaskView(self._activityId)
end

function ActivityBlockSupportNewMediator:onClickTeam()
	if not self._blockActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.blockEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
	self._activitySystem:enterTeam(self._activityId, self._blockActivity)
end

function ActivityBlockSupportNewMediator:onClickSupport()
	if not self._supportActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.supportEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if self._clickSupport then
		return
	end

	self._clickSupport = true

	local anim = self._supportPanel:getChildByFullName("anim")
	local supportAnim = anim:getChildByFullName("supportAnim")

	supportAnim:setVisible(false)

	local supportAnim2 = cc.MovieClip:create("daluo2_wuxiuzhuye")

	supportAnim2:addTo(anim):posite(0, 0)
	supportAnim2:setName("supportAnim2")
	supportAnim2:addCallbackAtFrame(10, function()
		supportAnim:setVisible(true)
		supportAnim2:stop()
		supportAnim2:removeFromParent()
		AudioEngine:getInstance():playEffect("Se_Click_Luo", false)
		self._activitySystem:enterSagaSupportStage(self._activityId)
	end)
end

function ActivityBlockSupportNewMediator:onClickSurface()
	if not self._roleUrl or self._roleUrl == "" then
		return
	end

	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(self._roleUrl)

	if not entry then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Function_Not_Open")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	else
		entry:response(context, params)
	end
end

function ActivityBlockSupportNewMediator:onClickLeft()
	if not self._canChangeHero then
		return
	end

	self:initRoleTimer()

	self._canChangeHero = false

	performWithDelay(self:getView(), function()
		self._canChangeHero = true
	end, 0.5)

	self._roleIndex = self._roleIndex - 1

	if self._roleIndex < 1 then
		self._roleIndex = #self._roles
	end

	self:updateRolePanel()
end

function ActivityBlockSupportNewMediator:onClickRight()
	if not self._canChangeHero then
		return
	end

	self:initRoleTimer()

	self._canChangeHero = false

	performWithDelay(self:getView(), function()
		self._canChangeHero = true
	end, 0.5)

	self._roleIndex = self._roleIndex + 1

	if self._roleIndex > #self._roles then
		self._roleIndex = 1
	end

	self:updateRolePanel()
end

function ActivityBlockSupportNewMediator:showWinnerView()
	local data = self._supportActivity:getHeroDataById(self._supportActivity:getWinHeroId())

	if data and self._resumeName == nil then
		self._activitySystem:enterSagaWinView(self._activityId)
	end
end

function ActivityBlockSupportNewMediator:runBtnAnim()
	local leftBtn = self:getView():getChildByFullName("btnPanel.left.leftBtn")
	local rightBtn = self:getView():getChildByFullName("btnPanel.right.rightBtn")

	CommonUtils.runActionEffect(leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
	CommonUtils.runActionEffect(rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
end

function ActivityBlockSupportNewMediator:onClickRolePanel()
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
