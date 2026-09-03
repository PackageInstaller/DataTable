-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubHallMediator.lua

ClubHallMediator = class("ClubHallMediator", DmAreaViewMediator, _M)

ClubHallMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubHallMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
ClubHallMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubHallMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
ClubHallMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local clubHallNameStr = {
	[ClubHallType.kBasicInfo] = Strings:get("Club_Text118"),
	[ClubHallType.kAudit] = Strings:get("Club_Text120"),
	[ClubHallType.kLog] = Strings:get("Club_Text121"),
	[ClubHallType.kTechnology] = Strings:get("Club_Contribute_UI11"),
	[ClubHallType.kBoss] = Strings:get("Club_Boss_1"),
	[ClubHallType.kActivityBoss] = Strings:get("Club_ActivityBoss_1")
}
local clubHallNameTranslate = {
	[ClubHallType.kBasicInfo] = Strings:get("UITitle_EN_Jieshexinxi"),
	[ClubHallType.kAudit] = Strings:get("UITitle_EN_Shenhe"),
	[ClubHallType.kLog] = Strings:get("UITitle_EN_Rizhi"),
	[ClubHallType.kTechnology] = Strings:get("UITitle_EN_Keyansuo"),
	[ClubHallType.kBoss] = Strings:get("Club_Boss_2"),
	[ClubHallType.kActivityBoss] = Strings:get("Club_ActivityBoss_2")
}
local kViewPath = {
	[ClubHallType.kBasicInfo] = "ClubBasicInfoView",
	[ClubHallType.kAudit] = "ClubAuditView",
	[ClubHallType.kLog] = "ClubLogView",
	[ClubHallType.kTechnology] = "ClubTechnologyView",
	[ClubHallType.kBoss] = "ClubBossView",
	[ClubHallType.kActivityBoss] = "ClubBossView"
}
local clubPermissions = {
	[ClubPosition.kProprieter] = {
		ClubHallType.kBasicInfo,
		ClubHallType.kAudit,
		ClubHallType.kLog,
		ClubHallType.kTechnology,
		ClubHallType.kBoss,
		ClubHallType.kActivityBoss
	},
	[ClubPosition.kDeputyProprieter] = {
		ClubHallType.kBasicInfo,
		ClubHallType.kAudit,
		ClubHallType.kLog,
		ClubHallType.kTechnology,
		ClubHallType.kBoss,
		ClubHallType.kActivityBoss
	},
	[ClubPosition.kElite] = {
		ClubHallType.kBasicInfo,
		ClubHallType.kAudit,
		ClubHallType.kLog,
		ClubHallType.kTechnology,
		ClubHallType.kBoss,
		ClubHallType.kActivityBoss
	},
	[ClubPosition.kMember] = {
		ClubHallType.kBasicInfo,
		ClubHallType.kLog,
		ClubHallType.kTechnology,
		ClubHallType.kBoss,
		ClubHallType.kActivityBoss
	}
}
local kBtnHandlers = {
	["left_panel.btn_recruit"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickRecruit"
	}
}
local askMessageFuncMap = {
	[ClubHallType.kBasicInfo] = function(self, func)
		func()
	end,
	[ClubHallType.kAudit] = function(self, func)
		local clubSystem = self:getInjector():getInstance("ClubSystem")

		clubSystem:getClubInfoOj():setAuditRedPoint(ClubAuditRedPointState.kNo)
		clubSystem:getAuditRecordListOj():cleanUp()
		clubSystem:requestAuditList(1, 20, true, func)
	end,
	[ClubHallType.kLog] = function(self, func)
		local clubSystem = self:getInjector():getInstance("ClubSystem")

		clubSystem:getLogRecordListOj():cleanUp()
		func()
	end,
	[ClubHallType.kTechnology] = function(self, func)
		local clubSystem = self:getInjector():getInstance("ClubSystem")
		local unlock, tips = clubSystem:checkEnabled({
			tab = ClubHallType.kTechnology
		})

		if unlock then
			clubSystem:requestTargetDonationInfo("Club_Contribute", func)
		else
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = tips
			}))
		end
	end,
	[ClubHallType.kBoss] = function(self, func)
		local result, tip = self._systemKeeper:isUnlock("ClubStage")

		if result == true then
			local clubSystem = self:getInjector():getInstance("ClubSystem")

			if self._clubSystem:getClubBossKilled(ClubHallType.kBoss) and self._data and self._data.goToBoss == true then
				if func then
					func()
				end
			else
				clubSystem:requestClubBossInfo(func, true, ClubHallType.kBoss)
			end
		else
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = tip
			}))
		end
	end,
	[ClubHallType.kActivityBoss] = function(self, func)
		local result, tip = self._systemKeeper:isUnlock("ClubStage")

		if result == true then
			local clubSystem = self:getInjector():getInstance("ClubSystem")

			if self._clubSystem:getClubBossKilled(ClubHallType.kActivityBoss) and self._data and self._data.goToActivityBoss == true then
				if func then
					func()
				end
			else
				clubSystem:requestClubBossInfo(func, true, ClubHallType.kActivityBoss)
			end
		else
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = tip
			}))
		end
	end
}

function ClubHallMediator:initialize()
	super.initialize(self)
end

function ClubHallMediator:dispose()
	self._viewClose = true

	self:disposeView()
	super.dispose(self)
end

function ClubHallMediator:disposeView()
	self._viewCache = {}
end

function ClubHallMediator:userInject()
	return
end

function ClubHallMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ClubHallMediator:enterWithData(data)
	self._data = data

	self:initNodes()
	self:createData()
	self:refreshData(data)
	self:refreshView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_REFRESHCLUBINFO_SUCC, self, self.refrshBasicInfo)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_REFRESHCLUBAUDIT_SUCC, self, self.refrshAuditInfo)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_PUSHPOSITIONCHANGE_SUCC, self, self.refrshViewByPosChange)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_CHANGEPOS_SUCC, self, self.refrshViewByPosChange)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_PUSHREDPOINT_SUCC, self, self.refrshViewByPushRedPoint)
end

function ClubHallMediator:refrshViewByPushRedPoint(event)
	if self._viewClose then
		return
	end

	self:refreshAuditList()
	self:refreshRedPoint()
end

function ClubHallMediator:refreshAuditList()
	if self._curTabIndex ~= 3 then
		return
	end

	if askMessageFuncMap[ClubHallType.kAudit] then
		askMessageFuncMap[ClubHallType.kAudit](self, function()
			self:refreshViewByClick(ClubHallType.kAudit)
		end)
	end
end

function ClubHallMediator:refreshRedPoint()
	self._tabBtnWidget:refreshAllRedPoint()
end

function ClubHallMediator:refrshViewByPosChange(event)
	if self._viewClose then
		return
	end

	self._clubSystem:requestClubInfo(function()
		self:refreshData()

		local oldPos = self._selectPosition

		self._selectPosition = ClubHallType.kBasicInfo
		self._curTabIndex = 1

		for i = 1, #self._clubPermissionList do
			if oldPos == self._clubPermissionList[i] then
				self._curTabIndex = i
				self._selectPosition = oldPos

				break
			end
		end

		self:refreshTabPanel()
	end)
end

function ClubHallMediator:refrshBasicInfo(event)
	if self._viewClose then
		return
	end

	self:refreshViewByClick(ClubHallType.kBasicInfo)
end

function ClubHallMediator:refrshAuditInfo(event)
	if self._viewClose then
		return
	end

	self:refreshViewByClick(ClubHallType.kAudit)
end

function ClubHallMediator:createData()
	self._viewCache = {}
	self._player = self._developSystem:getPlayer()
	self._clubInfoOj = self._clubSystem:getClubInfoOj()
end

function ClubHallMediator:refreshData(data)
	self._curPosition = self._clubInfoOj:getPosition()
	self._clubPermissionList = clubPermissions[self._curPosition]
end

function ClubHallMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._viewNode = self._mainPanel:getChildByFullName("viewnode")
	self._leftPanel = self:getView():getChildByFullName("left_panel")
	self._tabPanel = self._leftPanel:getChildByFullName("tab_panel")

	AdjustUtils.adjustLayoutUIByRootNode(self._leftPanel)
	AdjustUtils.adjustLayoutUIByRootNode(self._viewNode)

	self._recruitBtn = self._leftPanel:getChildByFullName("btn_recruit")
	self._recruitBtnText = self._leftPanel:getChildByFullName("btn_recruit.text")

	self._recruitBtnText:setString(Strings:get("TowerRecruitText"))
end

function ClubHallMediator:refreshView()
	self._curTabIndex = 1

	if self._data then
		if self._data.goToBoss == true then
			self._curTabIndex = self:checkOutTabIndexForHallType(ClubHallType.kBoss)
		end

		if self._data.goToActivityBoss == true then
			self._curTabIndex = self:checkOutTabIndexForHallType(ClubHallType.kActivityBoss)
		end

		if self._data.goToActivityBossFormSunmmer == true then
			self._curTabIndex = self:checkOutTabIndexForHallType(ClubHallType.kActivityBoss)
			self._data.goToActivityBossFormSunmmer = false
		end

		local tab = self._data.tab

		if tab and ClubHallType[tab] then
			local unlock = self._clubSystem:checkEnabled({
				tab = ClubHallType[tab]
			})

			if unlock then
				self._curTabIndex = self:checkOutTabIndexForHallType(ClubHallType[tab])
			end
		end
	end

	self:refreshTabPanel()
end

function ClubHallMediator:checkOutTabIndexForHallType(hallType)
	local result = 1

	for k, v in pairs(self._clubPermissionList) do
		if v == hallType then
			result = k

			break
		end
	end

	return result
end

function ClubHallMediator:refreshTabPanel()
	self._tabPanel:removeAllChildren()

	local data = {}

	for i = 1, #self._clubPermissionList do
		local position = self._clubPermissionList[i]
		local nameStr = clubHallNameStr[position]
		local tabBtnData = {
			tabText = nameStr,
			tabTextTranslate = clubHallNameTranslate[position]
		}

		if position == ClubHallType.kAudit then
			function tabBtnData.redPointFunc()
				local redPointState = self._clubSystem:getClubInfoOj():getAuditRedPoint()

				return redPointState == ClubAuditRedPointState.kYes
			end
		end

		if position == ClubHallType.kBoss then
			local result, tip = self._systemKeeper:isUnlock("ClubStage")

			tabBtnData.lock = not result

			function tabBtnData.redPointFunc()
				local redPointState = self._clubSystem:hasHomeRedPoint()

				return redPointState == true
			end
		end

		if position == ClubHallType.kActivityBoss then
			local result, tip = self._systemKeeper:isUnlock("Activity_ClubStage")

			tabBtnData.lock = not result

			function tabBtnData.redPointFunc()
				local redPointState = self._clubSystem:hasHomeActivityRedPoint()

				return redPointState == true
			end
		end

		local canAdd = true

		if position == ClubHallType.kBoss then
			if self._systemKeeper:canShow("ClubStage") == false then
				canAdd = false
			end

			if CommonUtils.GetSwitch("fn_clubBoss") == false then
				canAdd = false
			end
		end

		if (position == ClubHallType.kActivityBoss or nil) and self._clubSystem:checkHaveActivityBoss() then
			data[#data + 1] = tabBtnData
		end
	end

	local config = {}

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 440)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		ignoreBtnShowState = true,
		noCenterBtn = true,
		buttonClick = function(sender, eventType, tag)
			if eventType == ccui.TouchEventType.ended then
				self:onButtonTab(sender, eventType, tag)
			end
		end
	})

	if #data and self._curTabIndex > #data then
		self._curTabIndex = 1
	end

	self._tabBtnWidget:selectTabByTag(self._curTabIndex)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabPanel):posite(0, -3)
	view:setLocalZOrder(1100)
	self:refreshRedPoint()
end

function ClubHallMediator:checkViewCacheEmpty()
	local result = true

	for type, view in pairs(self._viewCache) do
		result = false

		break
	end

	return result
end

function ClubHallMediator:refreshSelectView(viewType)
	local curView = self._viewCache[viewType]

	if not curView or not curView:isVisible() then
		if self:checkViewCacheEmpty() == false then
			AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

			for type, view in pairs(self._viewCache) do
				if view.mediator and (type == ClubHallType.kBoss or type == ClubHallType.kActivityBoss) then
					view.mediator:goToBack()
				end

				view:setVisible(false)
			end
		end

		if not self._viewCache[viewType] then
			local view = self:getInjector():getInstance(kViewPath[viewType])

			if view then
				view:addTo(self._viewNode):center(self._mainPanel:getContentSize())
				view:setLocalZOrder(10)

				local mediator = self:getMediatorMap():retrieveMediator(view)

				if mediator then
					view.mediator = mediator

					if viewType == ClubHallType.kRank then
						mediator:enterWithData({
							index = RankType.kClub
						})

						if mediator._topInfoWidget then
							mediator:releaseObject(mediator._topInfoWidget)

							local view = mediator:getView():getChildByFullName("topinfo_node")

							view:removeFromParent(true)
						end

						if mediator._tabBtnWidget then
							mediator:releaseObject(mediator._tabBtnWidget)

							local view = mediator:getView():getChildByFullName("tab_panel")

							view:removeFromParent(true)
						end
					elseif viewType == ClubHallType.kBoss then
						mediator:setViewType(viewType)
						mediator:enterWithData(self._data)

						if self._data and self._data.goToBoss == true then
							self._data = nil
						end
					elseif viewType == ClubHallType.kActivityBoss then
						mediator:setViewType(viewType)
						mediator:enterWithData(self._data)

						if self._data and self._data.goToActivityBoss == true then
							self._data = nil
						end
					else
						mediator:enterWithData(self)
					end
				end

				self._viewCache[viewType] = view
			end
		end
	end

	local curView = self._viewCache[viewType]

	curView:setVisible(true)

	if viewType == ClubHallType.kTechnology then
		curView.mediator:updateView()
	elseif viewType == ClubHallType.kRank then
		curView.mediator:onClickTab(nil, 3)
	elseif viewType == ClubHallType.kBoss then
		curView.mediator:refreshViewWithAnim(true)
	else
		curView.mediator:refreshView()
	end

	return self._viewCache[viewType]
end

function ClubHallMediator:refreshViewByClick(selectPos)
	self._selectPosition = selectPos

	self:refreshRedPoint()
	self:refreshSelectView(selectPos)
end

function ClubHallMediator:onClickBack(sender, eventType)
	self:dismiss()
	cc.Director:getInstance():getOpenGLView():setIMEKeyboardState(false)
end

function ClubHallMediator:onClickTab(name, tag)
	return
end

function ClubHallMediator:onButtonTab(sender, eventType, tag)
	local position = self._clubPermissionList[tag]

	self._curTabIndex = position

	if position == ClubHallType.kBoss then
		self._clubSystem:resetClubBossTabRed()
	end

	if askMessageFuncMap[position] then
		askMessageFuncMap[position](self, function()
			self:refreshViewByClick(position)
			self._tabBtnWidget:refreshSelectBtn(tag)
		end)
	end
end

function ClubHallMediator:onClickRecruit(sender, eventType)
	local recruitSystem = self:getInjector():getInstance(RecruitSystem)
	local data = {
		recruitType = RecruitPoolType.kClub
	}

	recruitSystem:tryEnter(data)
end
