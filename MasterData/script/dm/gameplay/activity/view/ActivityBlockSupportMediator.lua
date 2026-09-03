-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockSupportMediator.lua

ActivityBlockSupportMediator = class("ActivityBlockSupportMediator", DmAreaViewMediator, _M)

ActivityBlockSupportMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockSupportMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockSupportMediator:has("_surfaceSystem", {
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
	["main.taskBtn"] = {
		ignoreClickAudio = true,
		func = "onClickTask"
	},
	["main.teamBtn"] = {
		ignoreClickAudio = true,
		func = "onClickTeam"
	},
	["main.blockBtn"] = {
		ignoreClickAudio = true,
		func = "onClickStage"
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

function ActivityBlockSupportMediator:initialize()
	super.initialize(self)
end

function ActivityBlockSupportMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityBlockSupportMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._roleTimer then
		self._roleTimer:stop()

		self._roleTimer = nil
	end
end

function ActivityBlockSupportMediator:onRegister()
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
	self._roleNode = self._main:getChildByName("roleNode")
	self._btnNode = self._main:getChildByName("btnNode")
	self._timeNode = self._main:getChildByName("timeNode")
	self._supportPanel = self._main:getChildByName("supportPanel")
	self._taskBtn = self._main:getChildByName("taskBtn")
	self._blockBtn = self._main:getChildByName("blockBtn")
	self._teamBtn = self._main:getChildByName("teamBtn")

	self._taskBtn:getChildByFullName("text"):getVirtualRenderer():setLineSpacing(-15)

	if self._blockBtn:getChildByFullName("text") then
		self._blockBtn:getChildByFullName("text"):getVirtualRenderer():setLineSpacing(-15)
	end

	self._teamBtn:getChildByFullName("text"):getVirtualRenderer():setLineSpacing(-15)
end

function ActivityBlockSupportMediator:setupTopInfoWidget()
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

function ActivityBlockSupportMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local currencyInfo = self._supportActivity:getResourcesBanner()
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

function ActivityBlockSupportMediator:enterWithData(data)
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

function ActivityBlockSupportMediator:resumeWithData()
	self:doReset()
end

function ActivityBlockSupportMediator:initData()
	self._blockActivity = self._supportActivity:getBlockMapActivity()
	self._taskActivities = self._supportActivity:getTaskActivities()
	self._roleIndex = 1
	self._roles = self._supportActivity:getRoleParams()
	self._clickSupport = false
end

function ActivityBlockSupportMediator:initView()
	self:initInfo()
	self:initTimer()
	self:initRoleTimer()
	self:updateRolePanel()
end

function ActivityBlockSupportMediator:initInfo()
	local blockBtnText = self:getView():getChildByFullName("main.blockBtn.text")
	local taskBtnText = self:getView():getChildByFullName("main.taskBtn.text")
	local teamBtnText = self:getView():getChildByFullName("main.teamBtn.text")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		if blockBtnText then
			blockBtnText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
			blockBtnText:getVirtualRenderer():setDimensions(120, 50)
			blockBtnText:setPosition(cc.p(50, 17))
		end

		taskBtnText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
		taskBtnText:getVirtualRenderer():setDimensions(90, 50)
		taskBtnText:setPosition(cc.p(50, 40))
		teamBtnText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
		teamBtnText:getVirtualRenderer():setDimensions(90, 50)
		teamBtnText:setPosition(cc.p(50, 40))
	else
		taskBtnText:getVirtualRenderer():setLineSpacing(-15)
		teamBtnText:getVirtualRenderer():setLineSpacing(-15)

		if blockBtnText then
			blockBtnText:getVirtualRenderer():setLineSpacing(-15)
			blockBtnText:getVirtualRenderer():setDimensions(30, 84)
		end

		taskBtnText:getVirtualRenderer():setDimensions(25, 73)
		teamBtnText:getVirtualRenderer():setDimensions(25, 73)
	end

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

	if self._activityId == ActivityId.kActivityWxh or self._activityId == ActivityId.kActivityWxhNew then
		self._endTip.supportEndTip = Strings:get("Activity_Saga_UI_endtip_support_wxh")
	end

	local redPoint = self._blockBtn:getChildByName("redPoint")

	redPoint:setVisible(self._blockActivity and self._blockActivity:hasRedPoint())

	if self._activityId == ActivityId.kActivityWxh or self._activityId == ActivityId.kActivityWxhNew then
		local anim = self._blockBtn:getChildByFullName("anim")

		anim:removeChildByName("blockAnim")

		local blockAnim = cc.MovieClip:create("deng_wuxiuzhuye")

		blockAnim:addTo(anim):posite(0, -150)
		blockAnim:setName("blockAnim")
		blockAnim:addCallbackAtFrame(1, function()
			local fuBenNode = blockAnim:getChildByName("fuBenNode")
			local localLanguage = getCurrentLanguage()

			if localLanguage ~= GameLanguageType.CN then
				fuBenNode:setPosition(cc.p(-33, 170))
			end
		end)

		self._endTip.blockEndTip = Strings:get("Activity_Saga_UI_endtip_block_wxh")
	else
		local image = self._blockBtn:getChildByName("image")

		image:ignoreContentAdaptWithSize(true)

		local text = self._blockBtn:getChildByName("text")

		if btns.blockParams then
			image:loadTexture(btns.blockParams.icon .. ".png", 1)

			local title = btns.blockParams.title

			text:setString(title)

			self._endTip.blockEndTip = Strings:get(tipStr, {
				activityId = title
			})
		end
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

	if self._activityId == ActivityId.kActivityWxh or self._activityId == ActivityId.kActivityWxhNew then
		local anim = self._supportPanel:getChildByFullName("anim")

		anim:removeChildByName("supportAnim")

		local supportAnim = cc.MovieClip:create("daluo_wuxiuzhuye")

		supportAnim:addTo(anim):posite(0, 0)
		supportAnim:setName("supportAnim")
	else
		self._supportPanel:removeChildByName("supportAnim")

		local supportAnim = cc.MovieClip:create("xingguangyingyuan_zuohehuodongzhuye")

		supportAnim:addTo(self._supportPanel):posite(185, 183)
		supportAnim:setName("supportAnim")
	end
end

function ActivityBlockSupportMediator:initTimer()
	local text = self._timeNode:getChildByName("time")

	text:setString(self._supportActivity:getTimeStr())

	local remainLabel = self._supportPanel:getChildByName("remainTime")

	if self._supportActivity then
		local remoteTimestamp = self._activitySystem:getCurrentTime()

		self._endTime = self._supportActivity:getLastPeriodEndTime() / 1000

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

				local s = (self._activityId == ActivityId.kActivityWxh or self._activityId == ActivityId.kActivityWxhNew) and "Activity_Saga_UI_1_wxh" or "Activity_Saga_UI_1"

				remainLabel:setString(Strings:get(s, {
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

function ActivityBlockSupportMediator:initRoleTimer()
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

function ActivityBlockSupportMediator:updateRolePanel()
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
		self._tipNode:setVisible(showTip)
	end
end

function ActivityBlockSupportMediator:doReset()
	self:stopTimer()

	self._supportActivity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._supportActivity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivityBlockSupportMediator:refreshView()
	self:doReset()
end

function ActivityBlockSupportMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivityBlockSupportMediator:onClickStage()
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

function ActivityBlockSupportMediator:onClickRule()
	local rules = self._supportActivity:getActivityConfig().RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockSupportMediator:onClickTask()
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

function ActivityBlockSupportMediator:onClickTeam()
	if not self._blockActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.blockEndTip
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)
	self._activitySystem:enterTeam(self._activityId, self._blockActivity)
end

function ActivityBlockSupportMediator:onClickSupport()
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

	if self._activityId == ActivityId.kActivityWxh or self._activityId == ActivityId.kActivityWxhNew then
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
	else
		self._clickSupport = true

		AudioEngine:getInstance():playEffect("Se_Alert_Pop_Rabbit", false)
		self._activitySystem:enterSagaSupportStage(self._activityId)
	end
end

function ActivityBlockSupportMediator:onClickSurface()
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

function ActivityBlockSupportMediator:onClickLeft()
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

function ActivityBlockSupportMediator:onClickRight()
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

function ActivityBlockSupportMediator:showWinnerView()
	local data = self._supportActivity:getHeroDataById(self._supportActivity:getWinHeroId())

	if data and self._resumeName == nil then
		self._activitySystem:enterSagaWinView(self._activityId)
	end
end

function ActivityBlockSupportMediator:runBtnAnim()
	local leftBtn = self:getView():getChildByFullName("btnPanel.left.leftBtn")
	local rightBtn = self:getView():getChildByFullName("btnPanel.right.rightBtn")

	CommonUtils.runActionEffect(leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
	CommonUtils.runActionEffect(rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
end

function ActivityBlockSupportMediator:onClickRolePanel()
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
