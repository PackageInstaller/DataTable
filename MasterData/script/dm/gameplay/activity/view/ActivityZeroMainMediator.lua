-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityZeroMainMediator.lua

ActivityZeroMainMediator = class("ActivityZeroMainMediator", DmAreaViewMediator, _M)

ActivityZeroMainMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityZeroMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityZeroMainMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")
ActivityZeroMainMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
ActivityZeroMainMediator:has("_bagSystem", {
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
	["main.bestRewardBtn"] = {
		ignoreClickAudio = true,
		func = "onClickBestRewardBtn"
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

function ActivityZeroMainMediator:initialize()
	super.initialize(self)
end

function ActivityZeroMainMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityZeroMainMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._roleTimer then
		self._roleTimer:stop()

		self._roleTimer = nil
	end
end

function ActivityZeroMainMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
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
	self._bestRewardBtn = self._main:getChildByName("bestRewardBtn")
	self._animNode = self._enterPanel:getChildByName("animNode")

	local vertices = {
		cc.p(-10, 0),
		cc.p(148, 180),
		cc.p(310, 0)
	}
	local shape = ccui.HittingPolygon:create(vertices)

	self._cardBtn:setHittingShape(shape)
end

function ActivityZeroMainMediator:setupTopInfoWidget()
	local currencyInfo = self._activity:getResourcesBanner()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		style = 1,
		hideLine = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self._topPanel:setContentSize(cc.size(#currencyInfo * 150 + 152, 75))
end

function ActivityZeroMainMediator:enterWithData(data)
	if data then
		self._resumeName = data.resumeName or nil
	end

	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)

	if not self._activity then
		return
	end

	self._canChangeHero = true

	self:initData()
	self:setupTopInfoWidget()
	self:initView()
	self:runBtnAnim()
	self:playBackgroundMusic()
end

function ActivityZeroMainMediator:playBackgroundMusic()
	local bgm = self._activity:getBgm()

	if bgm then
		AudioEngine:getInstance():playBackgroundMusic(bgm)
	end
end

function ActivityZeroMainMediator:resumeWithData()
	local quit = self:doReset()

	if quit then
		return
	end

	self:initData()
	self:initView()
	self:playBackgroundMusic()
end

function ActivityZeroMainMediator:initData()
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._blockActivity = nil
	self._taskActivities = {}
	self._loginActivity = nil
	self._colourEggActivity = nil
	self._monsterShopActivity = nil

	if self._activity then
		self._taskActivities = self._activity:getTaskActivities()
		self._monsterShopActivity = self._activity:getExchangeActivity()
	end

	self._roleIndex = 1
	self._roles = self._activity:getRoleParams()
	self._curTotalPoint = self._activity:getCurTotalPoint()
	self._MaxPoint = self._activity:getActivityConfig().TotalPoint
	self._MainReward = self._activity:getActivityConfig().MainReward
	self._isBigReward = self._activity:getBigReward()
end

function ActivityZeroMainMediator:initView()
	self:initInfo()
	self:initPointReward()
	self:initTimer()
	self:initRoleTimer()
	self:updateRolePanel()
end

function ActivityZeroMainMediator:initPointReward()
	local redPoint = self._bestRewardBtn:getChildByName("redPoint")
	local iconNode = self._bestRewardBtn:getChildByName("iconNode")
	local pointNum = self._bestRewardBtn:getChildByName("pointNum")
	local rewardIcon = self._bestRewardBtn:getChildByName("rewardIcon")

	redPoint:setVisible(self._activity:hasBigRewardRedPoint())
	pointNum:setString(self._curTotalPoint .. "/" .. self._MaxPoint)
	rewardIcon:removeAllChildren()

	local rewards = RewardSystem:getRewardsById(self._MainReward)
	local icon = IconFactory:createRewardIcon(rewards[1], {
		isWidget = true
	})

	rewardIcon:addChild(icon)
	icon:setAnchorPoint(cc.p(0.5, 0.5))
	icon:setPosition(cc.p(0, 0))
	icon:setScaleNotCascade(1)
	IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[1], {
		needDelay = true
	})

	local itemId = self._activity:getActivityPointItemId()
	local goldIcon = IconFactory:createPic({
		id = CurrencyIdKind.kGold
	})
	local goldSize = goldIcon:getContentSize()

	iconNode:removeAllChildren()

	local iconPic = IconFactory:createPic({
		id = itemId
	}, {
		showWidth = goldSize.height
	})

	if iconPic then
		iconPic:addTo(iconNode)
	end

	iconNode:setPositionX(pointNum:getPositionX() - pointNum:getContentSize().width / 2 - 20)
end

function ActivityZeroMainMediator:initInfo()
	self._imageBg:loadTexture(self._activity:getBgPath())

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

	self._endTip.taskEndTip = Strings:get(tipStr, {
		activityId = Strings:get("ActivityBlock_UI_10")
	})
	self._endTip.blockEndTip = Strings:get("Activity_Block_Wsj_endtip")
	self._endTip.cardEndTip = Strings:get("Activity_Block_Wsj_endtip")
	self._endTip.loginEndTip = Strings:get("Activity_Block_Wsj_endtip")
	self._endTip.shopEndTip = Strings:get("Activity_Block_Wsj_endtip")
end

function ActivityZeroMainMediator:initTimer()
	local text = self._timeNode:getChildByName("time")

	text:setString(self._activity:getTimeStr())

	local remainLabel = self._enterPanel:getChildByName("remainTime")

	if self._activity then
		local remoteTimestamp = self._activitySystem:getCurrentTime()
		local timeStamp = self._activity:getTimeFactor()
		local _, _, y, mon, d, h, m, s = string.find(timeStamp.start[2], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
		local table = {
			year = y,
			month = mon,
			day = d,
			hour = h,
			min = m,
			sec = s
		}

		self._endTime = TimeUtil:getTimeByDate(table)

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

				remainLabel:setString(Strings:get("Activity_Saga_UI_1", {
					time = str
				}))
			end

			self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

			checkTimeFunc()
		end
	end
end

function ActivityZeroMainMediator:initRoleTimer()
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

function ActivityZeroMainMediator:updateRolePanel()
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

		local img, jsonPath = IconFactory:createRoleIconSprite({
			useAnim = true,
			iconType = "Bust4",
			id = model
		})

		img:addTo(self._roleNode):posite(50, -50)
		img:setScale(0.78)
		self._surfaceBtn:setVisible(showTip and showSurface)
		self._surfaceBtn1:setVisible(not showTip)
		self._surfaceBtn:getChildByFullName("img"):loadTexture(kModelBtnRes[type_], ccui.TextureResType.plistType)
	end
end

function ActivityZeroMainMediator:doReset()
	self:stopTimer()

	local model = self._activitySystem:getActivityById(self._activityId)

	if not model then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return true
	end

	self:initData()
	self:initView()

	return false
end

function ActivityZeroMainMediator:refreshView()
	self:doReset()
end

function ActivityZeroMainMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivityZeroMainMediator:onClickRule()
	local rules = self._activity:getActivityConfig().RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityZeroMainMediator:onClickStage()
	self._activitySystem:enterSelecteZeroMap(self._activityId)
end

function ActivityZeroMainMediator:onClickTask()
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

function ActivityZeroMainMediator:onClickCard()
	local model = self._activitySystem:getActivityById(self._activityId)

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

function ActivityZeroMainMediator:onClickBlock()
	self:onClickStage()
end

function ActivityZeroMainMediator:onClickShop()
	self._shopActivity = self._activity:getExchangeActivity()

	if not self._shopActivity then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.shopEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterZeroShop(self._activityId)
end

function ActivityZeroMainMediator:onClickBestRewardBtn()
	if self._isBigReward then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Activity_Zero_title_7")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if self._curTotalPoint < self._MaxPoint then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Activity_Zero_title_6")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	self._activity:requestGetResultReward()
end

function ActivityZeroMainMediator:onClickLogin()
	local model = self._activitySystem:getActivityById(self._activityId)

	if not model then
		self:dispatch(ShowTipEvent({
			tip = self._endTip.loginEndTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = model:getActivityConfig().LoginActivityLink,
		extParams = {}
	}))
end

function ActivityZeroMainMediator:onClickSurface()
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

function ActivityZeroMainMediator:onClickLeft()
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

function ActivityZeroMainMediator:onClickRight()
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

function ActivityZeroMainMediator:runBtnAnim()
	local leftBtn = self:getView():getChildByFullName("btnPanel.left.leftBtn")
	local rightBtn = self:getView():getChildByFullName("btnPanel.right.rightBtn")

	CommonUtils.runActionEffect(leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
	CommonUtils.runActionEffect(rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
end
