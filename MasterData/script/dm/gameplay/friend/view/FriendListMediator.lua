-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/view/FriendListMediator.lua

FriendListMediator = class("FriendListMediator", DmPopupViewMediator, _M)

FriendListMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
FriendListMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
FriendListMediator:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")
FriendListMediator:has("_chat", {
	is = "r"
})
FriendListMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.nofriends.btn_find.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickFind"
	},
	["main.friends.btn_allsend.button"] = {
		ignoreClickAudio = true,
		func = "onClickAllSend"
	},
	["main.friends.btn_allget.button"] = {
		ignoreClickAudio = true,
		func = "onClickAllGet"
	}
}
local kViewTabType = {
	kFriend = 1,
	kRecent = 2
}
local kFriendViewCount = 4
local kRecentViewCount = 5

function FriendListMediator:initialize()
	super.initialize(self)
end

function FriendListMediator:dispose()
	if self._selectFriendIndex ~= -1 then
		self._mediator:setSelectFriendIndex(self._curTabType, self._selectFriendIndex)
	end

	if self._chatWidget then
		self._chatWidget:dispose()

		self._chatWidget = nil
	end

	self._friendSystem:getFriendModel():clearRecentData()
	super.dispose(self)
end

function FriendListMediator:onRemove()
	super.onRemove(self)
end

function FriendListMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
	self:bindWidget("main.nofriends.btn_find", TwoLevelViceButton, {})
	self:bindWidget("main.friends.btn_allsend", ThreeLevelMainButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("main.friends.btn_allget", ThreeLevelViceButton, {
		ignoreAddKerning = true
	})

	self._main = self:getView():getChildByName("main")
	self._friendsPanel = self._main:getChildByName("friends")
	self._noFriendsPanel = self._main:getChildByName("nofriends")
	self._chatPanel = self._main:getChildByName("chat")
	self._friendCell = self._friendsPanel:getChildByName("cell")

	self._friendCell:setVisible(false)

	self._countPanel = self._friendsPanel:getChildByName("friendcount")

	local Text_1 = self._countPanel:getChildByName("Text_1")
	local Text_count = self._countPanel:getChildByName("Text_count")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		Text_1:setPositionX(Text_1:getContentSize().width + 10)
		Text_count:setPositionX(Text_1:getPositionX() + 2)
	end

	self._fadeImgUp = self._friendsPanel:getChildByFullName("effectImg_up")
	self._fadeImgDown = self._friendsPanel:getChildByFullName("effectImg_down")

	self:bindWidgets()
end

function FriendListMediator:bindWidgets()
	self._allSendBtn = self._friendsPanel:getChildByFullName("btn_allsend")

	self._allSendBtn:getChildByName("button"):setTouchEnabled(true)
	self._allSendBtn:setLocalZOrder(10)

	self._allGetBtn = self._friendsPanel:getChildByFullName("btn_allget")

	self._allGetBtn:getChildByName("button"):setTouchEnabled(true)
	self._allGetBtn:setLocalZOrder(10)
end

function FriendListMediator:userInject()
	return
end

function FriendListMediator:setupView(data)
	self._friendSystem:requestFriendsMainInfo()
	self:initData(data)
	self:initView()
	self:setChatWidget()
	self:createTableView()
	self:setFriendCount()
	self:setDefaultChatWidget()
end

function FriendListMediator:initData(data)
	self._mediator = data.mediator
	self._chat = self._chatSystem:getChat()
	self._friendModel = self._friendSystem:getFriendModel()

	if data then
		self._curTabType = data.tabType or kViewTabType.kFriend
	end

	if data then
		self._selectFriendIndex = data.selectFriendIndex or -1
	end

	self._hasSendList = {}
	self._hasgetList = {}
	self._list = {}
	self._recentCount = nil
	self._chatFriend = nil
	self._friendList = self._friendModel:getFriendList(kFriendType.kGame)
	self._recentList = self._friendSystem:getRecentList(self._recentCount)
	self._list = self._curTabType == kViewTabType.kFriend and self._friendList or self._recentList

	if data.selectFriendId then
		for k, v in ipairs(self._list) do
			if v:getRid() == data.selectFriendId then
				self._selectFriendIndex = k

				break
			end
		end
	end
end

function FriendListMediator:initView()
	local noFriendText = self._noFriendsPanel:getChildByName("Text_29")

	noFriendText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local textFriend = self._countPanel:getChildByFullName("Text_1")

	textFriend:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	textFriend:setString((self._curTabType == kViewTabType.kFriend or nil) and (Strings:get("Friend_UI12") or Strings:get("Friend_UI12_1")))

	local textCount = self._countPanel:getChildByFullName("Text_count")

	textCount:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._noFriendsPanel:setVisible(false)
	self._friendsPanel:setVisible(false)
	self._chatPanel:setVisible(false)
	self._main:getChildByName("bg"):setVisible(false)
end

function FriendListMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_GETFRIENDSLIST_SUCC, self, self.onGetFriendListCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_SENDPOWER_SUCC, self, self.onSendPowerSuccCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_GERPOWER_SUCC, self, self.onGetPowerSuccCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_NEW_PRIVATEMESSAGE, self, self.onNewMessageCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_SEND_MESSAGE_SUCC, self, self.onChatSendCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_DELECT_SUCC, self, self.onDelectFriendCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_ADD_SUCC, self, self.onApplySuccCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_REMOVE_MESSAGE_SUCC, self, self.onRemoveMessageCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHANGECHATBUBBLE_SUCC, self, self.onBubbleChangeCallback)
end

function FriendListMediator:setChatWidget()
	local chatNode = self._chatPanel
	local chatWidget = self:getInjector():injectInto(FriendChatWidget:new(chatNode))

	chatWidget:initView(self._mediator, self)

	self._chatWidget = chatWidget
end

function FriendListMediator:setDefaultChatWidget()
	if #self._list > 0 then
		self._chatPanel:setVisible(false)
	end
end

function FriendListMediator:setFriendCount()
	local countLabel1 = self._countPanel:getChildByFullName("Text_count")

	if self._curTabType == kViewTabType.kRecent then
		local recentCount = #self._list
		local maxRecentCount = self._friendModel:getMaxRecentCount()

		countLabel1:setString(recentCount .. "/" .. maxRecentCount)

		if recentCount == 0 then
			self._countPanel:setVisible(false)
		else
			self._countPanel:setVisible(true)
		end
	else
		local friendCount = self._friendModel:getFriendCount(kFriendType.kGame)
		local maxCount = self._friendModel:getMaxFriendsCount()

		countLabel1:setString(friendCount .. "/" .. maxCount)

		if friendCount == 0 then
			self._countPanel:setVisible(false)
		else
			self._countPanel:setVisible(true)
		end
	end
end

function FriendListMediator:createTableView()
	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchForTableview()
		end

		local offset = table:getContentOffset()

		self._fadeImgUp:setVisible(offset.y > table:minContainerOffset().y)
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return self._friendCell:getContentSize().width, self._friendCell:getContentSize().height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._friendCell:clone()

			sprite:setPosition(0, 0)
			cell:addChild(sprite)
			sprite:setVisible(true)
			sprite:setTag(10000)

			local cell_Old = cell:getChildByTag(10000)

			self:refreshFriendCell(cell_Old, idx + 1)
			cell:setTag(idx + 1)
		else
			local cell_Old = cell:getChildByTag(10000)

			self:refreshFriendCell(cell_Old, idx + 1)
			cell:setTag(idx + 1)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._list
	end

	local size, pos = self:getTableViewSize()
	local tableView = cc.TableView:create(size)

	tableView:setTag(1234)

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(pos)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._friendsPanel:addChild(tableView, -1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()
end

function FriendListMediator:getTableViewSize()
	return cc.size(256, 420), cc.p(0, 0)
end

function FriendListMediator:refreshFriendCell(cell, index)
	local friendData = self._list[index]
	local headBg = cell:getChildByName("headimg")

	headBg:removeAllChildren()

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 2,
		clipType = 4,
		headFrameScale = 0.4,
		id = friendData:getHeadId(),
		size = cc.size(84, 84),
		headFrameId = friendData:getHeadFrame()
	})

	oldIcon:setScale(0.4)
	headicon:addTo(headBg):center(headBg:getContentSize())
	headicon:setScale(0.8)
	headBg:setTouchEnabled(true)
	mapButtonHandlerClick(nil, headBg, {
		func = function(sender, eventType)
			self:onClickHead(friendData, sender)
		end
	})

	local nameText = cell:getChildByName("Text_name")

	nameText:setString(friendData:getNickName())

	local levelText = cell:getChildByName("Text_level")

	levelText:setString("Lv." .. friendData:getLevel())
	levelText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	levelText:setLocalZOrder(10)

	local onlineText = cell:getChildByName("Text_online")

	if friendData:getOnline() == false or friendData:getOnline() == 0 then
		local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
		local curTime = gameServerAgent:remoteTimestamp()
		local time = curTime - friendData:getLastOfflineTime()

		onlineText:setString(self._friendSystem:formatOnlineTime(time))
	else
		onlineText:setString(Strings:get("Friend_UI16"))
	end

	cell:removeChildByTag(999)

	local vipNode = PlayerVipWidgetExtend:createWidgetNode()

	self._playerVipWidget = self:getInjector():injectInto(PlayerVipWidgetExtend:new(vipNode))

	self._playerVipWidget:updateView(friendData:getVipLevel())
	vipNode:addTo(cell)
	vipNode:setTag(999)
	vipNode:setScale(0.778)
	vipNode:setPosition(5, 68)

	local receiveBtn = cell:getChildByName("btn_receive")

	local function receiveCallFunc(sender, eventType)
		if friendData:getCanReceive() then
			self:onClickGet(friendData)

			return
		end
	end

	mapButtonHandlerClick(nil, receiveBtn, {
		func = receiveCallFunc
	})
	receiveBtn:setVisible(friendData:getCanReceive())

	if receiveBtn:isVisible() then
		receiveBtn:setVisible(not self._hasSendList[friendData:getRid()])
	end

	local sendBtn = cell:getChildByName("btn_send")

	local function sendCallFunc(sender, eventType)
		if friendData:getCanSend() then
			self:onClickSend(friendData)

			return
		end
	end

	mapButtonHandlerClick(nil, sendBtn, {
		func = sendCallFunc
	})
	sendBtn:setVisible(friendData:getCanSend())

	if sendBtn:isVisible() then
		sendBtn:setVisible(not self._hasSendList[friendData:getRid()])
	end

	cell:setTouchEnabled(true)
	cell:setSwallowTouches(false)

	local function cellCallFunc(sender, eventType)
		self:onCLickFriendCell(friendData, index)

		local redPoint = cell:getChildByName("redPoint")

		if redPoint then
			redPoint:removeFromParent()
		end
	end

	mapButtonHandlerClick(nil, cell, {
		clickAudio = "Se_Click_Select_1",
		func = cellCallFunc
	})

	local selectImg = cell:getChildByName("Image_di_3")

	selectImg:setVisible(self._selectFriendIndex == index)

	if not cell.redPoint then
		local node = NumberRedPoint:createDefaultNode()

		node:setScale(0.8)
		node:setLocalZOrder(10)
		node:setName("redPoint")

		cell.redPoint = NumberRedPoint:new(node, cell, function()
			local channelId = self._friendSystem:getChannelId(self._developSystem:getPlayer():getRid(), friendData:getRid())
			local channel = self._chat:getChannel(channelId)

			channel = channel or self._chat:createChannel(channelId)

			local roomType, roomId = channel:getRoomTypeAndId(self:getInjector())
			local isHasNew, count, max, min = self._friendSystem:hasNewMessage(channel, roomType, roomId)

			if self._curTabType == kViewTabType.kFriend then
				local msgCount = math.max(friendData:getUnReadMsgCount(), count)

				return self._selectFriendIndex ~= index and (friendData:getUnReadMsgCount() > 0 or isHasNew), "", max, min
			else
				return self._selectFriendIndex ~= index and isHasNew, "", max, min
			end
		end)
	end
end

function FriendListMediator:touchForTableview()
	if self._isAskingRequest then
		return
	end

	local kMinRefreshHeight = 35
	local viewHeight = self._tableView:getViewSize().height
	local offsetY = self._tableView:getContentOffset().y

	if (kMinRefreshHeight < offsetY and viewHeight < self._tableView:getContentSize().height and #self._friendList < self._friendModel:getMaxFriendsCount() or nil) and true then
		self._isAskingRequest = true
		self._requestNextCount = #self._friendList

		self:doRequestNextRequest()
	end
end

function FriendListMediator:doRequestNextRequest()
	local dataEnough = #self._friendList < self._friendModel:getMaxFriendsCount(kFriendType.kGame)

	if dataEnough == true then
		local function onRequestRankDataSucc()
			self._list = self._friendModel:getFriendList(kFriendType.kGame)

			if self._requestNextCount then
				local diffCount = #self._friendList - self._requestNextCount
				local kCellHeight = self._friendCell:getContentSize().height
				local offsetY = -diffCount * kCellHeight + kCellHeight * 1

				self._tableView:setContentOffset(cc.p(0, offsetY))
			end

			self._isAskingRequest = false
		end

		local requestStart = #self._friendList + 1
		local requestEnd = requestStart + self._friendModel:getRequestCountPerTime() - 1

		self._friendSystem:requestFriendsList(requestStart, requestEnd, onRequestRankDataSucc, self)
	end
end

function FriendListMediator:refreshView(offset)
	self._friendsPanel:setVisible(true)

	if self._curTabType == kViewTabType.kFriend then
		self:refreshFriendView(offset)
	else
		self:refreshRecentView(offset)
	end

	local tipText = self._noFriendsPanel:getChildByName("Text_29")
	local friendCount = self._friendModel:getFriendCount(kFriendType.kGame)
	local isVisible = #self._list ~= 0 or friendCount ~= 0

	self._main:getChildByName("bg"):setVisible(isVisible)

	if friendCount ~= 0 then
		tipText:setString(Strings:get("Friend_UI52"))
		tipText:setPosition(cc.p(558, 348))
	else
		tipText:setString(Strings:get("Friend_UI31"))
		tipText:setPosition(cc.p(425, 315))
	end

	if self._selectFriendIndex == -1 then
		self._noFriendsPanel:setVisible(true)
	end

	self:refreshNoFriendView()
	self._fadeImgDown:setVisible(self._curTabType == kViewTabType.kFriend and not self._noFriendsPanel:isVisible())
	self:setFriendCount()
end

function FriendListMediator:refreshFriendView(offset)
	self._friendList = self._friendModel:getFriendList(kFriendType.kGame)
	self._list = self._friendList

	if #self._list == 0 then
		self._noFriendsPanel:setVisible(true)
		self._allSendBtn:setVisible(false)
		self._allGetBtn:setVisible(false)
	else
		self._noFriendsPanel:setVisible(false)

		self._chatFriend = self._list[self._selectFriendIndex]

		self._allSendBtn:setVisible(true)
		self._allGetBtn:setVisible(true)
		self._friendModel:getSendTimes()
	end

	self:refreshChatWidget()
	self._tableView:reloadData()

	if offset then
		self._tableView:setContentOffset(offset)
	end
end

function FriendListMediator:refreshRecentView(offset)
	self._recentList = self._friendSystem:getRecentList(self._recentCount)

	if self._curTabType == kViewTabType.kRecent then
		self._list = self._recentList

		self._tableView:reloadData()

		if offset then
			self._tableView:setContentOffset(offset)
		end
	end

	if #self._list == 0 then
		self._noFriendsPanel:setVisible(true)
	else
		self._noFriendsPanel:setVisible(false)

		self._chatFriend = self._list[self._selectFriendIndex]
	end

	self:refreshChatWidget()
	self._allSendBtn:setVisible(false)
	self._allGetBtn:setVisible(false)
end

function FriendListMediator:refreshChatWidget()
	self._chatPanel:setVisible(false)

	if #self._list > 0 and self._chatFriend then
		self._chatPanel:setVisible(true)
		self._chatWidget:updateView(self._chatFriend, self._curTabType)
	end
end

function FriendListMediator:refreshSelectImg()
	local offset = self._tableView:getContentOffset()

	self._tableView:reloadData()
	self._tableView:setContentOffset(offset)
end

function FriendListMediator:refreshNoFriendView()
	local findBtn = self._noFriendsPanel:getChildByFullName("btn_find")
	local friendCount = self._friendModel:getFriendCount(kFriendType.kGame)

	if self._curTabType == kViewTabType.kFriend and friendCount == 0 then
		findBtn:setVisible(true)
	else
		findBtn:setVisible(false)
	end

	local nomsg = self._noFriendsPanel:getChildByFullName("nomsg")

	if self._curTabType == kViewTabType.kRecent and friendCount ~= 0 and #self._list <= 0 then
		nomsg:setVisible(true)

		local tipText = self._noFriendsPanel:getChildByName("Text_29")

		tipText:setString("")
	else
		nomsg:setVisible(false)
	end
end

function FriendListMediator:isHasInRecentFriend(data)
	for i, value in pairs(self._list) do
		if value:getRid() == data:getRid() then
			return true
		end
	end

	return false
end

function FriendListMediator:onCLickFriendCell(data, index)
	if self._tableView:isTouchMoved() then
		return
	end

	if self._selectFriendIndex == index then
		return
	end

	self._noFriendsPanel:setVisible(false)

	self._selectFriendIndex = index
	self._chatFriend = data

	self:refreshChatWidget()
	self:refreshSelectImg()
	data:setUnReadMsgCount(0)
end

function FriendListMediator:onClickFind(sender, eventType)
	self._mediator:changeTabView(kFriendType.kFind)
end

function FriendListMediator:onClickGet(data)
	local bagSystem = self:getInjector():getInstance(BagSystem)
	local maxPowerLimti = bagSystem:getMaxPowerLimit()

	if maxPowerLimti <= bagSystem:getPower() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Friend_Power_FullTips")
		}))

		return
	end

	if data:getCanReceive() then
		if self._friendModel:getReceiveTimes() > 0 then
			self._friendSystem:requestGetPower(data:getRid())

			self._tableOffset = self._tableView:getContentOffset()
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Friend_Tip4", {
					num1 = self._friendSystem:getGiftPowerCount() * self._friendSystem:getGiftMaxGetTimes()
				})
			}))
		end
	end
end

function FriendListMediator:onClickSend(data)
	if data:getCanSend() then
		if self._friendModel:getSendTimes() > 0 then
			self._friendSystem:requestSendPower(data:getRid())

			self._tableOffset = self._tableView:getContentOffset()
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Friend_UI24")
			}))
		end
	end
end

function FriendListMediator:onClickAllGet(sender, eventType)
	local bagSystem = self:getInjector():getInstance(BagSystem)
	local maxPowerLimti = bagSystem:getMaxPowerLimit()

	if maxPowerLimti <= bagSystem:getPower() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Friend_Power_FullTips")
		}))

		return
	end

	if self._friendModel:getReceiveTimes() > 0 then
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		self._friendSystem:requestGetPower("ALL")

		self._tableOffset = self._tableView:getContentOffset()
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Friend_Tip4", {
				num1 = self._friendSystem:getGiftPowerCount() * self._friendSystem:getGiftMaxGetTimes()
			})
		}))
	end
end

function FriendListMediator:onClickAllSend(sender, eventType)
	if self._friendModel:getSendTimes() > 0 then
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		self._friendSystem:requestSendPower("ALL")

		self._tableOffset = self._tableView:getContentOffset()
	else
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Friend_UI24")
		}))
	end
end

function FriendListMediator:onClickHero(sender, eventType)
	self:refreshNoFriendView()
end

function FriendListMediator:onGetFriendListCallback()
	self:refreshView()
end

function FriendListMediator:onGetPowerSuccCallback(event)
	local data = event:getData().response

	for i, value in pairs(data.receiveList) do
		if self._hasgetList[value] == nil then
			self._hasgetList[value] = true
		end
	end

	self:refreshView()
end

function FriendListMediator:onSendPowerSuccCallback(event)
	local data = event:getData().response

	for i, value in pairs(data.sendList) do
		if self._hasSendList[value] == nil then
			self._hasSendList[value] = true
		end
	end

	self:refreshView()
end

function FriendListMediator:onNewMessageCallback(event)
	local oldCount = #self._list

	self._friendList = self._friendModel:getFriendList(kFriendType.kGame)
	self._recentList = self._friendSystem:getRecentList(self._recentCount)

	local viewCount = 0

	if self._curTabType == kViewTabType.kFriend then
		self._list = self._friendList
		viewCount = kFriendViewCount
	else
		if not self:isHasInRecentFriend(self._recentList[1]) then
			self._recentCount = oldCount + 1
			self._recentList = self._friendSystem:getRecentList(self._recentCount)
		end

		self._list = self._recentList
		viewCount = kRecentViewCount
	end

	local oldIndex = self._selectFriendIndex
	local index = 1

	if self._chatFriend then
		for i = 1, #self._list do
			local data = self._list[i]

			if data:getRid() == self._chatFriend:getRid() then
				index = i
			end
		end
	end

	local offset

	if viewCount < #self._list then
		offset = self._tableView:getContentOffset()

		if oldCount ~= #self._list then
			offset = self:getTableViewOffset(index)
		end
	end

	self:refreshView(offset)

	if oldIndex == index then
		self._chatWidget:refreshNewMessage()
	end
end

function FriendListMediator:onDelectFriendCallback(event)
	if self._selectFriendIndex > #self._list then
		self._selectFriendIndex = #self._list
	end

	if #self._list > kFriendViewCount then
		local kCellHeight = self._friendCell:getContentSize().height
		local offset = self._tableView:getContentOffset()

		offset.y = offset.y + kCellHeight

		local maxY = self._tableView:getViewSize().height - self._tableView:getContentSize().height

		if maxY > offset.y then
			offset.y = maxY
		end

		if offset.y > 0 then
			offset.y = 0
		end

		self:refreshView(offset)
	else
		self:refreshView()
	end
end

function FriendListMediator:onChatSendCallback()
	local oldCount = #self._list

	self._friendList = self._friendModel:getFriendList(kFriendType.kGame)
	self._recentList = self._friendSystem:getRecentList(self._recentCount)

	local viewCount = 0

	if self._curTabType == kViewTabType.kFriend then
		self._list = self._friendList
		viewCount = kFriendViewCount
	else
		self._list = self._recentList
		viewCount = kRecentViewCount
	end

	local oldIndex = self._selectFriendIndex
	local index = 1

	if self._chatFriend then
		for i = 1, #self._list do
			local data = self._list[i]

			if data:getRid() == self._chatFriend:getRid() then
				index = i
			end
		end
	end

	self._selectFriendIndex = index

	local offset

	if viewCount < #self._list then
		if self._selectFriendIndex ~= oldIndex then
			offset = self:getTableViewOffset(self._selectFriendIndex)
		elseif oldCount == #self._list then
			offset = self._tableView:getContentOffset()
		end
	end

	self:refreshView(offset)
end

function FriendListMediator:getTableViewOffset(index)
	local kCellHeight = self._friendCell:getContentSize().height
	local offsetY = -(#self._list - index) * kCellHeight
	local maxY = self._tableView:getViewSize().height - self._tableView:getContentSize().height

	if offsetY < maxY then
		offsetY = maxY
	end

	if offsetY > 0 then
		offsetY = 0
	end

	return cc.p(0, offsetY)
end

function FriendListMediator:onApplySuccCallback(event)
	local data = event:getData().response

	self._friendSystem:setHasApplyList(data.addFriends)
	self._chatWidget:updateView(self._chatFriend)
end

function FriendListMediator:onClickHead(data, sender)
	if not data then
		return
	end

	local friendSystem = self:getFriendSystem()

	local function gotoView(response)
		local record = BaseRankRecord:new()

		record:synchronize({
			headImage = data:getHeadId(),
			headFrame = data:getHeadFrame(),
			rid = data:getRid(),
			level = data:getLevel(),
			nickname = data:getNickName(),
			vipLevel = data:getVipLevel(),
			combat = data:getCombat(),
			slogan = data:getSlogan(),
			master = data:getMaster(),
			heroes = data:getHeroes(),
			clubName = data:getUnionName(),
			online = data:getOnline() == ClubMemberOnLineState.kOnline,
			lastOfflineTime = data:getLastOfflineTime(),
			isFriend = response.isFriend,
			close = response.close,
			gender = data:getGender(),
			city = data:getCity(),
			birthday = data:getBirthday(),
			tags = data:getTags(),
			block = response.block,
			leadStageId = data:getLeadStageId(),
			leadStageLevel = data:getLeadStageLevel()
		})
		friendSystem:showFriendPlayerInfoView(record:getRid(), record)
	end

	friendSystem:requestSimpleFriendInfo(data:getRid(), function(response)
		gotoView(response)
	end)
end

function FriendListMediator:onRemoveMessageCallback(data)
	self:refreshView()
end

function FriendListMediator:onBubbleChangeCallback(data)
	self._chatWidget:updateView(self._chatFriend, nil, true)
end
