-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/LeadStageArenaRankViewMediator.lua

LeadStageArenaRankViewMediator = class("LeadStageArenaRankViewMediator", DmPopupViewMediator)

LeadStageArenaRankViewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
LeadStageArenaRankViewMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
LeadStageArenaRankViewMediator:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")
LeadStageArenaRankViewMediator:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")

local kCellHeight = 86
local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickBack"
	}
}

function LeadStageArenaRankViewMediator:initialize()
	super.initialize(self)
end

function LeadStageArenaRankViewMediator:dispose()
	super.dispose(self)
end

function LeadStageArenaRankViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)

	local bgNode = self:getView():getChildByFullName("main.bgNode")

	self:bindWidget("main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("StageArena_MainUI06"),
		title1 = Strings:get("Activity_Saga_UI_48"),
		bgSize = {
			width = 835,
			height = 570
		}
	})
end

function LeadStageArenaRankViewMediator:enterWithData(data)
	self._isAskingRank = false
	self._rankType = RankType.KStageAreana

	self:refreshData()
	self:initWigetInfo()
	self:createTableView()
	self:refreshView()
	self._rankSystem:cleanUpRankListByType(self._rankType)

	local function switchTabView()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:refreshData()
		self:refreshView()
	end

	local var_4_0 = {
		rankStart = 1
	}

	var_4_0.rankEnd = self:getRankSystem():getRequestRankCountPerTime()

	local sendData = var_4_0

	self:requestRankData(sendData, switchTabView)

	self._requestNextCount = nil
	self._isAskingRank = false
end

function LeadStageArenaRankViewMediator:resumeWithData()
	return
end

function LeadStageArenaRankViewMediator:initWigetInfo()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._viewPanel = self:getView():getChildByFullName("main.viewPanel")
	self._myselfInfo = self._mainPanel:getChildByFullName("viewPanel.rankMyselfInfo")
	self._tableLayout = self._viewPanel:getChildByName("tableView")
	self._clonePanel = self._viewPanel:getChildByName("rankCellPanel")

	self._clonePanel:setVisible(false)
end

function LeadStageArenaRankViewMediator:createTableView()
	local scrollLayer = self._mainPanel:getChildByFullName("viewPanel.tableView")
	local viewSize = scrollLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableView()
		end
	end

	local function numberOfCells(view)
		return #self._rankList < 4 and 4 or #self._rankList
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

function LeadStageArenaRankViewMediator:addRankPanel(cell, index)
	cell:removeAllChildren()

	local rankCell = self._clonePanel:clone()

	rankCell:setVisible(true)
	rankCell:addTo(cell):posite(0, 0)

	local nodeInfo = rankCell:getChildByFullName("panelInfo")
	local bg1 = rankCell:getChildByFullName("Image_bg1")
	local bg2 = rankCell:getChildByFullName("Image_bg2")
	local rankIcon = rankCell:getChildByFullName("panelInfo.rankIcon")
	local rankIndex = rankCell:getChildByFullName("panelInfo.rankindex")
	local roleIcon = rankCell:getChildByFullName("panelInfo.roleIcon")
	local roleName = rankCell:getChildByFullName("panelInfo.roleName")
	local roleServer = rankCell:getChildByFullName("panelInfo.roleServer")
	local roleScore = rankCell:getChildByFullName("panelInfo.rankScore")
	local roleGradeIcon = rankCell:getChildByFullName("panelInfo.oldCoinIcon")
	local imgEmpy = rankCell:getChildByFullName("img_empty")

	rankIcon:ignoreContentAdaptWithSize(true)
	bg1:setVisible(index % 2 == 0)
	bg2:setVisible(index % 2 ~= 0)

	local record = self._rankList[index]

	imgEmpy:setVisible(record == nil)
	nodeInfo:setVisible(record ~= nil)

	if record then
		rankIcon:setVisible(index <= 3)
		rankIndex:setVisible(index > 3)

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

		local idStr = string.split(record:getRid(), "_")[2]
		local serverInfo = self._loginSystem:getLogin():getServerBySec(idStr)
		local s = Strings:get("StageArena_MainUI14", {
			servername = serverInfo:getName()
		})

		roleServer:setString(s)
		roleScore:setString(record:getOldCoin())

		local icon = ccui.ImageView:create(leadStageArenaPicPath, ccui.TextureResType.plistType)

		roleGradeIcon:removeAllChildren()
		icon:setScale(0.4)
		icon:addTo(roleGradeIcon):offset(20, 25)
	end
end

function LeadStageArenaRankViewMediator:onClickRankCell(cell)
	return
end

function LeadStageArenaRankViewMediator:touchForTableView()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local offsetY = self._tableView:getContentOffset().y

	if (kMinRefreshHeight < offsetY and viewHeight < self._tableView:getContentSize().height and #self._rankList < self._rankSystem:getLeadStageAreanaMaxRank() or nil) and true then
		self._isAskingRank = true
		self._requestNextCount = #self._rankList

		self:doRequestNextRank()
	end
end

function LeadStageArenaRankViewMediator:doRequestNextRank()
	local dataEnough = self:getRankSystem():isServerDataEnough(self._rankType)

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
			rankEnd = rankEnd
		}

		self:requestRankData(sendData, onRequestRankDataSucc)
	end
end

function LeadStageArenaRankViewMediator:refreshData()
	self._rankList = self._rankSystem:getRankListByType(self._rankType)
end

function LeadStageArenaRankViewMediator:dailyReset()
	self:close()
end

function LeadStageArenaRankViewMediator:refreshView()
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

function LeadStageArenaRankViewMediator:refreshMyselfInfo()
	local rankIndex = self._myselfInfo:getChildByName("rankindex_0")
	local roleIcon = self._myselfInfo:getChildByName("roleIcon_0")
	local roleName = self._myselfInfo:getChildByName("roleName_0")
	local roleServer = self._myselfInfo:getChildByName("roleServer_0")
	local roleScore = self._myselfInfo:getChildByName("rankScore_0")
	local roleGradeIcon = self._myselfInfo:getChildByName("gradeIcon_0")
	local rankText = self._myselfInfo:getChildByName("ranktext")
	local myselfData = self:getRankSystem():getMyselfDataByType(self._rankType)
	local showData = {}

	if myselfData then
		showData = {
			rank = myselfData:getRank(),
			headId = myselfData:getHeadId(),
			headFrame = myselfData:getHeadFrame(),
			name = myselfData:getName(),
			rid = myselfData:getRid(),
			score = myselfData:getOldCoin()
		}
	else
		local var_22_0 = {
			rank = -1,
			headId = self._developSystem:getheadId()
		}

		var_22_0.headFrame = self._developSystem:getPlayer():getCurHeadFrame()
		var_22_0.name = self._developSystem:getNickName()
		var_22_0.rid = self._developSystem:getRid()
		var_22_0.score = self._leadStageArenaSystem:getOldCoin()
		showData = var_22_0
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

		local idStr = string.split(showData.rid, "_")[2]
		local serverInfo = self._loginSystem:getLogin():getServerBySec(idStr)
		local s = Strings:get("StageArena_MainUI14", {
			servername = serverInfo:getName()
		})

		roleServer:setString(s)
		roleScore:setString(showData.score)

		local icon = ccui.ImageView:create(leadStageArenaPicPath, ccui.TextureResType.plistType)

		roleGradeIcon:removeAllChildren()
		icon:setScale(0.4)
		icon:addTo(roleGradeIcon):offset(18, 25)
	end
end

function LeadStageArenaRankViewMediator:requestRankData(data, callback)
	local sendData = {
		type = self._rankType,
		rankStart = data.rankStart,
		rankEnd = data.rankEnd
	}

	self._rankSystem:requestStageAreanaAllServerRankData(sendData, callback)
end

function LeadStageArenaRankViewMediator:onClickBack()
	self:close()
end
