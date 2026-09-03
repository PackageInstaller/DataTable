-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/view/FriendChatWidget.lua

FriendChatWidget = class("FriendChatWidget", BaseWidget, _M)

FriendChatWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
FriendChatWidget:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")
FriendChatWidget:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
FriendChatWidget:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
FriendChatWidget:has("_chat", {
	is = "r"
})

local KEYBOARD_WILL_SHOW_ACTION_TAG = 1000
local KEYBOARD_WILL_HIDE_ACTION_TAG = 1001

function FriendChatWidget:initialize(view)
	super.initialize(self, view)

	self._main = view
	self._chatPanel = self._main:getChildByName("Chat_Panel")
end

function FriendChatWidget:dispose()
	if self._chatOperatorWidget then
		self._chatOperatorWidget:dispose()

		self._chatOperatorWidget = nil
	end

	local channel = self:getCurChannel()

	if channel then
		self._friendSystem:saveCurReadMessage(channel)
	end

	super.dispose(self)
end

function FriendChatWidget:initView(parentMediator, delegate)
	self._parentMediator = parentMediator
	self._delegate = delegate
	self._parentMain = self._parentMediator:getView():getChildByName("main")
	self._originPos = cc.p(self._parentMain:getPosition())
	self._chat = self._chatSystem:getChat()
	self._player = self._developSystem:getPlayer()
	self._listView = self._chatPanel:getChildByName("ListView")

	self._listView:setScrollBarEnabled(false)
	self._chatPanel:getChildByName("Text_level"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._chatPanel:getChildByName("Text_name"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._chatPanel:getChildByName("Text_1"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._chatPanel:getChildByName("Text_familiarity"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	mapButtonHandlerClick(self, "Chat_Panel.btn_details", {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDetails"
	}, self._main)
	mapButtonHandlerClick(self, "Chat_Panel.btn_delmsg", {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDelMsg"
	}, self._main)
	mapButtonHandlerClick(self, "Chat_Panel.btn_add", {
		clickAudio = "Se_Click_Common_2",
		func = "onClickAddFriends"
	}, self._main)
	mapButtonHandlerClick(self, "Chat_Panel.btn_del", {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDelectFriends"
	}, self._main)
	mapButtonHandlerClick(self, "Chat_Panel.btn_fight", {
		clickAudio = "Se_Click_Common_2",
		func = "onClickPvp"
	}, self._main)
	self:setupChatOperatorWidget()
end

function FriendChatWidget:getChannelId(rid1, rid2)
	local id = "PRIVATE-"

	id = rid2 < rid1 and id .. rid2 .. "-" .. rid1 or id .. rid1 .. "-" .. rid2

	return id
end

function FriendChatWidget:getCurChannel()
	if self._data then
		local channelId = self:getChannelId(self._data:getRid(), self._player:getRid())
		local channel = self:getChat():getChannel(channelId)

		channel = channel or self._chat:createChannel(channelId)

		return channel
	end
end

function FriendChatWidget:setupChatOperatorWidget()
	local operatorNode = self._main:getChildByName("operator_node")

	chatOperatorWidget = self:getInjector():injectInto(ChatOperatorWidget:new(operatorNode))

	local pos = chatOperatorWidget:getView():convertToWorldSpace(cc.p(0, 0))

	chatOperatorWidget.worldPositionY = pos.y

	if chatOperatorWidget then
		local delegate = {}
		local mySelf = self

		function delegate:adaptTextFieldFunc(delta)
			mySelf._listView:offset(0, delta)
		end

		function delegate:getChannel()
			return mySelf:getCurChannel()
		end

		function delegate:refreshMyMessage()
			mySelf:refreshNewMessage()
		end

		local originPos = self._originPos

		function delegate.onShow(sender, event)
			local duration = math.max(0, event.duration)
			local ended = event.ended
			local delta = ended.height - chatOperatorWidget.worldPositionY

			if delta > 0 then
				mySelf._parentMain:stopAllActionsByTag(KEYBOARD_WILL_SHOW_ACTION_TAG)

				local destPos = cc.p(originPos.x, originPos.y + delta)
				local moveToAction = cc.MoveTo:create(duration, destPos)

				moveToAction:setTag(KEYBOARD_WILL_SHOW_ACTION_TAG)
				mySelf._parentMain:runAction(moveToAction)
			end
		end

		function delegate.onHide(sender, event)
			mySelf._parentMain:stopAllActionsByTag(KEYBOARD_WILL_HIDE_ACTION_TAG)

			local duration = math.max(0, event.duration)
			local moveToAction = cc.MoveTo:create(duration, originPos)

			moveToAction:setTag(KEYBOARD_WILL_HIDE_ACTION_TAG)
			mySelf._parentMain:runAction(moveToAction)
		end

		local bg = self._parentMediator._main:getChildByName(self._parentMediator._selectTabName)

		if bg then
			chatOperatorWidget:enterWithData({
				delegate = delegate,
				parentMediator = bg,
				type = KEmotionShowType.KFriend
			})

			self._chatOperatorWidget = chatOperatorWidget
		end
	end
end

function FriendChatWidget:updateView(data, curTabType, forceRefresh)
	if not data then
		return
	end

	self._curTabType = curTabType
	self._hasApplyList = self._friendSystem:getHasApplyList()

	local channel = self:getCurChannel()

	self._friendSystem:saveCurReadMessage(channel)

	local headBg = self._chatPanel:getChildByName("headimg")

	headBg:removeAllChildren(true)
	headBg:setTouchEnabled(true)
	mapButtonHandlerClick(nil, headBg, {
		func = function(sender, eventType)
			self:onClickDetails()
		end
	})

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		clipType = 4,
		headFrameScale = 0.4,
		id = data:getHeadId(),
		size = cc.size(84, 84),
		headFrameId = data:getHeadFrame()
	})

	oldIcon:setScale(0.4)
	headicon:addTo(headBg):center(headBg:getContentSize()):offset(2, 0)
	headicon:setScale(1)

	local nameText = self._chatPanel:getChildByName("Text_name")

	nameText:setString(data:getNickName())
	nameText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local familiarityText1 = self._chatPanel:getChildByName("Text_1")
	local familiarityText = self._chatPanel:getChildByName("Text_familiarity")

	familiarityText1:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	familiarityText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	if data:getFamiliarity() == nil then
		familiarityText1:setString(Strings:get("Friend_UI29"))
		familiarityText:setVisible(false)
	else
		familiarityText:setString(data:getFamiliarity())
		familiarityText:setVisible(true)
		familiarityText1:setString(Strings:get("Friend_UI28"))
	end

	self._main:removeChildByTag(999)

	local vipNode = PlayerVipWidgetExtend:createWidgetNode()

	self._playerVipWidget = self:getInjector():injectInto(PlayerVipWidgetExtend:new(vipNode))

	self._playerVipWidget:updateView(data:getVipLevel())
	vipNode:addTo(self._main)
	vipNode:setTag(999)
	vipNode:setScale(0.97)
	vipNode:setPosition(12, 476)

	local levelText = self._chatPanel:getChildByName("Text_level")

	levelText:setString("Lv." .. data:getLevel())
	levelText:setLocalZOrder(10)
	levelText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local detailsBtn = self._chatPanel:getChildByName("btn_details")
	local delmsgBtn = self._chatPanel:getChildByName("btn_delmsg")

	detailsBtn:setVisible(self._)

	local addBtn = self._chatPanel:getChildByName("btn_add")
	local delBtn = self._chatPanel:getChildByName("btn_del")
	local fightBtn = self._chatPanel:getChildByName("btn_fight")

	if self._data ~= data or forceRefresh then
		self._data = data

		self:setupListView()
	end

	detailsBtn:setVisible(false)
	addBtn:setVisible(false)
	delBtn:setVisible(false)

	local isFriend = self._friendSystem:checkIsFriend(data:getRid())

	delmsgBtn:setVisible(not isFriend)

	local canShowFightBtn = self._friendSystem:getCanShowFightBtn()

	fightBtn:setVisible(isFriend and canShowFightBtn)
	self._chatOperatorWidget:resetEditBoxText()
end

function FriendChatWidget:setupListView()
	self._listView:removeAllItems()

	local channel = self:getCurChannel()

	if channel == nil then
		return
	end

	local messages = channel:getMessages()

	for index, message in ipairs(messages) do
		self:pushMessageWidget(message, index)
	end

	self._listView:jumpToBottom()
end

function FriendChatWidget:pushMessageWidget(message, index)
	if index == 1 then
		self:pushTimeText(message)
	elseif self:isShowTime(index) then
		self:pushTimeText(message)
	end

	local messageWidget = self:createChatMessageWidget(message)

	self._listView:pushBackCustomItem(messageWidget:getView())
	self._listView:jumpToBottom()
end

local time = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Chat_Time_Space", "content")

function FriendChatWidget:isShowTime(index)
	local channel = self:getCurChannel()

	if channel == nil then
		return
	end

	local messages = channel:getMessages()
	local message1 = messages[index - 1]
	local message2 = messages[index]
	local time1 = message1:getTime()
	local time2 = message2:getTime()

	if (time2 - time1) * 0.001 > time then
		return true
	end

	return false
end

function FriendChatWidget:pushTimeText(message)
	local fontPath = "asset/font/CustomFont_FZYH_R.TTF"
	local node = ccui.Widget:create()

	node:setAnchorPoint(cc.p(0, 0))

	local date = TimeUtil:localDate("%Y-%m-%d  %H:%M", message:getTime() * 0.001)
	local timeText = ccui.Text:create(date, fontPath, 16)

	timeText:setAnchorPoint(cc.p(0.5, 0))
	timeText:addTo(node):posite(252, 0)
	timeText:setColor(cc.c3b(147, 137, 135))
	node:setContentSize(timeText:getContentSize())
	self._listView:pushBackCustomItem(node)
end

function FriendChatWidget:refreshNewMessage(event)
	local channel = self:getCurChannel()

	if channel == nil then
		return
	end

	local newMessageCnt = channel:getNewMessageCnt()

	if newMessageCnt == 0 then
		return
	end

	local oldMessages = channel:getMessages()
	local count = #oldMessages
	local messages = channel:getNewMessages()

	for index, message in ipairs(messages) do
		self:pushMessageWidget(message, count - newMessageCnt + index)
	end

	channel:setNewMessageCnt(0)
end

function FriendChatWidget:createChatMessageWidget(message)
	local resFile = self:isMySend(message) and "asset/ui/FriendChatRight.csb" or "asset/ui/FriendChatLeft.csb"
	local view = ccui.Layout:create()
	local node = cc.CSLoader:createNode(resFile)

	node:setAnchorPoint(cc.p(0, 1))
	node:addTo(view):setName("main")

	local bg = self._parentMediator._main:getChildByName(self._parentMediator._selectTabName)
	local messageWidget = PrivateMessageWidget:new(view)

	self:getInjector():injectInto(messageWidget)
	messageWidget:decorateView(message, self:getChat():getSender(message:getSenderId()), bg)

	return messageWidget
end

function FriendChatWidget:isMySend(message)
	return message:getSenderId() == self._player:getRid()
end

function FriendChatWidget:onClickDetails(sender, eventType)
	local friendSystem = self._friendSystem

	local function gotoView(response)
		local record = BaseRankRecord:new()

		record:synchronize({
			headImage = self._data:getHeadId(),
			headFrame = self._data:getHeadFrame(),
			rid = self._data:getRid(),
			level = self._data:getLevel(),
			nickname = self._data:getNickName(),
			vipLevel = self._data:getVipLevel(),
			combat = self._data:getCombat(),
			slogan = self._data:getSlogan(),
			master = self._data:getMaster(),
			heroes = self._data:getHeroes(),
			clubName = self._data:getUnionName(),
			online = self._data:getOnline(),
			offlineTime = self._data:getLastOfflineTime(),
			isFriend = response.isFriend,
			close = response.close,
			gender = self._data:getGender(),
			city = self._data:getCity(),
			birthday = self._data:getBirthday(),
			tags = self._data:getTags(),
			block = response.block,
			leadStageId = self._data:getLeadStageId(),
			leadStageLevel = self._data:getLeadStageLevel()
		})

		record.lastView = "friendChatView"

		friendSystem:showFriendPlayerInfoView(record:getRid(), record)
	end

	friendSystem:requestSimpleFriendInfo(self._data:getRid(), function(response)
		gotoView(response)
	end)
end

function FriendChatWidget:onClickAddFriends(sender, eventType)
	local view = self:getInjector():getInstance("FriendAddPopView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, self._data))
end

function FriendChatWidget:onClickDelectFriends(sender, eventType)
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == AlertResponse.kOK then
			outSelf._friendSystem:requestDeleteFriend(outSelf._data:getRid(), function()
				self:getEventDispatcher():dispatchEvent(ShowTipEvent({
					tip = Strings:get("Friend_Remove_Friend_Succ")
				}))
			end)
		elseif data.response == AlertResponse.kCancel then
			-- block empty
		end
	end

	local data = {
		title = Strings:get("UPDATE_UI7"),
		title1 = Strings:get("UITitle_EN_Tishi"),
		content = Strings:get("Friend_UI33"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data, delegate))
end

function FriendChatWidget:onClickPvp()
	if self._data:getOnline() ~= FriendOnLineState.kOnline then
		self:getEventDispatcher():dispatchEvent(ShowTipEvent({
			tip = Strings:get("Friend_UnLine_FightTip")
		}))

		return
	end

	local friendPvpSystem = self:getInjector():getInstance(FriendPvpSystem)
	local data = {}

	data.inviteFriend = true
	data.inviteFriendId = self._data:getRid()

	friendPvpSystem:tryEnter(data)
end

function FriendChatWidget:onClickDelMsg(sender, eventType)
	local channelId = self:getChannelId(self._data:getRid(), self._player:getRid())

	self._chatSystem:requestRemoveMessage(channelId, self._data:getRid())
end
