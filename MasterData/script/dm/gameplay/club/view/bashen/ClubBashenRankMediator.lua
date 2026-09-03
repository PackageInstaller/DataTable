-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/bashen/ClubBashenRankMediator.lua

ClubBashenRankMediator = class("ClubBashenRankMediator", DmPopupViewMediator, _M)

ClubBashenRankMediator:has("_clubBashenSystem", {
	is = "r"
}):injectWith("ClubBashenSystem")

local kCellWigth, kCellHeight = 707, 87
local kCellTag = 4369

function ClubBashenRankMediator:initialize()
	super.initialize(self)
end

function ClubBashenRankMediator:dispose()
	self._rankListModel:cleanUp()
	super.dispose(self)
end

function ClubBashenRankMediator:onRegister()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)
	super.onRegister(self)
end

function ClubBashenRankMediator:enterWithData(data)
	super.enterWithData(self, data)

	self._clubBashen = self._clubBashenSystem:getClubBashen()
	self._rankListModel = self._clubBashen:getRankList()
	self._rankList = self._rankListModel:getList()
	self._rankType = ClubBashenRankType.kToday

	self:setupView()
end

function ClubBashenRankMediator:setupView()
	self._main = self:getView():getChildByName("main")

	local bgNode = self._main:getChildByFullName("bg")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onClickClose, self),
		title = Strings:get("Club_Text51")
	})

	self._cellModel = self:getView():getChildByName("cell")

	self._cellModel:setVisible(false)

	local emptyPanel = self._main:getChildByFullName("Node_none")

	if #self._rankList > 0 then
		self:initTableView()
		emptyPanel:setVisible(false)
	else
		emptyPanel:setVisible(true)
	end

	self:setupMyselfView()
	self:initTabController()
end

function ClubBashenRankMediator:initTabController()
	local tabBtns = {}
	local leftPanel = self._main:getChildByName("left_panel")
	local btnToday = leftPanel:getChildByName("button_today")
	local btnYesterday = leftPanel:getChildByName("button_yesterday")

	btnToday:setTag(1)
	btnYesterday:setTag(2)

	tabBtns[1] = btnToday
	tabBtns[2] = btnYesterday
	self._tabController = TabController:new(tabBtns, function(name, tag)
		return self:onClickTab(name, tag)
	end)

	self._tabController:selectTabByTag(1)
end

function ClubBashenRankMediator:initTableView()
	if self._tableView then
		return
	end

	local scrollLayer = self._main:getChildByFullName("Panel_tabView")
	local viewSize = scrollLayer:getContentSize()
	local width = viewSize.width
	local tableView = cc.TableView:create(cc.size(width, viewSize.height))

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableview()
		end
	end

	local function numberOfCells(view)
		return self._rankListModel:getRecordCount()
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return kCellWigth, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			cell:setContentSize(cc.size(kCellWigth, kCellHeight))

			local cellPanel = self._cellModel:clone()

			cellPanel:setPosition(cc.p(0, 0))
			cellPanel:setTag(kCellTag)
			cellPanel:setVisible(true)
			cellPanel:addTo(cell)
		end

		local cellPanel = cell:getChildByTag(kCellTag)

		self:updateTableCell(cellPanel, idx + 1)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(0, 0)
	tableView:setDelegate()
	scrollLayer:addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:reloadData()

	self._tableView = tableView
end

function ClubBashenRankMediator:updateTableCell(cell, index)
	local Image_bg = cell:getChildByName("Image_bg")
	local imageRank = cell:getChildByName("Image_rank")
	local imgMySelf = cell:getChildByName("Image_mySelf")
	local textRank = cell:getChildByName("Text_rank")
	local textName = cell:getChildByName("Text_name")
	local textScore = cell:getChildByName("score")
	local panelIcon = cell:getChildByName("Panel_Icon")
	local gemsIcon = cell:getChildByName("reward_icon")
	local rewardPanel1 = cell:getChildByName("reward_panel_1")
	local rewardPanel2 = cell:getChildByName("reward_panel_2")

	panelIcon:removeAllChildren(true)
	textRank:setVisible(false)
	imageRank:setVisible(true)
	imageRank:removeAllChildren()

	local rankData = self._rankList[index]

	if index >= 1 and index <= 3 then
		imageRank:loadTexture("img_zlb_no" .. index .. ".png", ccui.TextureResType.plistType)
	else
		imageRank:setVisible(false)
		textRank:setVisible(true)
		textRank:setString(index)
	end

	textName:setString(rankData:getPlayerName())

	local developSystem = self:getInjector():getInstance("DevelopSystem")
	local myselfRid = developSystem:getPlayer():getRid()

	if myselfRid == rankData:getRid() then
		imgMySelf:setVisible(true)
	else
		imgMySelf:setVisible(false)
	end

	local headInfo = {
		id = rankData:getHeadImg(),
		frameId = rankData:getHeadFrame(),
		serverParams = {
			rid = rankData:getRid()
		}
	}
	local headIcon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		clipType = 1,
		headFrameScale = 0.415,
		id = headInfo.id,
		size = cc.size(82, 82),
		headFrameId = headInfo.frameId
	})

	headIcon:setScale(0.8)
	headIcon:addTo(panelIcon):center(panelIcon:getContentSize())

	local function setGemsInfo(panel, info)
		local gemsNum = info.gemsNum
		local quality = info.quality
		local gemsIcon = panel:getChildByName("reward_icon")
		local numLabel = panel:getChildByName("num")

		gemsIcon:loadTexture(GemPath[quality], ccui.TextureResType.plistType)
		numLabel:setString(gemsNum)
	end

	local gemsInfoList = rankData:getRankGemsInfo()

	if #gemsInfoList == 0 then
		rewardPanel1:setVisible(false)
		rewardPanel2:setVisible(false)
	elseif #gemsInfoList == 1 then
		rewardPanel1:setVisible(true)
		rewardPanel2:setVisible(false)
		setGemsInfo(rewardPanel1, gemsInfoList[1])
	elseif #gemsInfoList >= 2 then
		rewardPanel1:setVisible(true)
		rewardPanel2:setVisible(true)
		setGemsInfo(rewardPanel1, gemsInfoList[1])
		setGemsInfo(rewardPanel2, gemsInfoList[2])
	end

	local bg = index % 2 == 0 and "bd_bg_xxt_1.png" or "bd_bg_xxt_2.png"

	Image_bg:loadTexture(bg, 1)
end

function ClubBashenRankMediator:setupMyselfView()
	local myselfPanel = self._main:getChildByFullName("Node_myInfo")

	myselfPanel:setVisible(true)

	local imageRank = myselfPanel:getChildByName("Image_rank")
	local imageMyself = myselfPanel:getChildByName("Image_mySelf")
	local textRank = myselfPanel:getChildByName("Text_rank")
	local textName = myselfPanel:getChildByName("Text_name")
	local panelIcon = myselfPanel:getChildByName("Panel_Icon")
	local textNoRankimg = myselfPanel:getChildByName("notrankimg")
	local gemsIcon = self._main:getChildByName("reward_icon")
	local rewardPanel1 = myselfPanel:getChildByName("reward_panel_1")
	local rewardPanel2 = myselfPanel:getChildByName("reward_panel_2")

	panelIcon:removeAllChildren(true)
	textRank:setVisible(false)
	imageRank:setVisible(true)
	textNoRankimg:setVisible(false)
	imageRank:removeAllChildren()

	local myselfRankData = self._rankListModel:getSelfRecord()
	local rank = myselfRankData:getRank()

	if rank == -1 then
		imageRank:setVisible(false)
		textNoRankimg:setVisible(true)
	elseif rank >= 1 and rank <= 3 then
		imageRank:loadTexture("img_zlb_no" .. rank .. ".png", ccui.TextureResType.plistType)
	else
		imageRank:setVisible(false)
		textRank:setVisible(true)
		textRank:setString(myselfRankData:getRank())
	end

	textName:setString(myselfRankData:getPlayerName())

	local headInfo = {
		id = myselfRankData:getHeadImg(),
		frameId = myselfRankData:getHeadFrame(),
		serverParams = {
			rid = myselfRankData:getRid()
		}
	}
	local headIcon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		clipType = 1,
		headFrameScale = 0.415,
		id = headInfo.id,
		size = cc.size(82, 82),
		headFrameId = headInfo.frameId
	})

	headIcon:setScale(0.8)
	headIcon:addTo(panelIcon):center(panelIcon:getContentSize())

	local function setGemsInfo(panel, info)
		local gemsNum = info.gemsNum
		local quality = info.quality
		local gemsIcon = panel:getChildByName("reward_icon")
		local numLabel = panel:getChildByName("num")

		gemsIcon:loadTexture(GemPath[quality], ccui.TextureResType.plistType)
		numLabel:setString(gemsNum)
	end

	local gemsInfoList = myselfRankData:getRankGemsInfo()

	if #gemsInfoList == 0 then
		rewardPanel1:setVisible(false)
		rewardPanel2:setVisible(false)
	elseif #gemsInfoList == 1 then
		rewardPanel1:setVisible(true)
		rewardPanel2:setVisible(false)
		setGemsInfo(rewardPanel1, gemsInfoList[1])
	elseif #gemsInfoList >= 2 then
		rewardPanel1:setVisible(true)
		rewardPanel2:setVisible(true)
		setGemsInfo(rewardPanel1, gemsInfoList[1])
		setGemsInfo(rewardPanel2, gemsInfoList[2])
	end
end

function ClubBashenRankMediator:touchForTableview()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local offsetY = self._tableView:getContentOffset().y

	if (kMinRefreshHeight < offsetY and viewHeight < self._tableView:getContentSize().height and self._rankListModel:getRecordCount() < self._rankListModel:getMaxCount() or nil) and true then
		self._isAskingRank = true
		self._requestNextCount = self._rankListModel:getRecordCount()

		self:doRequestNextRank()
	end
end

function ClubBashenRankMediator:doRequestNextRank()
	local dataEnough = self._rankListModel:getDataEnough(self._rankType)

	if dataEnough == true then
		local rankStart = self._rankListModel:getRecordCount() + 1
		local rankEnd = rankStart + self._rankListModel:getRequestRankCountPerTime() - 1

		self._clubBashenSystem:requestBashenRank(self._rankType, rankStart, rankEnd, function()
			if self._requestNextCount then
				self._tableView:reloadData()

				local diffCount = self._rankListModel:getRecordCount() - self._requestNextCount
				local offsetY = diffCount == 0 and 0 or -diffCount * kCellHeight + kCellHeight * 1.2

				self._tableView:setContentOffset(cc.p(0, offsetY))

				self._requestNextCount = nil
				self._isAskingRank = false
			end
		end)
	end
end

function ClubBashenRankMediator:dailyReset()
	self:close()
end

function ClubBashenRankMediator:onClickTab(name, tag)
	dump(tag, "tag______33")

	if self._rankType == ClubBashenRankType.kToday and tag == 1 then
		return
	elseif self._rankType == ClubBashenRankType.kYesterday and tag == 2 then
		return
	end

	self._rankListModel:cleanUp()

	if tag == 1 then
		self._rankType = ClubBashenRankType.kToday
	elseif tag == 2 then
		self._rankType = ClubBashenRankType.kYesterday
	end

	self._isAskingRank = false

	local rankStart = 1
	local rankEnd = 20

	dump("f_______333")
	self._clubBashenSystem:requestBashenRank(self._rankType, rankStart, rankEnd, function()
		self._rankList = self._rankListModel:getList()

		local emptyPanel = self._main:getChildByFullName("Node_none")

		if #self._rankList > 0 then
			emptyPanel:setVisible(false)
		else
			emptyPanel:setVisible(true)
		end

		if not self._tableView then
			self:initTableView()
		else
			self._tableView:reloadData()
		end

		self:setupMyselfView()
	end)
end

function ClubBashenRankMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
