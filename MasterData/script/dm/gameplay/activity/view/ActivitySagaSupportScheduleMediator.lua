-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivitySagaSupportScheduleMediator.lua

ActivitySagaSupportScheduleMediator = class("ActivitySagaSupportScheduleMediator", DmAreaViewMediator, _M)

ActivitySagaSupportScheduleMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivitySagaSupportScheduleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivitySagaSupportScheduleMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kBtnHandlers = {
	tipBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	}
}
local herosCount = 2

function ActivitySagaSupportScheduleMediator:initialize()
	super.initialize(self)
end

function ActivitySagaSupportScheduleMediator:dispose()
	self:disposeView()
	super.dispose(self)
end

function ActivitySagaSupportScheduleMediator:disposeView()
	return
end

function ActivitySagaSupportScheduleMediator:onRegister()
	super.onRegister(self)
	self:setupTopInfoWidget()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)

	self._main = self:getView():getChildByName("main")
	self._imageBg = self._main:getChildByName("Imagebg")
	self._titleImage = self._main:getChildByName("titleImage")

	if self._titleImage then
		self._titleImage:ignoreContentAdaptWithSize(true)
	end

	self._schedulePanel = self._main:getChildByName("schedulePanel")
	self._rolePanelClone = self:getView():getChildByName("rolePanelClone")

	self._rolePanelClone:setVisible(false)

	local dataValue = self._rolePanelClone:getChildByFullName("dataValue")
	local sceneValue = self._rolePanelClone:getChildByFullName("sceneValue")

	dataValue:enableOutline(cc.c4b(38, 0, 51, 204), 1)
	sceneValue:enableOutline(cc.c4b(0, 0, 0, 204), 1)
	self._imageBg:loadTexture("asset/scene/zh_bg_baqiang.jpg")

	self._timeNode = self._main:getChildByName("timeNode")
end

function ActivitySagaSupportScheduleMediator:setupTopInfoWidget()
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

function ActivitySagaSupportScheduleMediator:updateInfoWidget()
	if not self._topInfoWidget then
		return
	end

	local config = {
		style = 1,
		currencyInfo = self._activity:getResourcesBanner(),
		title = Strings:get("Activity_Saga_UI_26")
	}

	self._topInfoWidget:updateView(config)
end

function ActivitySagaSupportScheduleMediator:enterWithData(data)
	self._activityId = data.activityId or ActivityId.kActivityBlockZuoHe
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_12806")
		}))

		return
	end

	self._ui = self._activity:getUI()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:updateInfoWidget()
	self:initData()
	self:initView()
	self:updateViewByActivity()
end

function ActivitySagaSupportScheduleMediator:updateViewByActivity()
	local var_8_0 = {
		style = 1,
		currencyInfo = self._activity:getResourcesBanner(),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}

	if self._activityId == ActivityId.kActivityWxh then
		var_8_0.title = Strings:get("Activity_Saga_UI_26_wxh") or Strings:get("Activity_Saga_UI_26")
	end

	local config = var_8_0

	self._topInfoWidget:updateView(config)
end

function ActivitySagaSupportScheduleMediator:resumeWithData()
	self:doReset()
end

function ActivitySagaSupportScheduleMediator:refreshView()
	self:doReset()
end

function ActivitySagaSupportScheduleMediator:doReset()
	self:disposeView()

	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)

	if not self._activity then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return
	end

	self:initData()
	self:initView()
end

function ActivitySagaSupportScheduleMediator:initData()
	self._config = self._activity:getActivityConfig()
	self._periodsInfo = self._activity:getPeriodsInfo()
	self._periods = self._periodsInfo.periods
	self._periodId = self._periodsInfo.periodId
end

function ActivitySagaSupportScheduleMediator:initView()
	local bg = self._activityId == ActivityId.kActivityWxh and "asset/scene/wxh_yhsc_bj.jpg" or "asset/scene/zh_bg_baqiang.jpg"

	self._imageBg:loadTexture(bg)

	if self._titleImage then
		self._titleImage:loadTexture(self._activity:getTitlePath(), 1)
	end

	self._timeNode:getChildByName("time"):setString(Strings:get("Activity_Saga_UI_25", {
		nums = self._activity:getTimeStr()
	}))
	self:updateView()
	self:playBackgroundMusic()
end

function ActivitySagaSupportScheduleMediator:playBackgroundMusic()
	local bgm = self._activity:getBgm()

	if bgm then
		AudioEngine:getInstance():playBackgroundMusic(bgm)
	end
end

function ActivitySagaSupportScheduleMediator:updateView()
	for scheduleId, periodData in pairs(self._periods) do
		local checkBtn = self._schedulePanel:getChildByFullName(self:getViewScheduleId(periodData.periodId) .. "_3.checkBtnClone")

		local function callFunc()
			self:onClickCheckBtn(scheduleId)
		end

		mapButtonHandlerClick(nil, checkBtn, {
			clickAudio = "Se_Click_Select_1",
			func = callFunc
		})

		local info = self._activity:getSupportCurPeriodData(periodData.periodId)
		local count = 1

		for heroId, index in pairs(periodData.heros) do
			self:updateCell({
				periodData = info,
				heroId = heroId,
				index = index
			})

			count = count + 1
		end

		if count <= herosCount then
			for i = count, herosCount - #periodData.heros do
				self:updateCell({
					periodData = info,
					index = i
				})
			end
		end
	end

	self:updateCell({
		championHeroId = self._activity:getWinHeroId()
	})
end

function ActivitySagaSupportScheduleMediator:updateCell(data)
	local index = data.index
	local node = self._rolePanelClone:clone()

	node:setVisible(true)
	node:setAnchorPoint(0.5, 0.5)
	node:setPosition(cc.p(0, 0))

	local dataBg = node:getChildByFullName("dataBg")
	local dataValue = node:getChildByFullName("dataValue")
	local sceneBg = node:getChildByFullName("sceneBg")
	local sceneValue = node:getChildByFullName("sceneValue")
	local loseImg = node:getChildByFullName("loseImg")
	local empty = node:getChildByFullName("empty")
	local bg = node:getChildByFullName("bg")
	local rolePanel = node:getChildByFullName("rolePanel")
	local guang = node:getChildByFullName("guang")

	loseImg:setVisible(false)
	dataBg:setVisible(false)
	dataValue:setVisible(false)
	sceneBg:setVisible(false)
	sceneValue:setVisible(false)
	guang:setVisible(false)
	bg:setScale(0.6)
	empty:setScale(0.6)
	rolePanel:removeAllChildren(true)

	local championHeroId = data.championHeroId
	local heroId = championHeroId or data.heroId
	local heroData = self._activity:getHeroDataById(heroId)
	local heroImg

	if heroData then
		local d = {
			id = heroData.ModelId
		}

		heroImg = IconFactory:createRoleIconSpriteNew(d)

		heroImg:setScale(0.6)
		heroImg:addTo(rolePanel):posite(50, 45)
	end

	local function setStartTime(periodId)
		local dd = self._activity:getPeriodStartTime(periodId, index, self._activityId)

		if not dd then
			return
		end

		dataBg:setVisible(true)
		dataValue:setVisible(true)

		if periodId ~= "winner" then
			sceneBg:setVisible(true)
			sceneValue:setVisible(true)
		end

		local tb = TimeUtil:localDate("*t", dd.startTime * 0.001)

		dataValue:setString(Strings:get("Activity_Saga_UI_27") .. string.format("%d/%02d/%02d", tb.year, tb.month, tb.day))
		sceneValue:setString(dd.name)
	end

	if championHeroId then
		node:addTo(self._schedulePanel:getChildByFullName("winner"))
		setStartTime("winner")
		guang:setVisible(true)
		guang:setScale(0.6)
		dataBg:setPositionY(141.54)
		dataValue:setPositionY(142.08)
		dataValue:setColor(cc.c4b(255, 250, 124, 255))
		dataValue:enableOutline(cc.c4b(125, 43, 11, 229.5), 1)

		return
	end

	local periodData = data.periodData
	local data = periodData.data
	local config = periodData.config

	setStartTime(data.periodId)
	node:addTo(self._schedulePanel:getChildByFullName(self:getViewScheduleId(data.periodId) .. "_" .. index))

	if config.Type == ActivitySupportScheduleType.preliminaries then
		bg:setScale(0.45)
		empty:setScale(0.45)

		if heroImg then
			heroImg:setScale(0.45)
		end
	elseif config.Type == ActivitySupportScheduleType.rematch then
		bg:setScale(0.5)
		empty:setScale(0.5)

		if heroImg then
			heroImg:setScale(0.5)
		end

		dataBg:setPositionY(129.54)
		dataValue:setPositionY(130.08)
	elseif config.Type == ActivitySupportScheduleType.finals then
		bg:setScale(0.55)
		empty:setScale(0.55)

		if heroImg then
			heroImg:setScale(0.55)
		end

		dataBg:setPositionY(133.54)
		dataValue:setPositionY(134.08)
	end

	if heroData and data.status == ActivitySupportStatus.Ended and heroId ~= data.winHeroId then
		loseImg:setVisible(true)
		heroImg:setColor(cc.c3b(180, 180, 180))
	end

	if heroData and data.status == ActivitySupportStatus.Ended and heroId == data.winHeroId then
		local v = self._schedulePanel:getChildByFullName(self:getViewScheduleId(data.periodId) .. "_3")

		v:getChildByFullName("checkBtnClone.line" .. index):loadTexture("hd_contest__yellowline02.png", 1)
		v:getChildByFullName("checkBtnClone.line3"):loadTexture("hd_contest__yellowline.png", 1)
	end
end

function ActivitySagaSupportScheduleMediator:onClickCheckBtn(_scheduleId)
	local view = self:getInjector():getInstance("ActivitySagaSupportRankView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		periodId = _scheduleId,
		activityId = self._activityId
	}))
end

function ActivitySagaSupportScheduleMediator:onClickRule()
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._activity:getActivityConfig().RuleDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivitySagaSupportScheduleMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ActivitySagaSupportScheduleMediator:getViewScheduleId(periodId)
	return string.gsub(periodId, ActivitySupportScheduleId[self._ui], "schedule")
end
