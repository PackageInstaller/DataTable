-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceHurtMediator.lua

RankTopImage = {
	"swear_img_paiming01.png",
	"swear_img_paiming02.png",
	"swear_img_paiming03.png"
}
WordPeaceHurtMediator = class("WordPeaceHurtMediator", DmPopupViewMediator)

WordPeaceHurtMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
WordPeaceHurtMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")
WordPeaceHurtMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WordPeaceHurtMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")
WordPeaceHurtMediator:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")

local kCellHeight = 114
local kBtnHandlers = {}

function WordPeaceHurtMediator:initialize()
	super.initialize(self)
end

function WordPeaceHurtMediator:dispose()
	super.dispose(self)
end

function WordPeaceHurtMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.dailyReset)
end

function WordPeaceHurtMediator:enterWithData(data)
	self._curTabIdx = 1
	self._selfTagImg = nil
	self._isAskingRank = false
	self._viewType = data.viewType

	self:refreshData()
	self:initWigetInfo()
	self:createTableView()
end

function WordPeaceHurtMediator:resumeWithData()
	self:onClickTab()
end

function WordPeaceHurtMediator:initWigetInfo()
	self._noHasPanel = self:getView():getChildByFullName("nohas")

	self._noHasPanel:setVisible(false)

	self._mainPanel = self:getView():getChildByFullName("main")
	self._myCellNo = self:getView():getChildByFullName("mycellno")
	self._tableLayout = self._mainPanel:getChildByName("ListView")
	self._myCellPanel = self:getView():getChildByName("mycell")
	self._clonePanel = self:getView():getChildByName("clone")

	self._clonePanel:setVisible(false)
end

function WordPeaceHurtMediator:onClickTab()
	dump(self._viewType, "f______342")
	self._tableView:stopScroll()

	local function switchTabView()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:refreshData()
		self:refreshView()
		self:refreshMyselfInfo()
	end

	self._rankSystem:cleanUpRankListByType(self._viewType)

	local var_7_0 = {
		rankStart = 1
	}

	var_7_0.rankEnd = self:getRankSystem():getRequestRankCountPerTime()
	var_7_0.subId = self._curTabIdx

	local sendData = var_7_0

	self:requestRankData(sendData, switchTabView)

	self._requestNextCount = nil
	self._isAskingRank = false
end

function WordPeaceHurtMediator:setupView(data)
	dump(data, "data____datadata")

	self._curTabIdx = 1
	self._selfTagImg = nil
	self._isAskingRank = false
	self._viewType = data.rankType

	self:initWigetInfo()

	if not self._tableView then
		self:createTableView()
	end

	self:onClickTab()
end

function WordPeaceHurtMediator:createTableView()
	local scrollLayer = self._tableLayout
	local viewSize = scrollLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableView()
		end
	end

	local function numberOfCells(view)
		return #self._rankList
	end

	local function cellTouched(table, cell)
		self:onClickRankCell(cell)
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

function WordPeaceHurtMediator:getRankRewardByIndex(rankType, index)
	rankType = rankType or self._viewType

	local config = ConfigReader:getRecordById("ConfigValue", "ClubMapJiShaRank").content

	if rankType == RankType.KWorldPeaceScore then
		config = ConfigReader:getRecordById("ConfigValue", "ClubMapJiFenRank").content
	end

	self._cacha = self._cacha or {}
	self._cacha[rankType] = self._cacha[rankType] or {}

	for i = 1, #config do
		local rankRewardId = config[i]
		local rewardConfig = ConfigReader:getRecordById("RankReward", rankRewardId)

		for j = rewardConfig.Rank[1], rewardConfig.Rank[2] do
			self._cacha[rankType][j] = rewardConfig.Reward
		end
	end

	local cache = self._cacha[rankType]

	return cache[index]
end

function WordPeaceHurtMediator:refreshRankPanel(rankCell, index, isOwner)
	local bg1 = rankCell:getChildByName("Image_bg1")
	local bg2 = rankCell:getChildByName("Image_bg2")
	local rankIcon = rankCell:getChildByName("rankIcon")
	local rankIndex = rankCell:getChildByName("rankIndex")
	local roleIcon = rankCell:getChildByName("roleIcon")
	local clubName = rankCell:getChildByName("name1")
	local roleName = rankCell:getChildByName("name2")
	local roleScore = rankCell:getChildByName("rankScore")

	rankIcon:ignoreContentAdaptWithSize(true)
	rankIcon:setScale(0.8)
	rankIcon:posite(45, 57)

	if isOwner then
		rankIcon:posite(297, 110)
	end

	roleIcon:setTouchEnabled(false)

	if bg2 then
		bg2:setVisible(index % 2 == 0)
	end

	if bg1 then
		bg1:setVisible(index % 2 ~= 0)
	end

	rankIcon:setVisible(index <= 3)
	rankIndex:setVisible(index > 3)

	local record = self._rankList[index]

	if record then
		if index <= 3 then
			rankIcon:loadTexture("asset/commonRaw/" .. RankTopImage[index])
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
		roleName:setString(record:getNickName())
		clubName:setString(record:getClubName())
		roleScore:setString(record:getScores())

		local function callFunc(sender, eventType)
			return
		end

		mapButtonHandlerClick(nil, roleIcon, {
			func = callFunc
		})
	end

	local listview = rankCell:getChildByName("listview")

	listview:setSwallowTouches(false)
	listview:removeAllChildren()
	listview:setScrollBarEnabled(false)

	local rewardId = self:getRankRewardByIndex(self._viewType, index)
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

	for i, rewardData in pairs(rewards) do
		local function createRewardFunc()
			local iconPanel = ccui.Layout:create()

			iconPanel:setContentSize(cc.size(60, 60))

			local icon = IconFactory:createRewardIcon(rewardData, {
				isWidget = true
			})

			icon:setAnchorPoint(cc.p(0, 0))
			icon:setScaleNotCascade(0.45)
			icon:addTo(iconPanel):posite(2, 0)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
				needDelay = true
			})
			listview:pushBackCustomItem(iconPanel)
		end

		rankCell:runAction(DelayAction:create(function()
			createRewardFunc()
		end, 0.06 * (i - 1)))
	end
end

function WordPeaceHurtMediator:addRankPanel(cell, index)
	cell:removeAllChildren()

	local rankCell = self._clonePanel:clone()

	rankCell:setVisible(true)
	rankCell:addTo(cell):posite(0, 0)
	self:refreshRankPanel(rankCell, index)
end

function WordPeaceHurtMediator:onClickRankCell(cell)
	local tag = cell:getTag()
	local index = tag + 1
	local record = self._rankList[index]

	if record then
		-- block empty
	end
end

function WordPeaceHurtMediator:touchForTableView()
	if self._isAskingRank then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local offsetY = self._tableView:getContentOffset().y

	if (kMinRefreshHeight < offsetY and viewHeight < self._tableView:getContentSize().height and #self._rankList < self._rankSystem:getNewAreanaMaxRank() or nil) and true then
		self._isAskingRank = true
		self._requestNextCount = #self._rankList

		self:doRequestNextRank()
	end
end

function WordPeaceHurtMediator:doRequestNextRank()
	local dataEnough = self:getRankSystem():isServerDataEnough(self._viewType)

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

function WordPeaceHurtMediator:refreshData()
	dump(self._viewType, "f______342")

	self._rankList = self._rankSystem:getRankListByType(self._viewType)

	dump(self._rankList, "f______rankList_2322")
end

function WordPeaceHurtMediator:dailyReset()
	self:close()
end

function WordPeaceHurtMediator:refreshView()
	self._tableView:stopScroll()
	self._tableView:reloadData()

	if self._requestNextCount then
		local diffCount = #self._rankList - self._requestNextCount
		local offsetY = diffCount == 0 and 0 or -diffCount * kCellHeight + kCellHeight * 1.2

		self._tableView:setContentOffset(cc.p(0, offsetY))

		self._requestNextCount = nil
		self._isAskingRank = false
	end

	self._noHasPanel:setVisible(#self._rankList == 0)
end

function WordPeaceHurtMediator:refreshMyselfInfo()
	local myselfData = self._rankSystem:getMyselfDataByType(self._viewType)

	dump(myselfData, "myselfData____myselfData")

	local rankCell = self._myCellPanel

	rankCell:setVisible(false)
	self._myCellNo:setVisible(true)

	if not myselfData then
		return
	end

	rankCell:setVisible(true)
	self._myCellNo:setVisible(false)
	self:refreshRankPanel(rankCell, myselfData:getRank(), true)
end

function WordPeaceHurtMediator:clickShowInfo(data)
	data.from = "RANK"

	local view = self:getInjector():getInstance("ArenaNewRivalView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, nil))
end

function WordPeaceHurtMediator:requestRankData(data, callback)
	local sendData = {
		type = self._viewType,
		rankStart = data.rankStart,
		rankEnd = data.rankEnd
	}

	self._worldPeaceSystem:getPersonRankInfo(sendData, callback)
end

function WordPeaceHurtMediator:onClickBack()
	self:close()
end
