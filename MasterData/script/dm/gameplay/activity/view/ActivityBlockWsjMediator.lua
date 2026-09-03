-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockWsjMediator.lua

ActivityBlockWsjMediator = class("ActivityBlockWsjMediator", DmAreaViewMediator, _M)

ActivityBlockWsjMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockWsjMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockWsjMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")
ActivityBlockWsjMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
ActivityBlockWsjMediator:has("_bagSystem", {
	is = "rw"
}):injectWith("BagSystem")

local kBtnHandlers = {
	["main.enterPanel.button"] = {
		ignoreClickAudio = true,
		func = "onClickStage"
	},
	["main.surfacebtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSurface"
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
	["main.cardBtn"] = {
		ignoreClickAudio = true,
		func = "onClickCard"
	},
	["main.taskBtn"] = {
		ignoreClickAudio = true,
		func = "onClickTask"
	},
	["main.blockBtn"] = {
		ignoreClickAudio = true,
		func = "onClickBlock"
	},
	["main.shopBtn"] = {
		ignoreClickAudio = true,
		func = "onClickShop"
	},
	["main.loginBtn"] = {
		ignoreClickAudio = true,
		func = "onClickLogin"
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

function ActivityBlockWsjMediator:initialize()
	super.initialize(self)
end

function ActivityBlockWsjMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityBlockWsjMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._roleTimer then
		self._roleTimer:stop()

		self._roleTimer = nil
	end
end

function ActivityBlockWsjMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:setupTopInfoWidget()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._topPanel = self:getView():getChildByName("topPanel")
	self._main = self:getView():getChildByName("main")
	self._imageBg = self._main:getChildByName("Imagebg")
	self._surfaceBtn = self._main:getChildByName("surfacebtn")
	self._surfaceBtn1 = self._main:getChildByName("surfacebtn1")
	self._tipNode = self._main:getChildByName("tipNode")
	self._roleNode = self._main:getChildByName("roleNode")
	self._timeNode = self._main:getChildByName("timeNode")
	self._enterPanel = self._main:getChildByName("enterPanel")
	self._taskBtn = self._main:getChildByName("taskBtn")
	self._cardBtn = self._main:getChildByName("cardBtn")
	self._blockBtn = self._main:getChildByName("blockBtn")
	self._shopBtn = self._main:getChildByName("shopBtn")
	self._loginBtn = self._main:getChildByName("loginBtn")
	self._animNode = self._enterPanel:getChildByName("animNode")

	local text = self._enterPanel:getChildByName("taskBtn")
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 170, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(145, 217, 255, 255)
		}
	}

	text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	text:enableOutline(cc.c4b(3, 3, 3, 255), 1)

	local vertices = {
		cc.p(-10, 0),
		cc.p(148, 180),
		cc.p(310, 0)
	}
	local shape = ccui.HittingPolygon:create(vertices)

	self._loginBtn:setHittingShape(shape)
end

function ActivityBlockWsjMediator:setupTopInfoWidget()
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

function ActivityBlockWsjMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local currencyInfo = self._activity:getResourcesBanner()
	local config = {
		hideLine = true,
		style = 1,
		currencyInfo = currencyInfo
	}

	self._topInfoWidget:updateView(config)
	self._topPanel:setContentSize(cc.size(#currencyInfo * 150 + 152, 75))
end

function ActivityBlockWsjMediator:enterWithData(data)
	if data then
		self._resumeName = data.resumeName or nil
	end

	self._activityId = data.activityId
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
	self:runBtnAnim()
end

function ActivityBlockWsjMediator:playBackgroundMusic()
	local bgm = self._activity:getBgm()

	AudioEngine:getInstance():playBackgroundMusic(bgm)
end

function ActivityBlockWsjMediator:resumeWithData()
	self:doReset()
end

function ActivityBlockWsjMediator:initData()
	self._blockActivity = self._activity:getBlockMapActivity()
	self._taskActivities = self._activity:getTaskActivities()
	self._loginActivity = self._activity:getLoginActivities()
	self._colourEggActivity = self._activity:getColourEggActivity()
	self._monsterShopActivity = self._activity:getMonsterShopActivity()
	self._roleIndex = 1
	self._roles = self._activity:getRoleParams()
end

function ActivityBlockWsjMediator:initView()
	self:initInfo()
	self:initTimer()
	self:initRoleTimer()
	self:updateRolePanel()
	self:playBackgroundMusic()
end

function ActivityBlockWsjMediator:initInfo()
	self._imageBg:loadTexture(self._activity:getBgPath())

	local btns = self._activity:getButtonConfig()
	local tipStr = self._activity:getActivityConfig().SubActivityEndTip

	self._endTip = {}

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

	local redPoint = self._blockBtn:getChildByName("redPoint")

	redPoint:setVisible(self._blockActivity and self._blockActivity:hasRedPoint())

	local redPoint = self._enterPanel:getChildByName("redPoint")

	redPoint:setVisible(self._blockActivity and self._blockActivity:hasRedPoint())

	local redPoint = self._cardBtn:getChildByName("redPoint")

	redPoint:setVisible(false)

	local redPoint = self._shopBtn:getChildByName("redPoint")

	redPoint:setVisible(self._monsterShopActivity and self._monsterShopActivity:hasRedPoint())

	local redPoint = self._loginBtn:getChildByName("redPoint")

	redPoint:setVisible(self._loginActivity and self._loginActivity:hasRedPoint())

	self._endTip.taskEndTip = Strings:get(tipStr)
	self._endTip.blockEndTip = Strings:get(tipStr)
	self._endTip.cardEndTip = Strings:get(tipStr)
	self._endTip.loginEndTip = Strings:get(tipStr)
	self._endTip.shopEndTip = Strings:get(tipStr)
end

function ActivityBlockWsjMediator:initTimer()
	local text = self._timeNode:getChildByName("time")

	text:setString(self._activity:getTimeStr())

	local remainLabel = self._enterPanel:getChildByName("remainTime")

	if self._activity then
		local blockActivity = self._activity:getBlockMapActivity()

		if not blockActivity then
			remainLabel:setString(Strings:get("SubActivity_Halloween_EndTip_AB_1st"))

			return
		end

		local remoteTimestamp = self._activitySystem:getCurrentTime()
		local timeStamp = blockActivity:getTimeFactor()
		local _, _, y, mon, d, h, m, s = string.find(timeStamp.start[2], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
		local table = {
			year = y,
			month = mon,
			day = d,
			hour = h,
			min = m,
			sec = s
		}

		self._endTime = TimeUtil:timeByRemoteDate(table)

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

					remainLabel:setString(Strings:get("SubActivity_Halloween_EndTip_AB_1st"))

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

				remainLabel:setString(Strings:get("Activity_HalloweenActivity_UI", {
					time = str
				}))
			end

			self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

			checkTimeFunc()
		end
	end
end

function ActivityBlockWsjMediator:initRoleTimer()
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

function ActivityBlockWsjMediator:updateRolePanel()
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
		self._surfaceBtn1:setVisible(not showTip)
		self._tipNode:setVisible(showTip)
		self._surfaceBtn:getChildByFullName("img"):loadTexture(kModelBtnRes[type_], ccui.TextureResType.plistType)
	end
end

function ActivityBlockWsjMediator:doReset()
	self:stopTimer()

	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivityBlockWsjMediator:refreshView()
	self:doReset()
end

function ActivityBlockWsjMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivityBlockWsjMediator:onClickRule()
	local rules = self._activity:getActivityConfig().RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockWsjMediator:onClickStage()
	self._blockActivity = self._activity:getBlockMapActivity()

	if not self._blockActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.blockEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Story_Dream", false)
	self._activitySystem:enterBlockMap(self._activityId)
end

function ActivityBlockWsjMediator:onClickTask()
	self._taskActivities = self._activity:getTaskActivities()

	if #self._taskActivities == 0 then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.taskEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSupportTaskView(self._activityId)
end

function ActivityBlockWsjMediator:onClickCard()
	local model = self._activitySystem:getActivityByComplexId(self._activityId)

	if not model then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.cardEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local recruitSystem = self:getInjector():getInstance(RecruitSystem)
	local data = {
		recruitId = model:getActivityConfig().DrawCard
	}

	recruitSystem:tryEnter(data)
end

function ActivityBlockWsjMediator:onClickBlock()
	self:onClickStage()
end

function ActivityBlockWsjMediator:onClickShop()
	self._monsterShopActivity = self._activity:getMonsterShopActivity()

	if not self._monsterShopActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.shopEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterBlockMonsterShopView(self._activityId)
end

function ActivityBlockWsjMediator:onClickLogin()
	local loginId = self._activity:getActivityConfig().LoginActivity
	local model = self._activitySystem:getActivityByComplexId(loginId)

	if not model then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.loginEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = self._activity:getActivityConfig().LoginActivityLink,
		extParams = {}
	}))
end

function ActivityBlockWsjMediator:onClickSurface()
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

function ActivityBlockWsjMediator:onClickLeft()
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

function ActivityBlockWsjMediator:onClickRight()
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

function ActivityBlockWsjMediator:runBtnAnim()
	local leftBtn = self:getView():getChildByFullName("btnPanel.left.leftBtn")
	local rightBtn = self:getView():getChildByFullName("btnPanel.right.rightBtn")

	CommonUtils.runActionEffect(leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
	CommonUtils.runActionEffect(rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
end
