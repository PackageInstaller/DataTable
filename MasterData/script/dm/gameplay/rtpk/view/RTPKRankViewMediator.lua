-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpk/view/RTPKRankViewMediator.lua

RTPKRankViewMediator = class("RTPKRankViewMediator", DmPopupViewMediator)

RTPKRankViewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
RTPKRankViewMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
RTPKRankViewMediator:has("_rTPKSystem", {
	is = "r"
}):injectWith("RTPKSystem")
RTPKRankViewMediator:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")

local kCellHeight = 100
local rankTabData = {
	{
		des2 = "EN_RTPK_PopUpRank_UI08",
		des1 = "RTPK_PopUpRank_UI08"
	},
	{
		des2 = "EN_RTPK_PopUpRank_UI07",
		des1 = "RTPK_PopUpRank_UI07"
	}
}
local SeverRankTab = {
	KAllServerRank = 2,
	KServerRank = 1
}
local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickBack"
	}
}

function RTPKRankViewMediator:initialize()
	super.initialize(self)
end

function RTPKRankViewMediator:dispose()
	super.dispose(self)
end

function RTPKRankViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)

	local bgNode = self:getView():getChildByFullName("main.bgNode")
	local tempNode = bindWidget(self, bgNode, PopupNormalTabWidget, {
		title = Strings:get("RTPK_PopUpRank_UI01"),
		title1 = Strings:get("EN_RTPK_PopUpRank_UI01")
	})
end

function RTPKRankViewMediator:enterWithData(data)
	self._serverRank = -1
	self._allserverRank = -1
	self._curTabIdx = data.tab or SeverRankTab.KAllServerRank
	self._selfTagImg = nil
	self._isAskingRank = false

	self:refreshData()
	self:initWigetInfo()
	self:createTableView()
	self:createTabController()
end

function RTPKRankViewMediator:resumeWithData()
	self:onClickTab("", self._curTabIdx)
end

function RTPKRankViewMediator:initWigetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._tabpanel = self._mainPanel:getChildByName("tabpanel")
	self._viewPanel = self:getView():getChildByFullName("main.viewPanel")
	self._myselfInfo = self._mainPanel:getChildByFullName("viewPanel.rankMyselfInfo")
	self._tableLayout = self._viewPanel:getChildByName("tableView")
	self._clonePanel = self._viewPanel:getChildByName("rankCellPanel")

	self._clonePanel:setVisible(false)
end

function RTPKRankViewMediator:createTabController()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #rankTabData do
		data[#data + 1] = {
			tabText = Strings:get(rankTabData[i].des1),
			tabTextTranslate = Strings:get(rankTabData[i].des2)
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

function RTPKRankViewMediator:onClickTab(name, tag)
	self._curTabIdx = tag

	self._tableView:stopScroll()

	local function switchTabView()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:refreshData()
		self:refreshView()
	end

	self._rankSystem:cleanUpRankListByType(RankType.KRTPK)

	local var_9_0 = {
		rankStart = 1
	}

	var_9_0.rankEnd = self:getRankSystem():getRequestRankCountPerTime()
	var_9_0.subId = self._curTabIdx

	local sendData = var_9_0

	self:requestRankData(sendData, switchTabView)

	self._requestNextCount = nil
	self._isAskingRank = false
end

function RTPKRankViewMediator:createTableView()
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

function RTPKRankViewMediator:addRankPanel(cell, index)
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
	local roleServer = rankCell:getChildByName("roleServer")
	local roleFight = rankCell:getChildByName("rolefight")
	local roleScore = rankCell:getChildByName("rankScore")
	local roleGradeIcon = rankCell:getChildByName("gradeIcon")

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

		if roleServer:isVisible() then
			local idStr = string.split(record:getRid(), "_")[2]
			local serverInfo = self._loginSystem:getLogin():getServerBySec(idStr)
			local s = Strings:get("RTPK_Record_UI01", {
				serverId = idStr,
				serverName = serverInfo:getName()
			})

			roleServer:setString(s)
		end

		roleFight:setString(record:getCombat())
		roleScore:setString(record:getScore())

		local info = self._rTPKSystem:getGradeByScore(record:getScore())

		roleGradeIcon:removeAllChildren()

		local icon = IconFactory:createRTPKGradeIcon(info.Id, {
			hideName = true
		})

		icon:setScale(0.25)
		icon:addTo(roleGradeIcon):offset(25, 25)
	end
end

function RTPKRankViewMediator:refreshCellVisible(rankCell, index)
	local rankIcon = rankCell:getChildByName("rankIcon")
	local rankIndex = rankCell:getChildByName("rankindex")
	local roleIcon = rankCell:getChildByName("roleIcon")
	local roleName = rankCell:getChildByName("roleName")
	local roleServer = rankCell:getChildByName("roleServer")
	local roleFight = rankCell:getChildByName("rolefight")
	local roleScore = rankCell:getChildByName("rankScore")
	local roleGradeIcon = rankCell:getChildByName("gradeIcon")
	local imgNoRank = rankCell:getChildByName("Image_118")

	imgNoRank:setVisible(false)
	roleServer:setVisible(false)

	if self._curTabIdx == SeverRankTab.KServerRank then
		roleName:setPositionY(36)
	else
		roleName:setPositionY(47)
		roleServer:setVisible(true)
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
		roleFight:setVisible(true)
		roleGradeIcon:setVisible(true)
	else
		rankIcon:setVisible(false)
		rankIndex:setVisible(false)
		roleIcon:setVisible(false)
		roleName:setVisible(false)
		roleServer:setVisible(false)
		roleScore:setVisible(false)
		roleFight:setVisible(false)
		roleGradeIcon:setVisible(false)
		imgNoRank:setVisible(true)
	end
end

function RTPKRankViewMediator:onClickRankCell(cell)
	return
end

function RTPKRankViewMediator:touchForTableView()
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

function RTPKRankViewMediator:doRequestNextRank()
	local dataEnough = self:getRankSystem():isServerDataEnough(RankType.KRTPK)

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
			subId = self._curTabIdx
		}

		self:requestRankData(sendData, onRequestRankDataSucc)
	end
end

function RTPKRankViewMediator:refreshData()
	self._rankList = self._rankSystem:getRankListByType(RankType.KRTPK)
end

function RTPKRankViewMediator:dailyReset()
	self:close()
end

function RTPKRankViewMediator:refreshView()
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

function RTPKRankViewMediator:refreshMyselfInfo()
	local rankIndex = self._myselfInfo:getChildByName("rankindex_0")
	local roleIcon = self._myselfInfo:getChildByName("roleIcon_0")
	local roleName = self._myselfInfo:getChildByName("roleName_0")
	local roleServer = self._myselfInfo:getChildByName("roleServer_0")
	local roleFight = self._myselfInfo:getChildByName("rolefight_0")
	local roleScore = self._myselfInfo:getChildByName("rankScore_0")
	local roleGradeIcon = self._myselfInfo:getChildByName("gradeIcon_0")
	local rankText = self._myselfInfo:getChildByName("ranktext")

	roleServer:setVisible(false)

	if self._curTabIdx == SeverRankTab.KServerRank then
		roleName:setPositionY(25)
	else
		roleName:setPositionY(35)
		roleServer:setVisible(true)
	end

	local myselfData = self:getRankSystem():getMyselfDataByType(RankType.KRTPK)
	local showData = {}

	if myselfData then
		showData = {
			rank = myselfData:getRank(),
			headId = myselfData:getHeadId(),
			headFrame = myselfData:getHeadFrame(),
			name = myselfData:getName(),
			rid = myselfData:getRid(),
			combat = myselfData:getCombat(),
			score = myselfData:getScore()
		}
	else
		local var_26_0 = {
			rank = -1,
			headId = self._developSystem:getheadId()
		}

		var_26_0.headFrame = self._developSystem:getPlayer():getCurHeadFrame()
		var_26_0.name = self._developSystem:getNickName()
		var_26_0.rid = self._developSystem:getRid()
		var_26_0.combat = self._developSystem:getTeamByType(StageTeamType.STAGE_NORMAL):getCombat()
		var_26_0.score = self._rTPKSystem:getRtpk():getCurScore()
		showData = var_26_0
	end

	if showData then
		self._myselfInfo:setVisible(true)

		local rank = showData.rank

		rankText:setVisible(rank <= -1)
		rankIndex:setVisible(rank > -1)

		if rank > -1 then
			rankIndex:setString(rank)
		else
			rankText:setString(Strings:get("RTPK_PopUpRank_UI10"))
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

		if roleServer:isVisible() then
			local idStr = string.split(showData.rid, "_")[2]
			local serverInfo = self._loginSystem:getLogin():getServerBySec(idStr)
			local s = Strings:get("RTPK_Record_UI01", {
				serverId = idStr,
				serverName = serverInfo:getName()
			})

			roleServer:setString(s)
		end

		roleFight:setString(showData.combat)
		roleScore:setString(showData.score)

		local info = self._rTPKSystem:getGradeByScore(showData.score)

		roleGradeIcon:removeAllChildren()

		local icon = IconFactory:createRTPKGradeIcon(info.Id, {
			hideName = true
		})

		icon:setScale(0.25)
		icon:addTo(roleGradeIcon):offset(25, 35)
	end
end

function RTPKRankViewMediator:requestRankData(data, callback)
	if data.subId == SeverRankTab.KServerRank then
		local sendData = {
			type = RankType.KRTPK,
			rankStart = data.rankStart,
			rankEnd = data.rankEnd
		}

		self._rankSystem:requestRankData(sendData, callback)
	else
		local sendData = {
			type = RankType.KRTPK,
			rankStart = data.rankStart,
			rankEnd = data.rankEnd
		}

		self._rankSystem:requestRTPKAllServerRankData(sendData, callback)
	end
end

function RTPKRankViewMediator:onClickBack()
	self:close()
end
