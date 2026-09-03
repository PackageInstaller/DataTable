-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockSummerMediator.lua

ActivityBlockSummerMediator = class("ActivityBlockSummerMediator", DmAreaViewMediator, _M)

ActivityBlockSummerMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockSummerMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockSummerMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")
ActivityBlockSummerMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
ActivityBlockSummerMediator:has("_bagSystem", {
	is = "rw"
}):injectWith("BagSystem")

local kBtnHandlers = {
	["main.summerPanel.button"] = {
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
	["main.homeBtn"] = {
		ignoreClickAudio = true,
		func = "onClickHomeExchange"
	},
	["main.clubBtn"] = {
		ignoreClickAudio = true,
		func = "onClickClub"
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
	}
}
local kModelType = {
	kSurface = "Surface",
	kHero = "Hero"
}

function ActivityBlockSummerMediator:initialize()
	super.initialize(self)
end

function ActivityBlockSummerMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityBlockSummerMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._roleTimer then
		self._roleTimer:stop()

		self._roleTimer = nil
	end
end

function ActivityBlockSummerMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:setupTopInfoWidget()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._topPanel = self:getView():getChildByName("topPanel")
	self._main = self:getView():getChildByName("main")
	self._imageBg = self._main:getChildByName("Imagebg")
	self._surfaceBtn = self._main:getChildByName("surfacebtn")
	self._tipNode = self._main:getChildByName("tipNode")
	self._roleNode = self._main:getChildByName("roleNode")
	self._timeNode = self._main:getChildByName("timeNode")
	self._summerPanel = self._main:getChildByName("summerPanel")
	self._animNode = self._summerPanel:getChildByName("animNode")

	if not self._animNode:getChildByName("shuijingqiu_xiarihuodong") then
		local anim = cc.MovieClip:create("shuijingqiu_xiarihuodong")

		anim:gotoAndPlay(1)
		anim:addTo(self._animNode):center(self._animNode:getContentSize())
		anim:setName("shuijingqiu_xiarihuodong")
	end

	self._taskBtn = self._main:getChildByName("taskBtn")
	self._clubBtn = self._main:getChildByName("clubBtn")
	self._homeBtn = self._main:getChildByName("homeBtn")
	self._imageBgClub = self._clubBtn:getChildByFullName("image_bg")
	self._dayTxt = self._clubBtn:getChildByFullName("image_bg.dayTxt")

	self._dayTxt:setString("")

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 170, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(45, 217, 175, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._clubBtn:getChildByName("clubBtnEn"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 170, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(210, 240, 255, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._clubBtn:getChildByName("clubBtnZh"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
end

function ActivityBlockSummerMediator:setupTopInfoWidget()
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

function ActivityBlockSummerMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local currencyInfo = self._summerActivity:getResourcesBanner()
	local config = {
		hideLine = true,
		style = 1,
		currencyInfo = currencyInfo
	}

	self._topInfoWidget:updateView(config)
	self._topPanel:setContentSize(cc.size(#currencyInfo * 150 + 152, 75))
end

function ActivityBlockSummerMediator:enterWithData(data)
	if data then
		self._resumeName = data.resumeName or nil
	end

	self._activityId = data.activityId
	self._summerActivity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._summerActivity then
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

function ActivityBlockSummerMediator:playBackgroundMusic()
	local bgm = self._summerActivity:getBgm()

	AudioEngine:getInstance():playBackgroundMusic(bgm)
end

function ActivityBlockSummerMediator:resumeWithData()
	self:doReset()
end

function ActivityBlockSummerMediator:initData()
	self._blockActivity = self._summerActivity:getBlockMapActivity()
	self._taskActivities = self._summerActivity:getTaskActivities()
	self._roleIndex = 1
	self._roles = self._summerActivity:getRoleParams()
end

function ActivityBlockSummerMediator:initView()
	self:initInfo()
	self:initTimer()
	self:initRoleTimer()
	self:updateRolePanel()
	self:playBackgroundMusic()
end

function ActivityBlockSummerMediator:initInfo()
	local btns = self._summerActivity:getButtonConfig()
	local tipStr = self._summerActivity:getActivityConfig().SubActivityEndTip

	self._endTip = {}

	local redPoint = self._homeBtn:getChildByName("redPoint")

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

function ActivityBlockSummerMediator:setSummerPanelBtn()
	local blockActivity = self._summerActivity:getBlockMapActivity()
	local remainLabel = self._summerPanel:getChildByName("remainTime")
	local redPoint = self._clubBtn:getChildByName("redPoint")
	local isShow = false

	if blockActivity then
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
		local endTime = TimeUtil:timeByRemoteDate(table)
		local remoteTimestamp = self._activitySystem:getCurrentTime()
		local remainTime = endTime - remoteTimestamp

		if remainTime > 0 then
			isShow = true

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
		else
			remainLabel:setString(Strings:get("Activity_Saga_UI_2"))
		end
	else
		remainLabel:setString(Strings:get("Activity_Saga_UI_2"))
	end

	local limit = ConfigReader:getRecordById("Reset", "AcitvitySummerStamina_Reset").ResetSystem.limit
	local num = self._bagSystem:getAcitvitySummerPower()
	local redPoint = self._summerPanel:getChildByName("redPoint")

	if isShow then
		local var_13_0

		::label_13_0::

		var_13_0 = limit > num and self._blockActivity and self._blockActivity:hasRedPoint() or true
	end

	redPoint:setVisible(var_13_0)
	redPoint:setLocalZOrder(99)
end

function ActivityBlockSummerMediator:setClubBossBtn()
	local isHave, tips = self._summerActivity:getActivityClubBossActivity()
	local redPoint = self._clubBtn:getChildByName("redPoint")

	self._imageBgClub:setVisible(not isHave)

	if not isHave then
		redPoint:setVisible(false)
		self._dayTxt:setString(tips)
	else
		local isShowRed = false

		redPoint:setVisible(isShowRed)
	end
end

function ActivityBlockSummerMediator:initTimer()
	local text = self._timeNode:getChildByName("time")

	text:setString(self._summerActivity:getTimeStr())

	local remainLabel = self._summerPanel:getChildByName("remainTime")

	if self._summerActivity then
		local remoteTimestamp = self._activitySystem:getCurrentTime()
		local timeStamp = self._summerActivity:getTimeFactor()
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

					remainLabel:setString(Strings:get("Activity_Saga_UI_2"))

					return
				end

				self:setClubBossBtn()
				self:setSummerPanelBtn()
			end

			self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

			checkTimeFunc()
		end
	end
end

function ActivityBlockSummerMediator:initRoleTimer()
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

function ActivityBlockSummerMediator:updateRolePanel()
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

function ActivityBlockSummerMediator:doReset()
	self:stopTimer()

	self._summerActivity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._summerActivity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivityBlockSummerMediator:refreshView()
	self:doReset()
end

function ActivityBlockSummerMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivityBlockSummerMediator:onClickStage()
	local blockActivity = self._summerActivity:getBlockMapActivity()

	if not blockActivity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Activity_Saga_UI_2")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Story_Dream", false)
	self._activitySystem:enterSupportStage(self._activityId)
end

function ActivityBlockSummerMediator:onClickRule()
	local rules = self._summerActivity:getActivityConfig().RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivityBlockSummerMediator:onClickTask()
	local activity = self._summerActivity:getTaskActivities()

	if not activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ActivityBlock_UI_8")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local open = false

	for k, task in pairs(activity) do
		if task:getIsTodayOpen() then
			open = true

			break
		end
	end

	if not open then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ActivityBlock_UI_8")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

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

function ActivityBlockSummerMediator:onClickHomeExchange()
	local activity = self._summerActivity:getExchangeActivity()

	if not activity or activity and not activity:getTodayOpen() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ActivityBlock_UI_8")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	self._activitySystem:enterSummerExchange(self._activityId)
end

function ActivityBlockSummerMediator:onClickClub()
	local isHave, tips = self._summerActivity:getActivityClubBossActivity()

	if not isHave then
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local clubSystem = self:getInjector():getInstance(ClubSystem)
	local hasJoinClub = clubSystem:getHasJoinClub()

	if hasJoinClub == false then
		AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)
		clubSystem:tryEnter()
	else
		local unlock, unlockTips = self._systemKeeper:isUnlock("Activity_ClubStage")

		if unlock then
			AudioEngine:getInstance():playEffect("Se_Click_Story_Common", false)
			clubSystem:tryEnter({
				goToActivityBossFormSunmmer = true
			})
		else
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				tip = unlockTips
			}))
		end
	end
end

function ActivityBlockSummerMediator:onClickSurface()
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

function ActivityBlockSummerMediator:onClickLeft()
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

function ActivityBlockSummerMediator:onClickRight()
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

function ActivityBlockSummerMediator:showWinnerView()
	local data = self._summerActivity:getHeroDataById(self._summerActivity:getWinHeroId())

	if data and self._resumeName == nil then
		self._activitySystem:enterSagaWinView(self._activityId)
	end
end

function ActivityBlockSummerMediator:runBtnAnim()
	local leftBtn = self:getView():getChildByFullName("btnPanel.left.leftBtn")
	local rightBtn = self:getView():getChildByFullName("btnPanel.right.rightBtn")

	CommonUtils.runActionEffect(leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
	CommonUtils.runActionEffect(rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true, "zh_zy_jt.png")
end
