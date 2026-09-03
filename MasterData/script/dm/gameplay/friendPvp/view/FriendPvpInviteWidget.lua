-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friendPvp/view/FriendPvpInviteWidget.lua

FriendPvpInviteWidget = class("FriendPvpInviteWidget", BaseWidget, _M)

FriendPvpInviteWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
FriendPvpInviteWidget:has("_friendPvpSystem", {
	is = "r"
}):injectWith("FriendPvpSystem")
FriendPvpInviteWidget:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
FriendPvpInviteWidget:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kShowTab = {
	kFriend = 1,
	kClub = 2
}
local kCellHeight = 108
local kTabName = {
	[kShowTab.kFriend] = Strings:get("Friend_UI1"),
	[kShowTab.kClub] = Strings:get("Club_Text96")
}

function FriendPvpInviteWidget:initialize()
	local view = cc.CSLoader:createNode("asset/ui/FriendPvpInviteList.csb")

	super.initialize(self, view)

	self._timeScheduler = {}
end

function FriendPvpInviteWidget:dispose()
	if self._tabController then
		self._tabController:dispose()

		self._tabController = nil
	end

	self._friendPvp:clearInviteList()
	self:clearTimeScheduler()
	self:getEventDispatcher():removeEventListener(EVT_FRIENDPVP_DATAUODATA, self, self.setupView)
	self:getEventDispatcher():removeEventListener(EVT_FRIENDPVP_INVITELIST_SUCC, self, self.setupView)
	super.dispose(self)
end

function FriendPvpInviteWidget:clearTimeScheduler()
	for i, timeScheduler in pairs(self._timeScheduler) do
		if timeScheduler then
			LuaScheduler:getInstance():unschedule(timeScheduler)

			timeScheduler = nil
		end
	end
end

function FriendPvpInviteWidget:initWidget()
	self._main = self:getView():getChildByName("main")
	self._tabPanel = self._main:getChildByName("tab_panel")
	self._tabClone = self:getView():getChildByName("tab")

	local text1 = self._tabClone:getChildByName("dark_2")
	local text2 = self._tabClone:getChildByName("light_2")

	text1:setAdditionalKerning(4)
	text2:setAdditionalKerning(4)

	self._cellClone = self:getView():getChildByName("cell")
	self._countNode = self._main:getChildByName("Text_countstr")
end

function FriendPvpInviteWidget:createMapListener()
	self:getEventDispatcher():addEventListener(EVT_FRIENDPVP_DATAUODATA, self, self.setupView)
	self:getEventDispatcher():addEventListener(EVT_FRIENDPVP_INVITELIST_SUCC, self, self.setupView)
end

function FriendPvpInviteWidget:initView(data)
	self:initWidget()

	self._friendPvp = self._friendPvpSystem:getFriendPvp()
	self._mediator = data.mediator
	self._curTabType = 1

	if data and data.tabType then
		self._curTabType = data.tabType
	end

	self._list = self._friendPvp:getInviteListByType(self._curTabType)

	self:createMapListener()
	self:setupTabController()
	self:createTableView()
	self:setupView()
end

function FriendPvpInviteWidget:setupView()
	local countData = self._friendPvp:getInviteCountByType(self._curTabType)

	self._list = self._friendPvp:getInviteListByType(self._curTabType)

	local tipsPanel = self._main:getChildByName("noList")

	tipsPanel:setVisible(#self._list == 0)

	local tipsText = tipsPanel:getChildByName("tipsText")
	local actBtn = tipsPanel:getChildByName("goBtn")
	local btnText = actBtn:getChildByName("text")
	local callFunc

	if self._curTabType == kShowTab.kFriend then
		tipsText:setString(Strings:get("Friend_Pvp_NoFriend"))
		btnText:setString(Strings:get("Friend_UI3"))

		function callFunc()
			self._friendSystem:tryEnter()
		end
	elseif self._curTabType == kShowTab.kClub then
		tipsText:setString(Strings:get("Friend_Pvp_NoClubMember"))
		btnText:setString(Strings:get("Friend_Pvp_FindClub"))

		function callFunc()
			local clubSystem = self:getInjector():getInstance(ClubSystem)

			clubSystem:tryEnter()
		end
	end

	mapButtonHandlerClick(nil, actBtn, {
		func = callFunc
	})

	if self._requestNextCount then
		self:clearTimeScheduler()
		self._tableView:removeFromParent(true)
		self:createTableView()
		self._tableView:reloadData()

		local diffCount = #self._list - self._requestNextCount
		local offsetY = -diffCount * kCellHeight + kCellHeight * 1.2

		self._tableView:setContentOffset(cc.p(0, offsetY))

		self._requestNextCount = nil
		self._isAskingRank = false
	else
		local offset = self._tableView:getContentOffset()

		self._tableView:reloadData()

		if not self._isNotOffset then
			self._tableView:setContentOffset(offset)
		end
	end

	self._isNotOffset = false
end

function FriendPvpInviteWidget:setupTabController()
	local tabBtns = {}

	for i = 1, table.nums(kShowTab) do
		local button = self._tabClone:clone()

		button:setVisible(true)
		button:setTag(i)

		local lightText = button:getChildByFullName("light_2")

		lightText:setString(kTabName[i])

		local darkText = button:getChildByFullName("dark_2")

		darkText:setString(kTabName[i])
		button:addTo(self._tabPanel):posite((i - 1) * 115, 6)

		tabBtns[#tabBtns + 1] = button
	end

	self._tabController = TabController:new(tabBtns, function(name, tag)
		return self:onClickTab(tag)
	end)

	self._tabController:selectTabByTag(self._curTabType)
end

function FriendPvpInviteWidget:createTableView()
	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableview()
		end
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return self._cellClone:getContentSize().width, self._cellClone:getContentSize().height + 9
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._cellClone:clone()

			sprite:setVisible(true)
			sprite:setPosition(0, 0)
			cell:addChild(sprite)
			sprite:setVisible(true)
			sprite:setTag(10000)

			local cell_Old = cell:getChildByTag(10000)

			self:refreshTableCell(cell_Old, idx + 1)
			cell:setTag(idx + 1)
		else
			local cell_Old = cell:getChildByTag(10000)

			self:refreshTableCell(cell_Old, idx + 1)
			cell:setTag(idx + 1)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._list
	end

	local tableView = cc.TableView:create(cc.size(480, 402))

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:posite(36, 16.5)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._main:addChild(tableView, -1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)

	self._tableView = tableView

	tableView:reloadData()
end

function FriendPvpInviteWidget:refreshTableCell(cell, index)
	local data = self._list[index]
	local nameText = cell:getChildByName("name")

	nameText:setString(data:getNickName())

	local combatText = cell:getChildByName("combat")

	combatText:setString(data:getCombat())

	local posText = cell:getChildByName("clubPos")
	local posTag = data:getClubPos()

	if posTag == -1 then
		posText:setVisible(false)
	else
		posText:setVisible(true)
		posText:setString(ClubPositionNameStr[posTag])
	end

	local headIcon = cell:getChildByName("head")

	headIcon:removeAllChildren()

	local headImgId = data:getHeadId()
	local icon = IconFactory:createPlayerIcon({
		frameStyle = 2,
		id = headImgId,
		size = cc.size(74, 74)
	})

	icon:setScale(0.85)
	icon:addTo(headIcon):center(headIcon:getContentSize())

	local function clickHeadIconFunc()
		self:onClickChatView(data)
	end

	mapButtonHandlerClick(nil, headIcon, {
		ignoreClickAudio = true,
		func = clickHeadIconFunc
	})

	local kickOutBtn = cell:getChildByName("refBtn")

	kickOutBtn:setVisible(false)

	local inviteBtn = cell:getChildByName("actBtn")

	inviteBtn:setVisible(true)

	local function callFunc()
		self:onClickInvite(data)
	end

	mapButtonHandlerClick(nil, inviteBtn, {
		func = callFunc
	})

	local statusText = cell:getChildByName("Text_status")
	local status = data:getStatus()

	if status == FPVPPlayerStatus.kOnline then
		headIcon:setGray(false)
		inviteBtn:setEnabled(true)
		inviteBtn:setGray(false)
		statusText:setVisible(false)
	elseif status == FPVPPlayerStatus.kOffline then
		headIcon:setGray(true)

		local time = self._gameServerAgent:remoteTimestamp() - data:getLastOfflineTime()

		statusText:setString(self._friendSystem:formatOnlineTime(time))
		inviteBtn:setVisible(false)
		statusText:setVisible(true)
	elseif status == FPVPPlayerStatus.kBusy then
		headIcon:setGray(false)
		statusText:setString(Strings:get("Friend_Pvp_PlayerBusy"))
		inviteBtn:setVisible(false)
		statusText:setVisible(true)
	end

	local guestInfo = self._friendPvp:getGuestInfo()

	if guestInfo and data:getRid() == guestInfo.id then
		inviteBtn:setVisible(false)
		kickOutBtn:setVisible(true)
		kickOutBtn:addTouchEventListener(function(sender, eventType)
			self:onClickKickOut(sender, eventType, guestInfo)
		end)
	end

	if self._timeScheduler[index] then
		LuaScheduler:getInstance():unschedule(self._timeScheduler[index])

		self._timeScheduler[index] = nil
	end

	if inviteBtn:isVisible() then
		self:updateInviteBtnText(inviteBtn, kickOutBtn, index)
	end
end

function FriendPvpInviteWidget:updateInviteBtnText(inviteBtn, kickOutBtn, index)
	local function refreshInviteBtnText()
		local guestInfo = self._friendPvp:getGuestInfo()
		local data = self._list[index]

		if not data then
			return
		end

		local inviteMap = self._friendPvpSystem:getInviteTimeMap()
		local lastTime = inviteMap[data:getRid()] or 0
		local curTime = self._gameServerAgent:remoteTimestamp()
		local cd = 10
		local btnText = inviteBtn:getChildByName("btnText")
		local status = data:getStatus()

		if status == FPVPPlayerStatus.kBusy then
			inviteBtn:setEnabled(false)
			inviteBtn:setGray(true)
		elseif lastTime == 0 or cd < curTime - lastTime then
			inviteBtn:setEnabled(true)
			inviteBtn:setGray(false)
			btnText:setString(Strings:get("Friend_Pvp_Invite"))

			if guestInfo then
				if data:getRid() == guestInfo.id then
					inviteBtn:setVisible(false)
					kickOutBtn:setVisible(true)
					kickOutBtn:addTouchEventListener(function(sender, eventType)
						self:onClickKickOut(sender, eventType, guestInfo)
					end)
				else
					inviteBtn:setEnabled(false)
					inviteBtn:setGray(true)
				end
			end
		else
			inviteBtn:setEnabled(false)
			inviteBtn:setGray(true)
			btnText:setString(TimeUtil:formatTime("${S}S", cd - (curTime - lastTime)))
		end
	end

	if self._timeScheduler[index] == nil then
		self._timeScheduler[index] = LuaScheduler:getInstance():schedule(function()
			refreshInviteBtnText()
		end, 1, false)
	end

	refreshInviteBtnText()
end

function FriendPvpInviteWidget:touchForTableview()
	if self._isAskingRequest then
		return
	end

	local countData = self._friendPvp:getInviteCountByType(self._curTabType)
	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local offsetY = self._tableView:getContentOffset().y

	if (kMinRefreshHeight < offsetY and viewHeight < self._tableView:getContentSize().height and #self._list < countData.total or nil) and true then
		self._isAskingRequest = true
		self._requestNextCount = #self._list

		self:doRequestNextRequest()
	end
end

function FriendPvpInviteWidget:doRequestNextRequest()
	local countData = self._friendPvp:getInviteCountByType(self._curTabType)
	local dataEnough = #self._list < countData.total

	if dataEnough == true then
		local pageCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Friend_PageCount", "content")
		local requestStart = #self._list + 1
		local requestEnd = requestStart + pageCount - 1

		self._friendPvpSystem:requestInvitingList(RequestType[self._curTabType], requestStart, requestEnd)
	end
end

function FriendPvpInviteWidget:onClickTab(tag)
	if self._curTabType == tag then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	self._curTabType = tag
	self._isNotOffset = true

	self._friendPvpSystem:requestInvitingList(RequestType[self._curTabType], 1, 20)
end

function FriendPvpInviteWidget:onClickInvite(data)
	local guestInfo = self._friendPvp:getGuestInfo()

	if guestInfo then
		return
	end

	self._friendPvpSystem:requestInviteFriend(data:getRid())

	local inviteMap = self._friendPvpSystem:getInviteTimeMap()

	inviteMap[data:getRid()] = self._gameServerAgent:remoteTimestamp()
end

function FriendPvpInviteWidget:onClickKickOut(sender, eventType, guestInfo)
	if self._mediator._startEnter then
		return
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			outSelf._friendPvpSystem:requestKickOut()
		end
	end

	local data = {
		title = Strings:get("Tip_Remind"),
		content = Strings:get("Friend_Pvp_KickOut"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function FriendPvpInviteWidget:onClickChatView(selectFriend)
	local selectFriendId = selectFriend:getRid()

	self._friendSystem:requestSimpleFriendInfo(selectFriendId, function(response)
		if response.isFriend == 1 then
			local data = {
				tabType = kFriendType.kGame,
				selectFriendId = selectFriendId
			}

			self._friendSystem:tryEnter(data)
		else
			local var_34_0 = {
				rid = selectFriendId,
				nickname = selectFriend:getNickName(),
				level = selectFriend:getLevel(),
				combat = selectFriend:getCombat(),
				headImage = selectFriend:getHeadId(),
				vipLevel = selectFriend:getVipLevel(),
				online = selectFriend:getOnline(),
				lastOfflineTime = selectFriend:getLastOfflineTime(),
				heroes = selectFriend:getHeroes(),
				slogan = selectFriend:getSlogan(),
				master = selectFriend:getMaster(),
				clubName = selectFriend:getClubName(),
				isFriend = response.isFriend
			}

			if response.isFriend == 1 then
				var_34_0.close = response.close or nil
			end

			var_34_0.block = response.block
			var_34_0.leadStageId = selectFriend:getLeadStageId()
			var_34_0.leadStageLevel = selectFriend:getLeadStageLevel()

			local data = var_34_0

			self._friendSystem:addRecentFriend(data)

			local data = {
				selectFriendIndex = 1,
				tabType = kFriendType.kRecent
			}

			self._friendSystem:tryEnter(data)
		end
	end)
end

function FriendPvpInviteWidget:showView()
	self._friendPvpSystem:requestInvitingList(RequestType[self._curTabType], 1, 20, function()
		self._view:setVisible(true)
	end)
end

function FriendPvpInviteWidget:hideView()
	self._view:setVisible(false)
	self:clearTimeScheduler()
end
