-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityMediator.lua

ActivityMediator = class("ActivityMediator", DmAreaViewMediator, _M)

ActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")

function ActivityMediator:initialize()
	super.initialize(self)
end

function ActivityMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._actsPanel = self._main:getChildByName("activityPanel")
	self._listView = self._main:getChildByName("listView")

	self._listView:setScrollBarEnabled(false)

	self._btnCell = self:getView():getChildByFullName("btnCell")

	self._btnCell:getChildByName("Image_2"):ignoreContentAdaptWithSize(true)
	self:baseInitView()
end

function ActivityMediator:baseInitView()
	if not self._hasBaseInitView then
		self:setupTopInfoWidget()
		self:mapEventListeners()

		self._hasBaseInitView = true
	end
end

function ActivityMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_REFRESH, self, self.onActivityRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_REDPOINT_REFRESH, self, self.refreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_ACTIVITY_PAY_SUCC, self, self.updateTabController)
end

function ActivityMediator:resumeWithData(data)
	self:showView()
end

function ActivityMediator:enterWithData(data)
	self:updateView(data)
	self:setupClickEnvs()
end

function ActivityMediator:updateView(data)
	local activityId

	if data and data.id then
		activityId = data.id
	end

	self._tabBtnControl = {}

	local tabBtnControl = {}

	self._activityList, self._activities = self._activitySystem:getActivitiesInActivity()
	self._curTabType = 1

	for k, v in pairs(self._activityList) do
		tabBtnControl[#tabBtnControl + 1] = v:getId()
	end

	self._tabBtnControl = tabBtnControl

	if not activityId then
		for k, v in pairs(self._tabBtnControl) do
			local tempId = v

			if self._activitySystem:hasRedPointForActivity(tempId) then
				activityId = tempId

				break
			end
		end
	end

	for k, v in pairs(self._tabBtnControl) do
		if v == activityId then
			self._curTabType = k

			break
		end
	end

	self:updateTabController()
	self:showView()
end

function ActivityMediator:updateTabController()
	self._listView:removeAllChildren()

	local tabBtns = {}

	for k, v in ipairs(self._tabBtnControl) do
		local activityId = v
		local textdes = ""
		local redPointCal, imageName
		local activity = self._activities[activityId]

		textdes = Strings:get(activity:getTitle())

		function redPointCal()
			return self._activitySystem:hasRedPointForActivity(activityId)
		end

		imageName = activity:getLeftBanner() .. ".png"

		local btn = self._btnCell:clone()

		btn.realTag = k
		btn.activityId = activityId

		local name1Text = btn:getChildByName("name1")
		local name2Text = btn:getChildByName("name2")
		local name3Text = btn:getChildByName("name3")
		local localLanguage = getCurrentLanguage()

		if localLanguage ~= GameLanguageType.CN or utf8.len(textdes) > 4 then
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

		if imageName ~= ".png" then
			btn:getChildByName("image"):loadTexture(imageName, ccui.TextureResType.plistType)
		end

		local node = RedPoint:createDefaultNode()

		btn.redPoint = RedPoint:new(node, btn, redPointCal)

		node:setPosition(100, 100)
		self:setTimeRemain(btn)

		if self._curTabType == k then
			btn:getChildByName("select"):setVisible(true)
			btn:getChildByName("selectDi"):setVisible(true)
			name1Text:setTextColor(cc.c3b(223, 255, 114))
			name2Text:setTextColor(cc.c3b(223, 255, 114))
			btn:getChildByName("Image_2"):loadTexture("hd_btn_xz_wz.png", ccui.TextureResType.plistType)
			btn:setColor(cc.c3b(255, 255, 255))
		else
			btn:getChildByName("select"):setVisible(false)
			btn:getChildByName("selectDi"):setVisible(false)
			name1Text:setTextColor(cc.c3b(255, 255, 255))
			name2Text:setTextColor(cc.c3b(255, 255, 255))
			btn:getChildByName("Image_2"):loadTexture("hd_btn_wxz_wd.png", ccui.TextureResType.plistType)
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

	if self._curTabType > 4 then
		self._listView:jumpToPercentVertical(100)
	else
		self._listView:jumpToPercentVertical(5)
	end

	self:setLocalZOrder()
end

function ActivityMediator:setLocalZOrder()
	for k, v in pairs(self._tabBtns) do
		local zo = self._curTabType == k and 999 or 999 - k

		v:setLocalZOrder(zo)
	end
end

function ActivityMediator:setTimeRemain(btn)
	local timePanel = btn:getChildByName("Image_time")
	local activityId = btn.activityId
	local activity = self._activities[activityId]

	if activity:getUI() == ActivityType.KTASKSTAGESTAR then
		timePanel:setVisible(true)

		local activity = self._activities[activityId]
		local buy = activity:getPayStatus()
		local deadline = activity:getDeadline()

		if deadline or buy then
			self:stopTimer()
			timePanel:setVisible(false)
		else
			self:setTimer(activityId, timePanel)
		end
	else
		timePanel:setVisible(false)
	end
end

function ActivityMediator:setTimer(activityId, timePanel)
	self:stopTimer()

	local activity = self._activities[activityId]

	if not activity then
		timePanel:setVisible(false)

		return
	end

	local activityConfig = activity:getActivityConfig()
	local times = timePanel:getChildByFullName("times")
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local startTime = activity:getStartTime() / 1000
	local buyDays = activityConfig.buyDays
	local endMills = startTime + tonumber(buyDays) * 24 * 60 * 60

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()

			local endMills = startTime + tonumber(buyDays) * 24 * 60 * 60

			if endMills <= remoteTimestamp then
				self:stopTimer()
				timePanel:setVisible(false)

				return
			end

			local fmtStr = "${d}:${H}:${M}:${S}"
			local remainTime = endMills - remoteTimestamp
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			times:setString(timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec"))
		end

		checkTimeFunc()

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	else
		timePanel:setVisible(false)
	end
end

function ActivityMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function ActivityMediator:refreshRedPoint()
	return
end

function ActivityMediator:onActivityRefresh()
	local activityList = self._activitySystem:getActivitiesInActivity()

	if activityList and #activityList > 0 then
		self:updateView({
			id = (self._tabBtnControl and self._curTabType or nil) and self._tabBtnControl[self._curTabType]
		})
	else
		self:dismiss()
	end
end

function ActivityMediator:setupTopInfoWidget()
	local topInfoNode = self._main:getChildByName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		title = Strings:get("Activity_Show_Title"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickClose, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivityMediator:showView()
	local activityId = self._tabBtnControl[self._curTabType]
	local activity = self._activities[activityId]
	local viewName = ActivityUI[activity:getUI()]

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

function ActivityMediator:removeContentView()
	if self._selectView ~= nil then
		self._selectView:removeFromParent()

		self._selectView = nil
	end
end

function ActivityMediator:onClickClose(sender, eventType)
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function ActivityMediator:onClickTab(sender, eventType, tag)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

		local realTag = sender.realTag

		if realTag ~= self._curTabType then
			local oldBtn = self._listView:getItems()[self._curTabType]

			oldBtn:getChildByName("select"):setVisible(false)
			oldBtn:getChildByName("selectDi"):setVisible(false)
			oldBtn:getChildByName("name1"):setTextColor(cc.c3b(255, 255, 255))
			oldBtn:getChildByName("name2"):setTextColor(cc.c3b(255, 255, 255))
			oldBtn:getChildByName("Image_2"):loadTexture("hd_btn_wxz_wd.png", ccui.TextureResType.plistType)
			oldBtn:setColor(cc.c3b(255, 255, 255))
			sender:getChildByName("select"):setVisible(true)
			sender:getChildByName("selectDi"):setVisible(true)
			sender:getChildByName("name1"):setTextColor(cc.c3b(223, 255, 114))
			sender:getChildByName("name2"):setTextColor(cc.c3b(223, 255, 114))
			sender:getChildByName("Image_2"):loadTexture("hd_btn_xz_wz.png", ccui.TextureResType.plistType)
			sender:setColor(cc.c3b(255, 255, 255))

			if #self._tabBtnControl > 4 then
				self._listView:scrollToPercentVertical(100 * (realTag - 1) / (#self._tabBtnControl - 4), 0.2, false)
			end
		end

		self._curTabType = realTag

		self:_onClickTab()
		self:setLocalZOrder()
	end
end

function ActivityMediator:_onClickTab(tag)
	self:showView()
end

function ActivityMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local tabBtns = self._listView:getItems()

		for k, v in pairs(self._tabBtnControl) do
			local env = "ActivityView." .. v

			print("ActivityMediator-env", env)

			local btnNode = tabBtns[k]

			storyDirector:setClickEnv(env, btnNode, function(sender, eventType)
				self:onClickTab(btnNode, ccui.TouchEventType.ended)
			end)
		end

		local button_back = self._topInfoWidget:getView():getChildByFullName("back_btn")

		if button_back then
			storyDirector:setClickEnv("ActivityView.button_back", button_back, function(sender, eventType)
				self:onClickClose(sender, eventType)
			end)
		end

		storyDirector:notifyWaiting("enter_activity_view")
	end))

	self:getView():runAction(sequence)
end
