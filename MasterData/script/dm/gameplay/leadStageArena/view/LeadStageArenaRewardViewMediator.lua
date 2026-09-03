-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/LeadStageArenaRewardViewMediator.lua

LeadStageArenaRewardViewMediator = class("LeadStageArenaRewardViewMediator", DmPopupViewMediator, _M)

LeadStageArenaRewardViewMediator:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")
LeadStageArenaRewardViewMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
LeadStageArenaRewardViewMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")

local rankTabData = {
	{
		Desc2 = "StageArena_EN04",
		Desc1 = "StageArena_TaskName"
	},
	{
		Desc2 = "StageArena_EN05",
		Desc1 = "StageArena_PopUpUI16"
	}
}
local StageArenaRewardType = {
	AllRank = 2,
	CoinAward = 1
}
local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	},
	["main.onekeyNode.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickOnekey"
	}
}

function LeadStageArenaRewardViewMediator:initialize()
	super.initialize(self)
end

function LeadStageArenaRewardViewMediator:dispose()
	super.dispose(self)
end

function LeadStageArenaRewardViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_REFRESHVIEW, self, self.refreshGradeReward)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_REWARD_SUCC, self, self.onGetRewardCallback)

	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		title = Strings:get("StageArena_MainUI07"),
		title1 = Strings:get("EN_RTPK_PopUpReward_UI01")
	})
end

function LeadStageArenaRewardViewMediator:enterWithData(data)
	self._leadStageArena = self._leadStageArenaSystem:getLeadStageArena()
	self._curTabType = data.tab or StageArenaRewardType.CoinAward
	self._allserverRank = -1

	local myselfData = self._rankSystem:getMyselfDataByType(RankType.KStageAreana)

	if myselfData then
		self._allserverRank = myselfData:getRank()
	end

	self:initWidgetInfo()
	self:createTabController()
end

function LeadStageArenaRewardViewMediator:resumeWithData()
	self:onClickTab("", self._curTabType)
end

function LeadStageArenaRewardViewMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabpanel = self._mainPanel:getChildByFullName("tabpanel")
	self._viewPanel = self._mainPanel:getChildByName("viewPanel")
	self._tableViewLayout = self._viewPanel:getChildByFullName("tableView")
	self._rewardCellPanel = self._viewPanel:getChildByName("rewardCellPanel")

	self._rewardCellPanel:setVisible(false)

	self._duanweiCellPanel = self._viewPanel:getChildByName("rankCellPanel")

	self._duanweiCellPanel:setVisible(false)

	self._duanweiTitle = self._viewPanel:getChildByFullName("RankProperty_bg")
	self._rewardTitle = self._viewPanel:getChildByFullName("rewardProperty_bg")
	self._rewardSelfInfo = self._viewPanel:getChildByFullName("rewardMyselfInfo")

	self._rewardTitle:getChildByFullName("property_1"):setString(Strings:get("StageArena_MainUI06"))
	self._rewardTitle:getChildByFullName("property_2"):setString(Strings:get("StageArena_MainUI07"))
	self._duanweiTitle:getChildByFullName("property_1"):setString(Strings:get("StageArena_PopUpUI01"))
	self._duanweiTitle:getChildByFullName("property_2"):setString(Strings:get("StageArena_MainUI07"))

	self._onkeyBtn = self._mainPanel:getChildByFullName("onekeyNode")
end

function LeadStageArenaRewardViewMediator:createTabController()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #rankTabData do
		local tabText = Strings:get(rankTabData[i].Desc1)
		local tabTextTranslate = Strings:get(rankTabData[i].Desc2)

		data[#data + 1] = {
			fontSize = 28,
			noWrap = false,
			tabText = tabText,
			tabTextTranslate = tabTextTranslate,
			redPointFunc = function()
				if i == StageArenaRewardType.CoinAward then
					return self._leadStageArenaSystem:checkRewardRedpoint()
				end

				return false
			end
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 490)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, -5)
	view:setLocalZOrder(1100)
	self._tabBtnWidget:scrollTabPanel(self._curTabType)
end

function LeadStageArenaRewardViewMediator:refreshGradeReward()
	if self._tabBtnWidget then
		self._tabBtnWidget:refreshAllRedPoint()
	end

	self._gradeInfo = self._taskSystem:getTaskListByType(TaskType.kStageArena)

	if self._curTabType == StageArenaRewardType.CoinAward then
		self:refreshAncientCoinView()
	end

	self:setOneKeyVisible()
end

function LeadStageArenaRewardViewMediator:onClickTab(name, tag)
	self._curTabType = tag

	if self._curTabType == StageArenaRewardType.CoinAward then
		self._gradeInfo = self._taskSystem:getTaskListByType(TaskType.kStageArena)

		self:refreshAncientCoinView()
	else
		self:refreshRewardView()
	end

	self:refreshRewardSelfView()
	self:refreshTitlePanel()
	self:setOneKeyVisible()
end

function LeadStageArenaRewardViewMediator:setOneKeyVisible()
	local redpoint = self._onkeyBtn:getChildByFullName("redPoint")

	self._onkeyBtn:setVisible(self._curTabType == StageArenaRewardType.CoinAward)

	local hasRedPoint = self._leadStageArenaSystem:checkRewardRedpoint()

	redpoint:setVisible(hasRedPoint)
	self._onkeyBtn:setGray(not hasRedPoint)
end

function LeadStageArenaRewardViewMediator:refreshTitlePanel()
	self._duanweiTitle:setVisible(self._curTabType == StageArenaRewardType.CoinAward)
	self._rewardTitle:setVisible(self._curTabType ~= StageArenaRewardType.CoinAward)
end

function LeadStageArenaRewardViewMediator:refreshRewardSelfView()
	local textName3 = self._rewardSelfInfo:getChildByFullName("text_1")
	local textName1 = self._rewardSelfInfo:getChildByFullName("text_5")

	if self._allserverRank == -1 then
		textName1:setString(Strings:get("StageArena_PopUpUI11", {
			rank = Strings:get("StageArena_PopUpUI05")
		}))
	else
		textName1:setString(Strings:get("StageArena_PopUpUI11", {
			rank = self._allserverRank
		}))
	end

	local OldCoin = self._leadStageArenaSystem:getOldCoin()

	textName3:setString(Strings:get("StageArena_PopUpUI12", {
		num = OldCoin
	}))
end

function LeadStageArenaRewardViewMediator:refreshAncientCoinView()
	self._tableViewLayout:removeAllChildren()

	local viewSize = self._tableViewLayout:getContentSize()
	local tableView = cc.TableView:create(viewSize)
	local kCellHeight = self._rewardCellPanel:getContentSize().height

	local function numberOfCells(view)
		return #self._gradeInfo
	end

	local function cellSize(table, idx)
		return viewSize.width, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setContentSize(cc.size(viewSize.width, kCellHeight))
		end

		local index = idx + 1

		self:addRankGradePanel(cell, index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._tableViewLayout)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
end

function LeadStageArenaRewardViewMediator:addRankGradePanel(cell, index)
	cell:removeAllChildren()

	local info = self._gradeInfo[index]
	local panel = self._duanweiCellPanel:clone()

	panel:setVisible(true)

	if info then
		panel:addTo(cell):posite(0, 0)

		local bg1 = panel:getChildByName("Image_bg1")
		local bg2 = panel:getChildByName("Image_bg2")
		local scoreTitleText = panel:getChildByName("rankName")
		local rankScore = panel:getChildByName("rankScore")
		local iconPanel = panel:getChildByName("icon")
		local btnGet = panel:getChildByName("rewardFinishBtn")
		local notGetText = panel:getChildByName("ranktext1")
		local recivedText = panel:getChildByName("Image_87")

		bg1:setVisible(index % 2 == 0)
		bg2:setVisible(index % 2 ~= 0)

		local TaskValue = info:getTaskValueList()

		scoreTitleText:setString(Strings:get("StageArena_PopUpUI09"))
		rankScore:setString(TaskValue[1].targetValue)

		local rewards = info:getReward()

		if rewards then
			for i = 1, #rewards do
				local reward = rewards[i]

				if reward then
					local rewardIcon = IconFactory:createRewardIcon(reward, {
						showAmount = true,
						isWidget = true
					})

					rewardIcon:addTo(iconPanel)
					rewardIcon:setScale(0.65)
					rewardIcon:setPosition(cc.p(iconPanel:getContentSize().width / 2 + (i - 1) * 105, iconPanel:getContentSize().height / 2 - 7))
					IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), rewards[i], {
						needDelay = true
					})
				end
			end
		end

		local state = info:getStatus()

		btnGet:setVisible(state == TaskStatus.kFinishNotGet)
		notGetText:setVisible(state == TaskStatus.kUnfinish)
		recivedText:setVisible(state == TaskStatus.kGet)

		if state == TaskStatus.kFinishNotGet then
			btnGet:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					AudioEngine:getInstance():playEffect("Se_Click_Get", false)
					self._taskSystem:requestTaskReward({
						taskId = info:getId()
					})
				end
			end)
		end
	else
		panel:setVisible(false)
	end
end

function LeadStageArenaRewardViewMediator:onGetRewardCallback(event)
	local response = event:getData().response
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = response
	}))
end

function LeadStageArenaRewardViewMediator:refreshRewardView()
	self._tableViewLayout:removeAllChildren()

	local seasonConfig = self._leadStageArenaSystem:getConfig()

	self._rewards = {}

	if self._curTabType == StageArenaRewardType.AllRank then
		if seasonConfig then
			self._rewards = seasonConfig.ServerReward or {}
		end
	end

	local viewSize = self._tableViewLayout:getContentSize()
	local tableView = cc.TableView:create(viewSize)
	local kCellHeight = self._rewardCellPanel:getContentSize().height

	local function numberOfCells(view)
		return #self._rewards
	end

	local function cellSize(table, idx)
		return viewSize.width, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setContentSize(cc.size(viewSize.width, kCellHeight))
		end

		local index = idx + 1
		local rewardId = self._rewards[index]

		self:addRankAwardPanel(cell, rewardId, index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._tableViewLayout)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
end

function LeadStageArenaRewardViewMediator:addRankAwardPanel(cell, rewardId, idx)
	cell:removeAllChildren()

	local reward = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "Reward") or ""
	local rank = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "Rank") or {}
	local score = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "Score") or 0
	local panel = self._rewardCellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local bg1 = panel:getChildByName("Image_bg1")
	local bg2 = panel:getChildByName("Image_bg2")
	local rankNum = panel:getChildByName("rankNum")
	local rankIcon = panel:getChildByName("rankIcon")
	local iconPanel = panel:getChildByName("icon")

	rankIcon:ignoreContentAdaptWithSize(true)
	bg1:setVisible(idx % 2 == 0)
	bg2:setVisible(idx % 2 ~= 0)
	rankIcon:setVisible(false)
	rankNum:setVisible(false)

	local randDes = ""

	if idx <= 3 then
		rankIcon:loadTexture(RankTopImage[idx], 1)
		rankIcon:setVisible(true)
	elseif rank[1] == rank[2] then
		rankNum:setVisible(true)

		randDes = Strings:get("StageArena_PopUpUI17", {
			num = rank[1]
		})

		rankNum:setString(randDes)
	else
		rankNum:setVisible(true)

		randDes = Strings:get("StageArena_PopUpUI17", {
			num = rank[1] .. "-" .. rank[2]
		})

		rankNum:setString(randDes)
	end

	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", reward, "Content") or {}
	local length = #rewards

	for i = 1, length do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			showAmount = true,
			isWidget = true
		})

		icon:addTo(iconPanel)
		icon:setScale(0.65)
		icon:setPosition(cc.p(iconPanel:getContentSize().width / 2 + (i - 1) * 105, iconPanel:getContentSize().height / 2 - 7))
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
	end
end

function LeadStageArenaRewardViewMediator:onClickOnekey()
	local hasRedPoint = self._leadStageArenaSystem:checkRewardRedpoint()

	if not hasRedPoint then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI24")
		}))

		return
	end

	self._taskSystem:requestObtainCoinRewardOneKey({})
end

function LeadStageArenaRewardViewMediator:onClickClose()
	self:close()
end
