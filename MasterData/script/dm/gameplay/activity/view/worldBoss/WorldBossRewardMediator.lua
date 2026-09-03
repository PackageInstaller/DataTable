-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/worldBoss/WorldBossRewardMediator.lua

WorldBossRewardMediator = class("WorldBossRewardMediator", DmPopupViewMediator, _M)

WorldBossRewardMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local RewardTabData = {
	{
		Desc1 = "Activity_WorldBoss_Reward_Name1"
	},
	{
		Desc1 = "Activity_WorldBoss_Reward_Name2"
	}
}
local RewardType = {
	KHurtReward = 1,
	KChallengeReward = 2
}
local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	},
	["main.onekeyNode.btn"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickOneKeyReward"
	}
}

function WorldBossRewardMediator:initialize()
	super.initialize(self)
end

function WorldBossRewardMediator:dispose()
	super.dispose(self)
end

function WorldBossRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		title = Strings:get("RTPK_PopUpReward_UI01"),
		title1 = Strings:get("EN_RTPK_PopUpReward_UI01"),
		titleDimensions = {
			180,
			85
		}
	})
end

function WorldBossRewardMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)
	self._curTabType = data.tabType or RewardType.KHurtReward

	self:initWidgetInfo()
	self:createTabController()
end

function WorldBossRewardMediator:resumeWithData()
	self:onClickTab("", self._curTabType)
end

function WorldBossRewardMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabpanel = self._mainPanel:getChildByFullName("tabpanel")
	self._viewPanel = self._mainPanel:getChildByName("viewPanel")
	self._tableViewLayout = self._viewPanel:getChildByFullName("tableView")
	self._rewardCellPanel = self._viewPanel:getChildByName("rewardCellPanel")

	self._rewardCellPanel:setVisible(false)

	self._taskCellPanel = self._viewPanel:getChildByName("taskCellPanel")

	self._taskCellPanel:setVisible(false)

	self._rewardTitle = self._viewPanel:getChildByFullName("property_bg")
	self._rewardSelfInfo = self._viewPanel:getChildByFullName("rewardMyselfInfo")

	self._rewardTitle:getChildByFullName("property_1"):setString(Strings:get("rank2"))
	self._rewardTitle:getChildByFullName("property_2"):setString(Strings:get("RTPK_PopUpReward_UI12"))
end

function WorldBossRewardMediator:createTabController()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #RewardTabData do
		local tabText = Strings:get(RewardTabData[i].Desc1)
		local tabTextTranslate = Strings:get(RewardTabData[i].Desc2)

		data[#data + 1] = {
			fontSize = 24,
			noWrap = true,
			tabText = tabText,
			tabTextTranslate = tabTextTranslate,
			redPointFunc = function()
				if i == RewardType.KHurtReward then
					return self._activity:hasRewardToGet()
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

function WorldBossRewardMediator:setOneKeyButtonStatus()
	local onekeyBtn = self._mainPanel:getChildByName("onekeyNode")

	onekeyBtn:setGray(not self._activity:hasRewardToGet())
	onekeyBtn:setVisible(self._curTabType == RewardType.KHurtReward)
end

function WorldBossRewardMediator:refreshData()
	if self._curTabType == RewardType.KHurtReward then
		self._dataList = self._activity:getSortActivityList()
	elseif self._curTabType == RewardType.KChallengeReward then
		self._dataList = self._activity:getRankReward()
	end
end

function WorldBossRewardMediator:onClickTab(name, tag)
	self._curTabType = tag

	self:refreshData()
	self:refreshTableView()
	self:refreshRewardSelfView()
	self:refreshTitlePanel()
	self:setOneKeyButtonStatus()
end

function WorldBossRewardMediator:refreshTitlePanel()
	if self._curTabType == RewardType.KHurtReward then
		self._rewardTitle:getChildByName("property_2"):setPositionX(460)
	else
		self._rewardTitle:getChildByName("property_2"):setPositionX(346)
	end
end

function WorldBossRewardMediator:refreshRewardSelfView()
	local textName1 = self._rewardSelfInfo:getChildByFullName("text_1")
	local myRank = self._activity:getBossRank()

	if self._curTabType == RewardType.KChallengeReward then
		if myRank == -1 then
			textName1:setString(Strings:get("ClassArena_UI65", {
				Num = Strings:get("RTPK_PopUpRank_UI10")
			}))
		else
			textName1:setString(Strings:get("ClassArena_UI65", {
				Num = myRank
			}))
		end
	else
		textName1:setString(Strings:get("Activity_WorldBoss_Rank_Mine", {
			Num = self._activity:getTotalVanguardHurt()
		}))
	end
end

function WorldBossRewardMediator:refreshTableView()
	if self._tableView then
		self._tableView:reloadData()
	else
		self._tableViewLayout:removeAllChildren()

		local viewSize = self._tableViewLayout:getContentSize()
		local tableView = cc.TableView:create(viewSize)
		local kCellHeight = self._rewardCellPanel:getContentSize().height

		local function numberOfCells(view)
			return #self._dataList
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

			self:addCellPanel(cell, index)

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

		self._tableView = tableView
	end
end

function WorldBossRewardMediator:addCellPanel(cell, index)
	if self._curTabType == RewardType.KHurtReward then
		self:addHurtRewardPanel(cell, index)
	elseif self._curTabType == RewardType.KChallengeReward then
		self:addChallengeRewardPanel(cell, index)
	end
end

function WorldBossRewardMediator:addHurtRewardPanel(cell, index)
	cell:removeAllChildren()

	local data = self._dataList[index]
	local panel = self._taskCellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local bg1 = panel:getChildByName("Image_bg1")
	local bg2 = panel:getChildByName("Image_bg2")

	bg1:setVisible(index % 2 == 0)
	bg2:setVisible(index % 2 ~= 0)

	local hurtText = panel:getChildByName("hurtText")
	local conditionkeeper = self:getInjector():getInstance(Conditionkeeper)
	local str = conditionkeeper:getConditionDesc(data:getCondition()[1], data:getDesc())

	hurtText:setString(str)

	local iconPanel = panel:getChildByName("icon")
	local rewardList = data:getReward().Content

	iconPanel:removeAllChildren()

	for i, reward in pairs(rewardList) do
		local icon = IconFactory:createRewardIcon(reward, {
			showAmount = true,
			isWidget = true
		})

		icon:addTo(iconPanel)
		icon:setScale(0.65)
		icon:setPosition(cc.p(iconPanel:getContentSize().width / 2 + (i - 1) * 105, iconPanel:getContentSize().height / 2 - 7))
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
			needDelay = true
		})
	end

	local status = data:getStatus()
	local getImg = panel:getChildByName("Image_get")
	local unFinish = panel:getChildByName("unfinishBtn")
	local getBtn = panel:getChildByName("rewardFinishBtn")

	getImg:setVisible(status == TaskStatus.kGet)
	getBtn:setVisible(status == TaskStatus.kFinishNotGet)
	unFinish:setVisible(status == TaskStatus.kUnfinish)
	dump(Strings:get("RTPK_PopUpReward_UI07"), "RTPK_PopUpReward_UI07")

	local function callFunc(sender, eventType)
		self:onGetTaskRewardClicked(data)
	end

	mapButtonHandlerClick(nil, getBtn, {
		func = callFunc
	})
end

function WorldBossRewardMediator:addChallengeRewardPanel(cell, index)
	cell:removeAllChildren()

	local info = self._dataList[index]
	local panel = self._rewardCellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local bg1 = panel:getChildByName("Image_bg1")
	local bg2 = panel:getChildByName("Image_bg2")

	bg1:setVisible(index % 2 == 0)
	bg2:setVisible(index % 2 ~= 0)

	local rankNum = panel:getChildByName("rankNum")
	local rankIcon = panel:getChildByName("rankIcon")

	rankIcon:ignoreContentAdaptWithSize(true)
	rankIcon:setVisible(false)
	rankNum:setVisible(false)
	rankNum:setFontSize(20)

	local rank = ConfigReader:getDataByNameIdAndKey("RankReward", info, "Rank") or {}
	local randDes

	if rank[1] == rank[2] and rank[1] <= 3 then
		rankIcon:loadTexture(RankTopImage[index], 1)
		rankIcon:setVisible(true)
	elseif rank[1] == rank[2] then
		rankNum:setVisible(true)

		randDes = Strings:get("RTPK_PopUpReward_UI15", {
			num = rank[1]
		})

		rankNum:setString(randDes)
	else
		rankNum:setVisible(true)

		randDes = Strings:get("RTPK_PopUpReward_UI15", {
			num = rank[1] .. "-" .. rank[2]
		})

		rankNum:setString(randDes)
	end

	local iconPanel = panel:getChildByName("icon")
	local reward = ConfigReader:getDataByNameIdAndKey("RankReward", info, "Reward") or ""
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

function WorldBossRewardMediator:onClickClose()
	self:close()
end

function WorldBossRewardMediator:onGetTaskRewardClicked(data)
	local params = {
		doActivityType = 104,
		oneKey = 0,
		taskId = data:getId()
	}

	self._activitySystem:requestDoActivity(self._activityId, params, function(response)
		if not checkDependInstance(self) then
			return
		end

		self:refreshData()
		self._tableView:reloadData()
		self:setOneKeyButtonStatus()

		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			rewards = response.data.reward
		}))
	end)
end

function WorldBossRewardMediator:onClickOneKeyReward()
	if not self._activity:hasRewardToGet() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Task_Receive_All_Tips")
		}))

		return
	end

	local params = {
		doActivityType = 104,
		oneKey = 1,
		taskId = ""
	}

	self._activitySystem:requestDoActivity(self._activityId, params, function(response)
		if not checkDependInstance(self) then
			return
		end

		self:refreshData()
		self._tableView:reloadData()
		self:setOneKeyButtonStatus()

		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			rewards = response.data.reward
		}))
	end)
end
