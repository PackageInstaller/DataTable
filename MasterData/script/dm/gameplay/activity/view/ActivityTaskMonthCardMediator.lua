-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityTaskMonthCardMediator.lua

ActivityTaskMonthCardMediator = class("ActivityTaskMonthCardMediator", DmPopupViewMediator, _M)

ActivityTaskMonthCardMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityTaskMonthCardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityTaskMonthCardMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
ActivityTaskMonthCardMediator:has("_rechargeAndVipModel", {
	is = "r"
}):injectWith("RechargeAndVipModel")

local KGetType = {
	monthcard = 102,
	normal = 101
}

function ActivityTaskMonthCardMediator:initialize()
	super.initialize(self)
end

function ActivityTaskMonthCardMediator:dispose()
	super.dispose(self)
end

function ActivityTaskMonthCardMediator:onRegister()
	super.onRegister(self)
end

function ActivityTaskMonthCardMediator:enterWithData(data)
	self._activity = data.activity
	self._activityUIType = data.activity:getConfig().UI
	self._parentMediator = data.parentMediator

	self:setupView()
end

function ActivityTaskMonthCardMediator:setupView()
	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")
	self._descPanel = self._main:getChildByName("desc")
	self._cloneCell = self:getView():getChildByName("cloneCell")
	self._cloneCell2 = self:getView():getChildByName("cloneCell2")

	self._cloneCell:setVisible(false)

	self._taskList = self._activity:getSortActivityList()

	self._descPanel:setString(Strings:get(self._activity:getDesc()))
	self._descPanel:getVirtualRenderer():setLineSpacing(2)

	local activityConfig = self._activity:getActivityConfig()

	self._main:getChildByFullName("heroPanel.Image_33"):setVisible(not activityConfig.showHero)

	if activityConfig.showHero then
		local heroPanel = self._main:getChildByName("heroPanel")
		local roleModel = IconFactory:getRoleModelByKey("HeroBase", activityConfig.showHero)
		local heroSprite = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe9",
			id = roleModel
		})

		heroSprite:setScale(1.1)
		heroSprite:addTo(heroPanel)
		heroSprite:setPosition(cc.p(275, 90))

		if activityConfig.ModelPos then
			heroSprite:posite(activityConfig.ModelPos[1], activityConfig.ModelPos[2])
		end

		if activityConfig.ModelScale then
			heroSprite:setScale(activityConfig.ModelScale)
		end
	end

	self:createTableView()
end

function ActivityTaskMonthCardMediator:createTableView()
	local size = self._cloneCell:getContentSize()
	local tableView = cc.TableView:create(cc.size(size.width, 350))

	local function numberOfCells(view)
		return #self._taskList
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return size.width, size.height + 5
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local cloneCell = ActivityType.KTASKMONTHCARDSTAGE == self._activityUIType and self._cloneCell2:clone() or self._cloneCell:clone()

			cloneCell:setVisible(true)
			cloneCell:addTo(cell):setName("main")
			cloneCell:setPosition(cc.p(0, 4))

			local actBtn = cloneCell:getChildByName("actBtn")

			actBtn:setSwallowTouches(false)
			actBtn:getChildByName("Text_str"):setAdditionalKerning(4)
			cloneCell:getChildByName("title"):setAdditionalKerning(2)
		end

		self:updataCell(cell, index, self._activityUIType)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
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

function ActivityTaskMonthCardMediator:updataCell(cell, index, uiType)
	local mainView = cell:getChildByName("main")
	local data = self._taskList[index]
	local taskValueList = data:getTaskValueList()

	if ActivityType.KTASKMONTHCARDSTAGE == self._activityUIType then
		local condition = data:getCondition()
		local targetMis = condition[1].params[1]
		local lastMission = self._stageSystem:getLastPassStagePointId(StageType.kNormal)
		local currentValue = 0

		if lastMission then
			local config = ConfigReader:getRecordById("BlockPoint", lastMission)
			local mapId = config.Map
			local subPoints = ConfigReader:getDataByNameIdAndKey("BlockMap", mapId, "SubPoint")

			currentValue = ConfigReader:getDataByNameIdAndKey("BlockMap", mapId, "Order")

			if lastMission ~= subPoints[#subPoints] then
				currentValue = currentValue - 1
			end
		end

		local targetValue = tostring(ConfigReader:getDataByNameIdAndKey("BlockMap", targetMis, "Order"))

		mainView:getChildByName("progressText"):setString("(" .. currentValue .. "/" .. targetValue .. ")")
		mainView:getChildByName("level"):setString(targetValue)
	else
		mainView:getChildByName("progressText"):setString("(" .. taskValueList[1].currentValue .. "/" .. taskValueList[1].targetValue .. ")")
		mainView:getChildByName("level"):setString(taskValueList[1].targetValue)
	end

	local rewardPanel = mainView:getChildByName("reward")

	rewardPanel:removeAllChildren()

	local rewards = data:getReward()

	if rewards and rewards.Content then
		for i, rewardData in pairs(rewards.Content) do
			local icon = IconFactory:createRewardIcon(rewardData, {
				isWidget = true
			})

			icon:setAnchorPoint(cc.p(0, 0))
			icon:setScaleNotCascade(0.5)
			icon:addTo(rewardPanel):posite(-4.5 + (i - 1) * 66, 0)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
				needDelay = true
			})
		end
	end

	local cardRewardPanel = mainView:getChildByName("Panel_CardReward")
	local extraRewardIconPanel = cardRewardPanel:getChildByName("icon")

	extraRewardIconPanel:removeAllChildren()

	local rewards = data:getExtraReward()

	if rewards and rewards.Content then
		for i, rewardData in pairs(rewards.Content) do
			local icon = IconFactory:createRewardIcon(rewardData, {
				isWidget = true
			})

			icon:setAnchorPoint(cc.p(0, 0))
			icon:setScaleNotCascade(0.5)
			icon:addTo(extraRewardIconPanel):posite(0 + (i - 1) * 66, 0)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
				needDelay = true
			})
		end
	end

	local status = data:getStatus()
	local actBtn = mainView:getChildByName("actBtn")

	actBtn:setVisible(false)

	local actBtnGold = mainView:getChildByName("actBtnGold")

	actBtnGold:setVisible(false)

	local recieveImg = mainView:getChildByName("recieve")

	recieveImg:setVisible(false)

	local noRecieveStr = mainView:getChildByName("noRecieveStr")

	noRecieveStr:setVisible(false)
	mainView:getChildByName("progressText"):setVisible(false)

	if status == ActivityTaskStatus.kUnfinish then
		noRecieveStr:setVisible(true)
		mainView:getChildByName("progressText"):setVisible(true)
	elseif status == ActivityTaskStatus.kFinishNotGet then
		actBtn:setVisible(true)

		local function callFuncGo(sender, eventType)
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
				self:onClickGet(data, cell:getIdx(), KGetType.normal)
			end
		end

		mapButtonHandlerClick(nil, actBtn, {
			func = callFuncGo
		})
	else
		local children = rewardPanel:getChildren()

		for i = 1, #children do
			local node = children[i]

			node:setColor(cc.c3b(120, 120, 120))

			local img = ccui.ImageView:create("hd_14r_btn_go.png", 1)

			img:setScale(0.5)
			img:addTo(rewardPanel)
			img:setPosition(cc.p(-42 + i * 66, 28))
		end

		local get = self._activity:getForeverGotStatus(data:getId())

		if get then
			recieveImg:setVisible(true)

			local children = extraRewardIconPanel:getChildren()

			for i = 1, #children do
				local node = children[i]

				node:setColor(cc.c3b(120, 120, 120))

				local img = ccui.ImageView:create("hd_14r_btn_go.png", 1)

				img:setScale(0.5)
				img:addTo(extraRewardIconPanel)
				img:setPosition(cc.p(28 + (i - 1) * 56, 29))
			end
		else
			actBtnGold:setVisible(true)

			local function callFuncGo(sender, eventType)
				local beganPos = sender:getTouchBeganPosition()
				local endPos = sender:getTouchEndPosition()

				if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
					self:onClickGet(data, cell:getIdx(), KGetType.monthcard)
				end
			end

			mapButtonHandlerClick(nil, actBtnGold, {
				func = callFuncGo
			})
		end
	end
end

function ActivityTaskMonthCardMediator:onClickGo(data)
	local url = data:getDestUrl()
	local param = {}

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_OPENURL, {
		url = url,
		extParams = param
	}))
end

function ActivityTaskMonthCardMediator:resumeView()
	self._tableView:reloadData()
end

function ActivityTaskMonthCardMediator:onClickGet(data, index, activityType)
	local status = data:getStatus()

	if status == ActivityTaskStatus.kUnfinish then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Task_Text1")
		}))

		return
	end

	local doActivityType = 101

	if activityType == KGetType.monthcard then
		local buy = self._rechargeAndVipModel:getFCardBuyFlag()

		if buy then
			doActivityType = 102
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

		self._tableView:updateCellAtIndex(index)
	end)
end

function ActivityTaskMonthCardMediator:getMonthCard(taskData)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local function func()
		self:gotoLink(taskData)
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
		title = Strings:get("ACT_LevelUp_BUYPRIVILEGE_Title"),
		title1 = Strings:get("UITitle_EN_Goumaiheijintequan"),
		content = Strings:get("ACT_LevelUp_BUYPRIVILEGE_Desc"),
		sureBtn = {
			text = Strings:get("shop_UI48"),
			text1 = Strings:get("UITitle_EN_Goumai")
		},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ActivityTaskMonthCardMediator:gotoLink(data)
	local activityConfig = self._activity:getActivityConfig()
	local link = activityConfig.url

	if link then
		local context = self:getInjector():instantiate(URLContext)
		local entry, params = UrlEntryManage.resolveUrlWithUserData(link)

		if not entry then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Function_Not_Open")
			}))
		else
			entry:response(context, params)
		end
	end
end
