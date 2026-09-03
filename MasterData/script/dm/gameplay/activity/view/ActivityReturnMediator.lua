-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityReturnMediator.lua

ActivityReturnMediator = class("ActivityReturnMediator", DmAreaViewMediator, _M)

ActivityReturnMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local returnActivityUI = {
	Login_Holiday = "ReturnActivityLoginView",
	C_TIMEPURCHASE = "ReturnShopActivityView",
	RETURNCARNIVAL = "ReturnActivityTaskReachedView"
}

function ActivityReturnMediator:initialize()
	super.initialize(self)
end

function ActivityReturnMediator:dispose()
	super.dispose(self)
end

function ActivityReturnMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RETURN_ACTIVITY_REFRESH, self, self.onActivityRefresh)
	self:initUI()
end

function ActivityReturnMediator:mapEventListeners()
	return
end

function ActivityReturnMediator:resumeWithData(data)
	self:initData(data)
	self:setupTimer()
end

function ActivityReturnMediator:enterWithData(data)
	self:initData(data)
	self:setupTopInfoWidget()
	self:setupTimer()
	self:setupBanner()
	self:showView(self._curTabType)
end

function ActivityReturnMediator:initUI()
	self._main = self:getView():getChildByName("main")
	self._actsPanel = self._main:getChildByName("activityPanel")
	self._timeLab = self._main:getChildByFullName("timeLine.timeLab")
	self._btnCell = self:getView():getChildByName("btnCell")
	self._listView = self._main:getChildByFullName("listView")

	self._listView:setScrollBarEnabled(false)
end

function ActivityReturnMediator:initData(data)
	self._activity = self._activitySystem:getActivityByComplexUI(ActivityType.KReturn)
	self._tabBtnControl = self._activity:getActivityConfig().show

	local day = self._activity:getActivityConfig().AfkTime[2]
	local startTime = self._activity:getLastBackFlowTime()
	local localDate = TimeUtil:remoteDate("*t", startTime)

	self._finishTimeTs = localDate.hour < 5 and startTime + day * 24 * 60 * 60 - localDate.hour * 60 * 60 - localDate.min * 60 - localDate.sec - 86400 + 18000 or startTime + day * 24 * 60 * 60 - localDate.hour * 60 * 60 - localDate.min * 60 - localDate.sec + 18000

	if self._curTabType == nil then
		self._curTabType = 1
	end
end

function ActivityReturnMediator:setupTopInfoWidget()
	local topInfoNode = self._main:getChildByName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		title = Strings:get("Activity_Return_Title"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickClose, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivityReturnMediator:onActivityRefresh()
	if not self._activitySystem:isReturnActivityShow() then
		self:dismiss()
	end
end

function ActivityReturnMediator:setupTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	local endTime = self._finishTimeTs

	local function checkTimeFunc()
		if DisposableObject:isDisposed(self) or DisposableObject:isDisposed(self:getView()) then
			if self._timer then
				self._timer:stop()

				self._timer = nil
			end

			return
		end

		local curServerTime = TimeUtil:timeByRemoteDate()

		if endTime - curServerTime <= 0 then
			if self._timer then
				self._timer:stop()

				self._timer = nil
			end

			self._timeLab:setString(Strings:get("Activity_Return_finished"))

			return
		end

		local remainTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", endTime - curServerTime)
		local fmtStr = "${d}:${H}:${M}:${S}"
		local timeStr = TimeUtil:formatTime(fmtStr, endTime - curServerTime)
		local parts = string.split(timeStr, ":", nil, true)
		local timeTab = {}

		timeTab.day = tonumber(parts[1])
		timeTab.hour = tonumber(parts[2])
		timeTab.min = tonumber(parts[3])
		timeTab.sec = tonumber(parts[4])

		self._timeLab:setString(timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec") or timeTab.sec .. Strings:get("TimeUtil_Sec"))
	end

	self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

	checkTimeFunc()
end

function ActivityReturnMediator:setupBanner()
	local tabBtns = {}

	self._listView:removeAllChildren()

	for k, v in ipairs(self._tabBtnControl) do
		local activity = self._activity:getSubActivityById(v)
		local textdes = Strings:get(activity:getTitle())

		local function redPointCal()
			return self._activity:hasRedPointForActivity(v)
		end

		local imageName = activity:getLeftBanner() .. ".png"
		local btn = self._btnCell:clone()

		btn.realTag = k

		local name1Text = btn:getChildByName("name1")
		local name2Text = btn:getChildByName("name2")
		local name3Text = btn:getChildByName("name3")
		local localLanguage = getCurrentLanguage()

		if localLanguage ~= GameLanguageType.CN then
			name3Text:setString(textdes)
			name3Text:setVisible(true)
			name1Text:setVisible(false)
			name2Text:setVisible(false)
		else
			name3Text:setVisible(false)

			local name1Str = utf8.sub(textdes, 1, 2)
			local name2Str = utf8.sub(textdes, 3, 4)

			name1Text:setString(name1Str)
			name2Text:setString(name2Str)
		end

		btn:getChildByName("image"):loadTexture(imageName, ccui.TextureResType.plistType)

		local node = RedPoint:createDefaultNode()

		btn.redPoint = RedPoint:new(node, btn, redPointCal)

		node:setPosition(130, 80)

		if self._curTabType == k then
			btn:getChildByName("select"):setVisible(true)
			btn:getChildByName("selectDi"):setVisible(true)
			name1Text:setTextColor(cc.c3b(223, 255, 114))
			btn:setColor(cc.c3b(255, 255, 255))
		else
			btn:getChildByName("select"):setVisible(false)
			btn:getChildByName("selectDi"):setVisible(false)
			name1Text:setTextColor(cc.c3b(255, 255, 255))
			btn:setColor(cc.c3b(255, 255, 255))
		end

		tabBtns[#tabBtns + 1] = btn

		self._listView:pushBackCustomItem(btn)
	end

	self._tabBtns = tabBtns
	self._tabController = TabController:new(tabBtns, nil, {
		buttonClick = function(sender, eventType, selectTag)
			self:onClickTab(sender, eventType, selectTag)
		end
	})

	self._tabController:selectTabByTag(self._curTabType)
end

function ActivityReturnMediator:onClickTab(sender, eventType, tag)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

		local realTag = sender.realTag

		if realTag ~= self._curTabType then
			local oldBtn = self._listView:getItems()[self._curTabType]

			oldBtn:getChildByName("select"):setVisible(false)
			oldBtn:getChildByName("selectDi"):setVisible(false)
			oldBtn:getChildByName("name1"):setTextColor(cc.c3b(255, 255, 255))
			oldBtn:getChildByName("name2"):setTextColor(cc.c3b(255, 255, 255))
			oldBtn:setColor(cc.c3b(255, 255, 255))
		end

		self:showView(realTag)
	end
end

function ActivityReturnMediator:showView(realTag)
	self._curTabType = realTag

	local activityId = self._tabBtnControl[self._curTabType]
	local activity = self._activity:getSubActivityById(activityId)
	local viewName = returnActivityUI[activity:getUI()]
	local sender = self._listView:getItems()[self._curTabType]

	sender:getChildByName("select"):setVisible(true)
	sender:getChildByName("selectDi"):setVisible(true)
	sender:getChildByName("name1"):setTextColor(cc.c3b(223, 255, 114))
	sender:getChildByName("name2"):setTextColor(cc.c3b(223, 255, 114))
	sender:setColor(cc.c3b(255, 255, 255))

	if viewName then
		self._showActivityId = self._showActivityId or ""

		if self._showActivityId == activityId then
			local mediator = self:getMediatorMap():retrieveMediator(self._selectView)

			if mediator and mediator.resumeView then
				mediator:resumeView()
			end

			return
		end

		local view = self:getInjector():getInstance(viewName)

		if view then
			self._showActivityId = activityId

			self:removeContentView()

			self._selectView = view

			view:addTo(self._actsPanel, 1):center(self._actsPanel:getContentSize())

			local mediator = self:getMediatorMap():retrieveMediator(view)

			if mediator then
				mediator:enterWithData({
					activity = activity,
					parentMediator = self
				})
			end
		end
	end
end

function ActivityReturnMediator:removeContentView()
	if self._selectView ~= nil then
		self._selectView:removeFromParent()

		self._selectView = nil
	end
end

function ActivityReturnMediator:onClickClose(sender, eventType)
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end
