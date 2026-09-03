-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityTaskStageStarMediator.lua

ActivityTaskStageStarMediator = class("ActivityTaskStageStarMediator", DmPopupViewMediator, _M)

ActivityTaskStageStarMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityTaskStageStarMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityTaskStageStarMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
ActivityTaskStageStarMediator:has("_rechargeAndVipModel", {
	is = "r"
}):injectWith("RechargeAndVipModel")

local KGetType = {
	recharge = 102,
	normal = 101
}

function ActivityTaskStageStarMediator:initialize()
	super.initialize(self)
end

function ActivityTaskStageStarMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ActivityTaskStageStarMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_ACTIVITY_PAY_SUCC, self, self.paySuccCallBack)
end

function ActivityTaskStageStarMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:initData()
	self:setupView()
end

function ActivityTaskStageStarMediator:initData()
	self._taskList = self._activity:getSortActivityList()
	self._activityConfig = self._activity:getActivityConfig()
	self._deadline = self._activity:getDeadline()
end

function ActivityTaskStageStarMediator:setupView()
	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")

	local buy = self._activity:getPayStatus()

	self._state = nil

	if buy or not self._deadline then
		self._state = 1
		self._cloneCell = self:getView():getChildByName("cloneCell")

		self._cloneCell:setVisible(false)
		self:getView():getChildByName("cloneCell_0"):setVisible(false)
	else
		self._state = 2
		self._cloneCell = self:getView():getChildByName("cloneCell_0")

		self._cloneCell:setVisible(false)
		self:getView():getChildByName("cloneCell"):setVisible(false)
	end

	if self._activityConfig and self._activityConfig.TaskBgUI then
		self._main:getChildByName("Image_18"):loadTexture("asset/scene/" .. self._activityConfig.TaskBgUI .. ".jpg")
	end

	local descPanel = self._main:getChildByName("desc")

	descPanel:setString("")
	descPanel:getVirtualRenderer():setLineSpacing(2)

	local contentText = ccui.RichText:createWithXML("desc", {})

	contentText:renderContent(652, 0)
	contentText:setTouchEnabled(true)
	contentText:setSwallowTouches(false)
	contentText:setWrapMode(1)
	contentText:setAnchorPoint(cc.p(0, 0.5))
	contentText:setPosition(cc.p(0, (getCurrentLanguage() ~= GameLanguageType.CN or nil) and 15))
	contentText:setFontSize(16)
	contentText:addTo(descPanel)

	self._descPanel = contentText
	self._timesTipPanel = self._main:getChildByFullName("timesTipPanel")
	self._rightPanel = self._main:getChildByFullName("panel_right")
	self._buyPanel = self._rightPanel:getChildByFullName("buyDone")
	self._notBuyPanel = self._rightPanel:getChildByFullName("notbuy")

	AdjustUtils.adjustLayoutByType(self._rightPanel, AdjustUtils.kAdjustType.Right)
	self:getView():getChildByFullName("cloneCell.panel_super.title"):setString(Strings:get("ACT_StageStar_Buytitle"))

	local actBtnBuy = self._notBuyPanel:getChildByFullName("actBtnBuy")

	local function callFuncGo(sender, eventType)
		self:goBuy()
	end

	mapButtonHandlerClick(nil, actBtnBuy, {
		func = callFuncGo
	})
	self:updateTopBuyView()
	self:createTableView()
end

function ActivityTaskStageStarMediator:updateTopBuyView()
	local payId = self._activityConfig.payId
	local buy = self._activity:getPayStatus()
	local buyImg = self._rightPanel:getChildByFullName("Image_16")

	self._buyPanel:setVisible(false)
	self._notBuyPanel:setVisible(false)

	local desc = Strings:get("ACT_StageStar_Desc2", {
		fontName = TTF_FONT_FZYH_M
	})

	if buy then
		self._buyPanel:setVisible(true)
		buyImg:loadTexture("starsdream_txt_tq_1.png", ccui.TextureResType.plistType)
	elseif self._deadline then
		buyImg:loadTexture("starsdream_txt_tq_1.png", ccui.TextureResType.plistType)
	else
		buyImg:loadTexture("starsdream_txt_tq_2.png", ccui.TextureResType.plistType)
		self._notBuyPanel:setVisible(true)

		local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)
		local symbol, price = payOffSystem:getPaySymbolAndPrice(payId)
		local symbolS = self._notBuyPanel:getChildByFullName("symbol")
		local moneyS = self._notBuyPanel:getChildByFullName("money")
		local times = self._notBuyPanel:getChildByFullName("times")
		local timeTitle = self._notBuyPanel:getChildByFullName("txt")

		times:setPositionX(timeTitle:getPositionX() + timeTitle:getContentSize().width + 5)
		symbolS:setString(symbol)
		moneyS:setString(price)

		local sysw = symbolS:getContentSize().width
		local mw = moneyS:getContentSize().width

		desc = Strings:get("ACT_StageStar_Desc1", {
			fontName = TTF_FONT_FZYH_M
		})

		self:setTimer()
	end

	self._descPanel:setString(desc)
end

function ActivityTaskStageStarMediator:createTableView()
	local size = self._cloneCell:getContentSize()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local width = winSize.width - 299 - (winSize.width - 1136) / 2 - self._listView:getPositionX()

	self._listView:setContentSize(cc.size(width, self._listView:getContentSize().height))

	local tableView = cc.TableView:create(cc.size(width, 475))

	local function numberOfCells(view)
		return #self._taskList
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return size.width, size.height
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local cloneCell = self._cloneCell:clone()

			cloneCell:setVisible(true)
			cloneCell:addTo(cell):setName("main")
			cloneCell:setPosition(cc.p(0, 0))
		end

		self:updataCell(cell, index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0.5, 0.5))
	tableView:setPosition(cc.p(10, 11))
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:addTo(self._listView)
	tableView:reloadData()
	tableView:setBounceable(false)

	self._tableView = tableView
end

function ActivityTaskStageStarMediator:updataCell(cell, index)
	local mainView = cell:getChildByName("main")
	local data = self._taskList[index]
	local taskValueList = data:getTaskValueList()

	mainView:getChildByName("level"):setString(taskValueList[1].targetValue)

	local name = data:getConfig().Name
	local nameText = mainView:getChildByName("title")

	nameText:setString(Strings:get(name))

	if self._state == 1 then
		self:updateDataPanel(mainView:getChildByName("panel_normal"), data, index - 1, true)
		self:updateDataPanel(mainView:getChildByName("panel_super"), data, index - 1)
	else
		self:updateDataPanel(mainView:getChildByName("panel_normal"), data, index - 1, true)
	end
end

function ActivityTaskStageStarMediator:updateDataPanel(panel, data, cellIndex, isNormal)
	local taskValueList = data:getTaskValueList()

	panel:getChildByFullName("notgot.progressText"):setString("(" .. taskValueList[1].currentValue .. "/" .. taskValueList[1].targetValue .. ")")

	local status = data:getStatus()
	local actBtn = panel:getChildByName("actBtn")
	local recieveImg = panel:getChildByName("recieve")
	local noRecieveStr = panel:getChildByName("notgot")

	actBtn:setVisible(false)
	recieveImg:setVisible(false)
	noRecieveStr:setVisible(false)

	if isNormal then
		local rewardPanel = panel:getChildByName("reward")

		rewardPanel:removeAllChildren()

		local rewards = data:getReward()

		if rewards and rewards.Content then
			for i, rewardData in pairs(rewards.Content) do
				local icon = IconFactory:createRewardIcon(rewardData, {
					isWidget = true
				})

				icon:setAnchorPoint(cc.p(0, 0))
				icon:setScaleNotCascade(0.7)
				icon:addTo(rewardPanel):posite((i - 1) * 66, 0)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
					needDelay = true
				})
			end
		end

		if status == ActivityTaskStatus.kUnfinish then
			noRecieveStr:setVisible(true)
		elseif status == ActivityTaskStatus.kFinishNotGet then
			actBtn:setVisible(true)

			local function callFuncGo(sender, eventType)
				local beganPos = sender:getTouchBeganPosition()
				local endPos = sender:getTouchEndPosition()

				if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
					self:onClickGet(data, cellIndex, KGetType.normal)
				end
			end

			mapButtonHandlerClick(nil, actBtn, {
				func = callFuncGo
			})
		else
			recieveImg:setVisible(true)
		end
	else
		local buttonText = actBtn:getChildByFullName("Text_str")
		local rewardPanel = panel:getChildByName("reward")

		rewardPanel:removeAllChildren()

		local rewards = data:getExtraReward()

		if rewards and rewards.Content then
			for i, rewardData in pairs(rewards.Content) do
				local icon = IconFactory:createRewardIcon(rewardData, {
					isWidget = true
				})

				icon:setAnchorPoint(cc.p(0, 0))
				icon:setScaleNotCascade(0.7)
				icon:addTo(rewardPanel):posite(0 + (i - 1) * 66, 0)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
					needDelay = true
				})
			end
		end

		if status == ActivityTaskStatus.kUnfinish then
			noRecieveStr:setVisible(true)
		else
			local get = self._activity:getRechargeStatus(data:getId())

			if get then
				recieveImg:setVisible(true)
			else
				local buy = self._activity:getPayStatus()

				buttonText:setString((buy or nil) and (Strings:get("ACT_LevelUp_PRIVILEGEReceive") or Strings:get("ACT_LevelUp_ActivationReceive")))
				actBtn:setVisible(true)

				local function callFuncGo(sender, eventType)
					local beganPos = sender:getTouchBeganPosition()
					local endPos = sender:getTouchEndPosition()

					if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
						self:onClickGet(data, cellIndex, KGetType.recharge)
					end
				end

				mapButtonHandlerClick(nil, actBtn, {
					func = callFuncGo
				})
			end
		end
	end
end

function ActivityTaskStageStarMediator:onClickGo(data)
	local url = data:getDestUrl()
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end

function ActivityTaskStageStarMediator:resumeView()
	self._tableView:reloadData()
end

function ActivityTaskStageStarMediator:onClickGet(data, index, activityType)
	local status = data:getStatus()

	if status == ActivityTaskStatus.kUnfinish then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Task_Text1")
		}))

		return
	end

	local doActivityType = KGetType.normal

	if activityType == KGetType.recharge then
		local buy = self._activity:getPayStatus()

		if buy then
			doActivityType = KGetType.recharge
		else
			self:getMonthCard(data)

			return
		end
	end

	local params = {
		doActivityType = doActivityType,
		taskId = data:getId()
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), params, function(response)
		local rewards = response.data.reward

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
		end

		self:initData()
		self._tableView:updateCellAtIndex(index)
	end)
end

function ActivityTaskStageStarMediator:getMonthCard(taskData)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local function func()
		self:goBuy(taskData)
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			func()
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local data = {
		title = Strings:get("ACT_StageStar_Buytitle"),
		title1 = Strings:get("UITitle_EN_Zhimengtequan"),
		content = Strings:get("ACT_StageStar_Buytext"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ActivityTaskStageStarMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function ActivityTaskStageStarMediator:setTimer()
	self:stopTimer()

	if not self._activity then
		return
	end

	local times = self._notBuyPanel:getChildByFullName("times")
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local startTime = self._activity:getStartTime() / 1000
	local buyDays = self._activityConfig.buyDays
	local endMills = startTime + tonumber(buyDays) * 24 * 60 * 60

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()

			local endMills = startTime + tonumber(buyDays) * 24 * 60 * 60

			if endMills <= remoteTimestamp then
				self:stopTimer()
				self:initData()
				self:updateTopBuyView()
				self._tableView:reloadData()

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
	end
end

function ActivityTaskStageStarMediator:goBuy()
	if self._deadline then
		return
	end

	local data = {
		doActivityType = 103
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), data, function(response)
		local rewards = response.data.reward

		if rewards then
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = rewards
			}))
		end

		local payOffSystem = self:getInjector():getInstance(PayOffSystem)

		payOffSystem:payOffToSdk(response.data)
	end)
end

function ActivityTaskStageStarMediator:paySuccCallBack()
	self:initData()
	self:updateTopBuyView()
	self._tableView:reloadData()
end
