-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/worldBoss/WorldBossRankMediator.lua

WorldBossRankMediator = class("WorldBossRankMediator", DmPopupViewMediator)

WorldBossRankMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WorldBossRankMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
WorldBossRankMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
WorldBossRankMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kCellHeight = 100
local rankTabData = {
	{
		des1 = "Activity_WorldBoss_Rank_Name1",
		rankType = RankType.KWBVanguard
	},
	{
		des1 = "Activity_WorldBoss_Rank_Name2",
		rankType = RankType.KWBBoss
	}
}
local RankTab = {
	KVanguardRank = 1,
	KBossRank = 2
}
local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickBack"
	}
}

function WorldBossRankMediator:initialize()
	super.initialize(self)
end

function WorldBossRankMediator:dispose()
	super.dispose(self)
end

function WorldBossRankMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)

	local bgNode = self:getView():getChildByFullName("main.bgNode")
	local tempNode = bindWidget(self, bgNode, PopupNormalTabWidget, {
		title = Strings:get("RTPK_PopUpRank_UI01")
	})
end

function WorldBossRankMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityByComplexId(self._activityId)
	self._curTabIdx = data.tab or RankTab.KVanguardRank
	self._selfTagImg = nil
	self._isAskingRank = false

	self:refreshData()
	self:initWidgetInfo()
	self:createTableView()
	self:createTabController()
end

function WorldBossRankMediator:resumeWithData()
	self:onClickTab("", self._curTabIdx)
end

function WorldBossRankMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabpanel = self._mainPanel:getChildByName("tabpanel")
	self._viewPanel = self:getView():getChildByFullName("main.viewPanel")
	self._myselfInfo = self._mainPanel:getChildByFullName("viewPanel.rankMyselfInfo")
	self._tableLayout = self._viewPanel:getChildByName("tableView")
	self._clonePanel = self._viewPanel:getChildByName("rankCellPanel")

	self._clonePanel:setVisible(false)

	self._bossNotOpenPanel = self._mainPanel:getChildByName("bossnotopen")
end

function WorldBossRankMediator:createTabController()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #rankTabData do
		data[#data + 1] = {
			tabText = Strings:get(rankTabData[i].des1)
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 496)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabIdx)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, 4)
	view:setLocalZOrder(1100)
	self._tabBtnWidget:scrollTabPanel(self._curTabIdx)
end

function WorldBossRankMediator:onClickTab(name, tag)
	self._curTabIdx = tag

	self._tableView:stopScroll()

	local function switchTabView()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:refreshData()
		self:refreshView()
	end

	self._rankSystem:cleanUpRankListByType(rankTabData[self._curTabIdx].rankType)

	local var_9_0 = {
		rankStart = 1,
		subId = self._activity:getRankId()
	}

	var_9_0.rankEnd = self:getRankSystem():getRequestRankCountPerTime()
	var_9_0.type = rankTabData[self._curTabIdx].rankType

	local sendData = var_9_0

	self._rankSystem:requestAloneRankData(sendData, switchTabView)

	self._requestNextCount = nil
	self._isAskingRank = false

	self._bossNotOpenPanel:setVisible(false)
	self._mainPanel:getChildByFullName("viewPanel"):setVisible(true)

	if self._curTabIdx == RankTab.KBossRank then
		local isBossOpen = self._activity:isPointCanChallenge(WorldBossPointType.kBoss)

		if not isBossOpen then
			local curTime = self._gameServerAgent:remoteTimestamp()
			local ts = self._activity:getPointOpenTime(WorldBossPointType.kBoss)

			if curTime < ts.startTime then
				self._bossNotOpenPanel:setVisible(true)
				self._mainPanel:getChildByFullName("viewPanel"):setVisible(false)
			end
		end
	end
end

function WorldBossRankMediator:createTableView()
	local scrollLayer = self._mainPanel:getChildByFullName("viewPanel.tableView")
	local viewSize = scrollLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableView()
		end
	end

	local function numberOfCells(view)
		return #self._rankList < 5 and 5 or #self._rankList
	end

	local function cellTouched(table, cell)
		return
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

		cell:setTag(idx)
		self:addRankPanel(cell, index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(scrollLayer)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:setMaxBounceOffset(36)

	self._tableView = tableView
end

function WorldBossRankMediator:addRankPanel(cell, index)
	cell:removeAllChildren()

	local rankCell = self._clonePanel:clone()

	rankCell:setVisible(true)
	rankCell:addTo(cell):posite(0, 0)
	self:refreshCellVisible(rankCell, index)

	local bg1 = rankCell:getChildByName("Image_bg1")
	local bg2 = rankCell:getChildByName("Image_bg2")
	local rankIcon = rankCell:getChildByName("rankIcon")
	local rankIndex = rankCell:getChildByName("rankindex")
	local roleIcon = rankCell:getChildByName("roleIcon")
	local roleName = rankCell:getChildByName("roleName")
	local roleScore = rankCell:getChildByName("hurt")

	rankIcon:ignoreContentAdaptWithSize(true)
	bg1:setVisible(index % 2 == 0)
	bg2:setVisible(index % 2 ~= 0)

	local record = self._rankList[index]

	if record then
		if index <= 3 then
			rankIcon:loadTexture(RankTopImage[index], 1)
		else
			rankIndex:setString(index)
		end

		roleIcon:removeAllChildren()

		local headInfo = {
			clipType = 4,
			id = record:getHeadId(),
			headFrameId = record:getHeadFrame(),
			size = cc.size(93, 94)
		}
		local headIcon, oldIcon = IconFactory:createPlayerIcon(headInfo)

		headIcon:addTo(roleIcon):center(roleIcon:getContentSize()):offset(2, -2)
		headIcon:setScale(0.6)
		oldIcon:setScale(0.5)
		roleName:setString(record:getName())
		roleScore:setString(record:getHurtNum())
	end
end

function WorldBossRankMediator:refreshCellVisible(rankCell, index)
	local rankIcon = rankCell:getChildByName("rankIcon")
	local rankIndex = rankCell:getChildByName("rankindex")
	local roleIcon = rankCell:getChildByName("roleIcon")
	local roleName = rankCell:getChildByName("roleName")
	local roleScore = rankCell:getChildByName("hurt")
	local imgNoRank = rankCell:getChildByName("Image_118")

	imgNoRank:setVisible(false)

	if self._curTabIdx == RankTab.KVanguardRank then
		roleName:setPositionY(36)
	else
		roleName:setPositionY(47)
	end

	local record = self._rankList[index]

	if record then
		if index <= 3 then
			rankIcon:setVisible(true)
			rankIndex:setVisible(false)
		else
			rankIcon:setVisible(false)
			rankIndex:setVisible(true)
		end

		roleIcon:setVisible(true)
		roleName:setVisible(true)
		roleScore:setVisible(true)
	else
		rankIcon:setVisible(false)
		rankIndex:setVisible(false)
		roleIcon:setVisible(false)
		roleName:setVisible(false)
		roleScore:setVisible(false)
		imgNoRank:setVisible(true)
	end
end

function WorldBossRankMediator:touchForTableView()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local offsetY = self._tableView:getContentOffset().y

	if (kMinRefreshHeight < offsetY and viewHeight < self._tableView:getContentSize().height and #self._rankList < self._rankSystem:getRTPKMaxRank() or nil) and true then
		self._isAskingRank = true
		self._requestNextCount = #self._rankList

		self:doRequestNextRank()
	end
end

function WorldBossRankMediator:doRequestNextRank()
	local dataEnough = self:getRankSystem():isServerDataEnough(rankTabData[self._curTabIdx].rankType)

	if dataEnough == true then
		self._tableView:stopScroll()

		local function onRequestRankDataSucc()
			if DisposableObject:isDisposed(self) then
				return
			end

			self:refreshData()
			self:refreshView()
		end

		local rankStart = #self._rankList + 1
		local rankEnd = rankStart + self._rankSystem:getRequestRankCountPerTime() - 1
		local sendData = {
			rankStart = rankStart,
			rankEnd = rankEnd,
			type = rankTabData[self._curTabIdx].rankType,
			subId = self._activity:getRankId()
		}

		self._rankSystem:requestAloneRankData(sendData, onRequestRankDataSucc)
	end
end

function WorldBossRankMediator:refreshData()
	self._rankList = self._rankSystem:getRankListByType(rankTabData[self._curTabIdx].rankType)
end

function WorldBossRankMediator:dailyReset()
	self:close()
end

function WorldBossRankMediator:refreshView()
	self:refreshMyselfInfo()
	self._tableView:stopScroll()
	self._tableView:reloadData()

	if self._requestNextCount then
		local diffCount = #self._rankList - self._requestNextCount
		local offsetY = diffCount == 0 and 0 or -diffCount * kCellHeight + kCellHeight * 1.2

		self._tableView:setContentOffset(cc.p(0, offsetY))

		self._requestNextCount = nil
		self._isAskingRank = false
	end
end

function WorldBossRankMediator:refreshMyselfInfo()
	local rankIndex = self._myselfInfo:getChildByName("rankindex")
	local roleIcon = self._myselfInfo:getChildByName("roleIcon")
	local roleName = self._myselfInfo:getChildByName("roleName")
	local roleFight = self._myselfInfo:getChildByName("hurt")
	local myselfData = self:getRankSystem():getMyselfDataByType(rankTabData[self._curTabIdx].rankType)
	local showData = {}

	if myselfData then
		showData = {
			rank = myselfData:getRank(),
			headId = myselfData:getHeadId(),
			headFrame = myselfData:getHeadFrame(),
			name = myselfData:getName(),
			rid = myselfData:getRid(),
			hurt = myselfData:getHurtNum()
		}
	end

	if showData then
		self._myselfInfo:setVisible(true)

		local rank = showData.rank

		if rank > -1 then
			rankIndex:setString(rank)
			roleFight:setString(showData.hurt)
		else
			rankIndex:setString(Strings:get("RTPK_PopUpRank_UI10"))
			roleFight:setString(Strings:get("RTPK_PopUpRank_UI10"))
		end

		roleIcon:removeAllChildren()

		local headInfo = {
			clipType = 4,
			id = showData.headId,
			headFrameId = showData.headFrame,
			size = cc.size(93, 94)
		}
		local headIcon, oldIcon = IconFactory:createPlayerIcon(headInfo)

		headIcon:addTo(roleIcon):center(roleIcon:getContentSize()):offset(2, -2)
		headIcon:setScale(0.6)
		oldIcon:setScale(0.5)
		roleName:setString(showData.name)
	end
end

function WorldBossRankMediator:onClickBack()
	self:close()
end
