-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/chat/view/ChatMainMediator.lua

ChatMainMediator = class("ChatMainMediator", DmPopupViewMediator, _M)

ChatMainMediator:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")
ChatMainMediator:has("_chat", {
	is = "r"
})

local kBtnHandlers = {
	["main.bg.btn_close"] = {
		clickAudio = "Se_Click_Fold_2",
		func = "onClickBack"
	},
	["main.unopen_channel_tip.join_btn.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickJoinUnion"
	},
	["main.chatTable.unread_tip_bar"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickUnreadTip"
	}
}
local TabName = {
	"Chat_Label_System",
	"Chat_Label_World",
	"Chat_Label_Union",
	"Chat_Label_Team"
}
local TabNameTranslate = {
	"UITitle_EN_Xitong",
	"UITitle_EN_Shijie",
	"UITitle_EN_Jieshe",
	"UITitle_EN_Duiwu",
	"UITitle_EN_Duiwu"
}
local TabType = {
	ChatTabType.kSystem,
	ChatTabType.kWorld,
	ChatTabType.kUnion,
	ChatTabType.kCross
}

function ChatMainMediator:initialize()
	super.initialize(self)

	self._curTabType = ChatTabType.kWorld
	self._lockScreen = false
	self._newMessageCnt = 0
	self._messageItemCount = 0
end

function ChatMainMediator:userInject(injector)
	self._chat = self._chatSystem:getChat()
end

function ChatMainMediator:dispose()
	if self._chatOperatorWidget then
		self._chatOperatorWidget:dispose()

		self._chatOperatorWidget = nil
	end

	if self._timeScheduler then
		self._timeScheduler:stop()

		self._timeScheduler = nil
	end

	super.dispose(self)
end

function ChatMainMediator:onRegister()
	super.onRegister(self)
end

function ChatMainMediator:enterWithData(data)
	if data and data.tabType then
		self._curTabType = data.tabType
	end

	self:setUpView()
	self:mapButtonHandlersClick(kBtnHandlers)
	self:glueFieldAndUi()
	self:setupChatOperatorWidget()

	local btnJion = self:bindWidget("main.unopen_channel_tip.join_btn", OneLevelViceButton, {})

	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_NEW_MESSAGE, self, self.refreshNewMessage)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_MESSAGE_REFRESH, self, self.refreshMessage)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_BEGIN, self, self.chatBeginForPlayer)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_AT, self, self.chatAt)
end

function ChatMainMediator:onDoActivityCallBack(event)
	local data = event:getData()

	dump(data, "data___datadata")

	local response = data.response
	local param = data.param

	if param.doActivityType == 101 and param.from == "SpeicalSceneSDChat" then
		local rewards = response.data.reward

		if rewards then
			self:runDropAnim(function()
				local delegate, outSelf = {}, self

				function delegate:willClose(popupMediator, data)
					return
				end

				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 200
				}, {
					rewards = rewards
				}, delegate))
			end)
		end
	end
end

function ChatMainMediator:runDropAnim(endFunca)
	local node = cc.Node:create()

	node:addTo(self._main):offset(300, 100)

	local function endFunc()
		local width = 600
		local changeCount = {
			5,
			10,
			15,
			20
		}
		local changeFactor = math.random(1, #changeCount)
		local showCount = changeCount[changeFactor]

		for i = 1, showCount do
			local factor = math.random(1, 10)
			local posX = (i - 1) * (width / showCount)
			local posY = 440
			local moveTime = math.random(1, 9) * 0.27
			local imgCache = {
				"CD_ico_biscuit.png",
				"CD_ico_candy.png",
				"CD_ico_hat.png",
				"CD_ico_shengdanshu.png"
			}
			local factorIndex = math.random(1, 3)
			local showImg = ccui.ImageView:create("asset/items/" .. imgCache[factorIndex])

			showImg:setScale(0.2)
			showImg:addTo(node):posite(posX, posY)
			showImg:runAction(cc.Sequence:create(cc.MoveTo:create(moveTime, cc.p(posX, 10)), cc.CallFunc:create(function()
				showImg:removeFromParent(true)
			end)))
			showImg:runAction(cc.Sequence:create(cc.DelayTime:create(moveTime - 0.2), cc.FadeOut:create(0.2), cc.CallFunc:create(function()
				if i == showCount then
					-- block empty
				end
			end)))
		end
	end

	node:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(endFunc))))
	self._main:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		node:stopAllActions()

		if endFunca then
			endFunca()
		end
	end)))
end

function ChatMainMediator:setupUIViewHierarchy(data, didFinishLaunching)
	if didFinishLaunching then
		didFinishLaunching(data)
	end

	self._main:getChildByName("chatTable"):setVisible(true)
	self:initTabView()
	delayCallByTime(0.03333333333333333, function()
		local taps = self._tabBtnWidget:getTabBtns()

		if self._curTabType > #taps then
			self._curTabType = 1
		end

		self._tabBtnWidget:selectTabByTag(self._curTabType)
	end)
end

function ChatMainMediator:setUpView()
	self._tabpanel = self:getView():getChildByFullName("main.tabpanel")
	self._unChatChannelTip = self:getView():getChildByFullName("main.unChat_channel_tip")

	if self._curTabType == ChatTabType.kSystem then
		local var_16_0 = Strings:get("unchatMessage_tips_1")

		if not var_16_0 then
			var_16_0 = Strings:get("unchatMessage_tips_2")

			local str = var_16_0

			self._unChatChannelTip:getChildByFullName("tip_text"):setString(str)
			self._unChatChannelTip:setVisible(true)
		end
	end
end

function ChatMainMediator:initTabView()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #TabName do
		data[#data + 1] = {
			realTabType = TabType[i],
			tabText = Strings:get(TabName[i]),
			tabTextTranslate = Strings:get(TabNameTranslate[i]),
			fontTextOffset = {
				0,
				-2
			},
			redPointFunc = function()
				return self._chat:hasRedPoint(TabTypeToChannelId[TabType[i]])
			end
		}
	end

	if self._chatSystem:isWordPeaceChatActive() then
		data[#data + 1] = {
			realTabType = ChatTabType.kWordPeace,
			tabText = Strings:get("Chat_Label_Scramble"),
			tabTextTranslate = Strings:get("Chat_Label_Scramble"),
			fontTextOffset = {
				0,
				-2
			},
			redPointFunc = function()
				return self._chat:hasRedPoint(TabTypeToChannelId[ChatTabType.kWordPeace])
			end
		}
	end

	self._chatTabData = data
	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 500)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = false
	})
	self._tabBtnWidget:removeTabBg()

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(5, 0)
	view:setLocalZOrder(1100)
end

function ChatMainMediator:glueFieldAndUi()
	self._systemKeeper = self:getInjector():getInstance("SystemKeeper")
	self._main = self:getView():getChildByFullName("main")
	self._main.originPos = cc.p(self._main:getPosition())
	self._listView = self._main:getChildByFullName("chatTable.list_view")

	self._listView:setScrollBarEnabled(false)

	self._innerPos = self._listView:getInnerContainerPosition()
	self._systemOperatorNode = self._main:getChildByFullName("system_operator_node")

	self._systemOperatorNode:setVisible(false)

	self._unopenChannelTip = self._main:getChildByFullName("unopen_channel_tip")

	self._unopenChannelTip:setVisible(false)

	self._unreadTipBar = self._main:getChildByFullName("chatTable.unread_tip_bar")

	self._unreadTipBar:setVisible(false)
	self._main:getChildByName("chatTable"):setVisible(false)

	self._atMeTip = self._main:getChildByFullName("chatTable.atMeTip")

	self._atMeTip:setVisible(false)
	self._atMeTip:addClickEventListener(function()
		self:clickAtMe()
	end)

	self._atMeTipBg = self._atMeTip:getChildByFullName("bg")
end

function ChatMainMediator:getCurChannel(index)
	if self._chatTabData then
		if not self._chatTabData[index or self._curTabType].realTabType then
			local realTabType = self._curTabType
			local channelId = TabTypeToChannelId[realTabType]

			return (self:getChat():getChannel(channelId))
		end
	end
end

function ChatMainMediator:setupChatOperatorWidget()
	local operatorNode = self._main:getChildByFullName("operator_node")
	local chatOperatorWidget = self:getInjector():injectInto(ChatOperatorWidget:new(operatorNode))

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
			if checkDependInstance(mySelf) then
				mySelf:refreshNewMessage()
			end
		end

		local originPos = self._main.originPos

		function delegate.onShow(sender, event)
			local duration = math.max(0, event.duration)
			local ended = event.ended
			local delta = ended.height - chatOperatorWidget:getView():getPositionY()

			if delta > 0 then
				local destPos = cc.p(originPos.x, originPos.y + delta)
				local moveToAction = cc.MoveTo:create(duration, destPos)

				mySelf._main:stopAllActions()
				mySelf._main:runAction(moveToAction)
			end
		end

		function delegate.onHide(sender, event)
			local duration = math.max(0, event.duration)
			local moveToAction = cc.MoveTo:create(duration, originPos)

			mySelf._main:stopAllActions()
			mySelf._main:runAction(moveToAction)
		end

		chatOperatorWidget:enterWithData({
			delegate = delegate,
			parentMediator = self._main,
			type = KEmotionShowType.KChat
		})

		self._chatOperatorWidget = chatOperatorWidget
	end

	local tiptext = self._systemOperatorNode:getChildByFullName("tip_text")
	local selfFilterBtn = self._systemOperatorNode:getChildByFullName("selfFilter_bg.self_filter_btn")

	selfFilterBtn:setSelected(self:getChatSystem():isOnlyShowSelf())
	selfFilterBtn:addEventListener(function(sender, eventType)
		self:onClickFliterSelf(sender, eventType)
	end)

	local selftext = self._systemOperatorNode:getChildByFullName("selfFilter_bg.self_text")
end

function ChatMainMediator:clearListView()
	self._listView:removeAllItems()

	self._messageItemCount = 0
	self._atMsgItem = nil

	self._listView:onScroll(function(event)
		return
	end)

	self._newMessageCnt = 0
end

function ChatMainMediator:onClickTab(name, tag)
	self._curTabType = tag

	if self._curTabType == ChatTabType.kSystem then
		self._chatOperatorWidget:setVisible(false)
		self._systemOperatorNode:setVisible(true)
		self._unChatChannelTip:setVisible(true)
		self._unChatChannelTip:getChildByFullName("tip_text"):setString(Strings:get("unchatMessage_tips_1"))
	else
		self._chatOperatorWidget:setVisible(true)
		self._systemOperatorNode:setVisible(false)
		self._unChatChannelTip:setVisible(true)
		self._unChatChannelTip:getChildByFullName("tip_text"):setString(Strings:get("unchatMessage_tips_2"))
	end

	self:setLockScreen(false)
	self:getChatSystem():updateActiveMember()
	self:setupListView()

	local channel = self:getCurChannel()

	channel:setNewMessageCnt(0)
end

function ChatMainMediator:setupListView()
	self:clearListView()

	local channelId = TabTypeToChannelId[self._chatTabData[self._curTabType].realTabType]

	if channelId == nil then
		return
	end

	if channelId == ChannelId.kUnion then
		local clubSystem = self:getInjector():getInstance("ClubSystem")

		if not clubSystem:getHasJoinClub() then
			self._unopenChannelTip:setVisible(true)

			local tipText = self._unopenChannelTip:getChildByFullName("tip_text")

			tipText:setString(Strings:get("Chat_Text2"))

			local joinBtn = self._unopenChannelTip:getChildByFullName("join_btn")

			joinBtn:setVisible(true)
			self._unChatChannelTip:setVisible(false)

			return
		end
	elseif channelId == ChannelId.kTeam then
		self._unopenChannelTip:setVisible(true)

		local tipText = self._unopenChannelTip:getChildByFullName("tip_text")

		tipText:setString(Strings:get("Chat_Text6"))

		local joinBtn = self._unopenChannelTip:getChildByFullName("join_btn")

		joinBtn:setVisible(false)
		self._unChatChannelTip:setVisible(false)

		return
	end

	self._unopenChannelTip:setVisible(false)

	local channel = self:getChat():getChannel(channelId)

	if channel == nil then
		return
	end

	local messages = channel:getMessages()
	local itemCount = math.min(4, #messages)
	local endIndex = #messages
	local startIndex = math.max(#messages - itemCount + 1, 1)

	for index = startIndex, endIndex do
		local function func()
			local message = messages[index]

			self:pushMessageWidget(message, index)
		end

		if not self._isInit then
			self._listView:runAction(DelayAction:create(func, 0.01 * (index - startIndex + 1)))
		else
			func()
		end
	end

	self._isInit = true
	self._newMessageCnt = 0

	self._listView:jumpToBottom()
	self._listView:onScroll(function(event)
		self:onListViewScroll(event)

		self._innerPos = self._listView:getInnerContainerPosition()
	end)
end

function ChatMainMediator:createChatMessageView(message)
	local resFile
	local messageType = message:getType()

	if messageType == MessageType.kPlayer then
		resFile = self:getChatSystem():isMySend(message) and "asset/ui/ChatPlayerMessageRight.csb" or "asset/ui/ChatPlayerMessageLeft.csb"
	elseif messageType == MessageType.kSystem then
		resFile = "asset/ui/SystemMessage.csb"
	end

	local view = ccui.Layout:create()
	local node = cc.CSLoader:createNode(resFile)

	node:setAnchorPoint(cc.p(0, 1))
	node:addTo(view):setName("main")

	return view
end

function ChatMainMediator:createChatMessageWidget(message)
	local messageView = self:createChatMessageView(message)

	messageView.data = message

	local messageWidget
	local messageType = message:getType()

	if messageType == MessageType.kPlayer then
		messageWidget = PlayerMessageWidget:new(messageView)

		self:getInjector():injectInto(messageWidget)
		messageWidget:decorateView(message, self:getChat():getSender(message:getSenderId()), self:getView())
	elseif messageType == MessageType.kSystem then
		messageWidget = SystemMessageWidget:new(messageView)

		self:getInjector():injectInto(messageWidget)
		messageWidget:decorateView(message)
	end

	return messageWidget
end

local time = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Chat_Time_Space", "content")

function ChatMainMediator:isShowTime(index)
	local channel = self:getCurChannel()

	if channel == nil then
		return
	end

	local messages = channel:getMessages()
	local message1 = messages[index - 1]

	if not message1 then
		local str = "index:" .. tostring(index) .. "curTab:" .. tostring(self._curTabType)

		CommonUtils.uploadDataToBugly("ChatDebug", str)
	end

	local message2 = messages[index]

	if message1 and message2 then
		local time1 = message1:getTime()
		local time2 = message2:getTime()

		if (time or 600) < (time2 - time1) * 0.001 then
			return true
		end
	end

	return false
end

function ChatMainMediator:pushTimeText(message)
	local fontPath = "asset/font/CustomFont_FZYH_R.TTF"
	local node = ccui.Widget:create()

	node:setAnchorPoint(cc.p(0.5, 0.5))

	local date = TimeUtil:localDate("%Y-%m-%d  %H:%M", message:getTime() * 0.001)
	local timeText = ccui.Text:create(date, fontPath, 16)

	timeText:setAnchorPoint(cc.p(0.5, 0))
	timeText:setTextColor(cc.c3b(147, 137, 135))
	timeText:addTo(node):posite(415, 22)
	node:setContentSize(cc.size(timeText:getContentSize().width, 50))
	self._listView:pushBackCustomItem(node)
end

function ChatMainMediator:insertTimeText(message)
	local fontPath = "asset/font/CustomFont_FZYH_R.TTF"
	local node = ccui.Widget:create()

	node:setAnchorPoint(cc.p(0.5, 0.5))

	local date = TimeUtil:localDate("%Y-%m-%d  %H:%M", message:getTime() * 0.001)
	local timeText = ccui.Text:create(date, fontPath, 16)

	timeText:setAnchorPoint(cc.p(0.5, 0))
	timeText:setTextColor(cc.c3b(147, 137, 135))
	timeText:addTo(node):posite(415, 22)
	node:setContentSize(cc.size(timeText:getContentSize().width, 50))
	self._listView:insertCustomItem(node, 0)
end

function ChatMainMediator:pushMessageWidget(message, index, notDoLayout)
	self._unChatChannelTip:setVisible(false)

	if index == 1 then
		self:pushTimeText(message)
	elseif self:isShowTime(index) then
		self:pushTimeText(message)
	end

	local innerContainer = self._listView:getInnerContainer()
	local y = innerContainer:getPositionY()
	local messageWidget = self:createChatMessageWidget(message)
	local messageView = messageWidget:getView()

	self._listView:pushBackCustomItem(messageView)

	self._messageItemCount = self._messageItemCount + 1

	if self._lockScreen then
		if not self:getChatSystem():isMySend(message) then
			self._newMessageCnt = self._newMessageCnt + 1
			y = y - messageView:getContentSize().height

			self._listView:doLayout()
			innerContainer:setPositionY(y)

			goto label_42_0
		end
	end

	if not notDoLayout then
		self._listView:jumpToBottom()
	end

	::label_42_0::
end

function ChatMainMediator:insertMessageWidget(message, index)
	local messageWidget = self:createChatMessageWidget(message)
	local messageView = messageWidget:getView()

	self._listView:insertCustomItem(messageView, 0)

	self._messageItemCount = self._messageItemCount + 1

	local realTabType = self._chatTabData[self._curTabType].realTabType
	local channelId = TabTypeToChannelId[realTabType]
	local channel = self:getChat():getChannel(channelId)
	local messages = channel:getMessages()

	if messages[1] and message == messages[1] then
		self:insertTimeText(message)
	elseif self:isShowTime(index) then
		self:insertTimeText(message)
	end
end

function ChatMainMediator:refreshNewMessage(event)
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
	self:refreshListViewCellVisible()
end

function ChatMainMediator:refreshUnreadTipView()
	if self._lockScreen and self._newMessageCnt > 0 then
		self._unreadTipBar:setVisible(true)

		local tipText = self._unreadTipBar:getChildByFullName("tip_text")
		local count = self._newMessageCnt > 99 and "99+" or self._newMessageCnt

		tipText:setString(Strings:get("Chat_Text9", {
			newMessageCnt = count
		}))
	else
		self._unreadTipBar:setVisible(false)
	end
end

function ChatMainMediator:refreshMessage(event)
	if DisposableObject:isDisposed(self) then
		return
	end

	local innerSize = self._listView:getInnerContainerSize()
	local innerPos = self._listView:getInnerContainerPosition()
	local data = event:getData()

	if not data.item then
		return
	end

	local message = data.message
	local index = self._listView:getIndex(data.item)

	if index == -1 then
		return
	end

	local _atIndex = self._listView:getIndex(self._atMsgItem)

	if _atIndex == index then
		self._atMsgItem = nil
	end

	local messageWidget = self:createChatMessageWidget(message)
	local messageView = messageWidget:getView()

	self._listView:removeItem(index)
	self._listView:insertCustomItem(messageView, index)
	self._listView:doLayout()
	self._listView:setInnerContainerPosition(innerPos)
end

function ChatMainMediator:setLockScreen(isLock)
	self._lockScreen = isLock

	if not isLock then
		self._listView:jumpToBottom()
	end

	self._newMessageCnt = isLock == false and 0 or self._newMessageCnt

	self:refreshUnreadTipView()
end

function ChatMainMediator:flyInAnim()
	local rowPos = self._main.originPos

	self._main:setPosition(cc.p(rowPos.x - 700, rowPos.y))
	self._main:runAction(cc.MoveTo:create(0.1, cc.p(rowPos.x, rowPos.y)))
end

function ChatMainMediator:flyOutAnim()
	local rowPos = self._main.originPos

	self._main:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(rowPos.x - 700, rowPos.y)), cc.CallFunc:create(function()
		self:close()
	end)))
end

function ChatMainMediator:onClickFliterSelf(sender, eventType)
	local realTabType = self._chatTabData[self._curTabType].realTabType
	local channelId = TabTypeToChannelId[realTabType]
	local channel = self:getChat():getChannel(channelId)

	if channel == nil then
		return
	end

	if channel:getType() ~= ChannelType.kFilter then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	if eventType == ccui.CheckBoxEventType.selected then
		channel:modifyFilterRule(ChannelId.kSystem, false)
		self:getChatSystem():setIsOnlyShowSelf(true)
	elseif eventType == ccui.CheckBoxEventType.unselected then
		channel:modifyFilterRule(ChannelId.kSystem, true)
		self:getChatSystem():setIsOnlyShowSelf(false)
	end

	self:setupListView()
end

function ChatMainMediator:onClickBack(sender, eventType)
	if not self._chatOperatorWidget:isIMEOpen() then
		self:close()
	end
end

function ChatMainMediator:onTouchMaskLayer()
	self:onClickBack()
end

function ChatMainMediator:onClickJoinUnion(sender, eventType)
	local unlock, tips = self._systemKeeper:isUnlock("Club_System")

	if unlock then
		local clubSystem = self:getInjector():getInstance(ClubSystem)

		clubSystem:requestClubInfo(function()
			local view = self:getInjector():getInstance("ClubView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
			self:close()
		end)
	else
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
	end
end

function ChatMainMediator:onClickUnreadTip(sender, eventType)
	self:setLockScreen(false)
end

local loadMessageLock = false

function ChatMainMediator:onListViewScroll(sender, eventType)
	local innerContainer = self._listView:getInnerContainer()
	local innerContentSize = innerContainer:getContentSize()
	local contentSize = self._listView:getContentSize()
	local innerContainerPos = cc.p(innerContainer:getPosition())

	if innerContainerPos.y < -0.001 then
		self:setLockScreen(true)
	else
		self:setLockScreen(false)
	end

	if not loadMessageLock and contentSize.height + math.abs(innerContainerPos.y) >= innerContentSize.height then
		local realTabType = self._chatTabData[self._curTabType].realTabType
		local channelId = TabTypeToChannelId[realTabType]

		if channelId == nil then
			return
		end

		local channel = self:getChat():getChannel(channelId)

		if channel == nil then
			return
		end

		loadMessageLock = true

		local messages = channel:getMessages()
		local loadCount = 1
		local endIndex = #messages - self._messageItemCount

		if endIndex > 0 then
			local startIndex = math.max(endIndex - loadCount + 1, 1)

			for k = startIndex, endIndex do
				local message = messages[k]

				self:insertMessageWidget(message, k)
			end

			self._listView:doLayout()
			innerContainer:setPosition(innerContainerPos)
		end

		loadMessageLock = false
	end

	self:refreshListViewCellVisible()
end

function ChatMainMediator:refreshListViewCellVisible()
	return
end

function ChatMainMediator:chatBeginForPlayer(event)
	if self._chatOperatorWidget then
		self._chatOperatorWidget:chatBeginForPlayer(event)
	end
end

function ChatMainMediator:getCurrentViewHasAt()
	local bottommostItem = self._listView:getBottommostItemInCurrentView()
	local topmostItem = self._listView:getTopmostItemInCurrentView()

	if bottommostItem and topmostItem then
		local bottommostItemIndex = self._listView:getIndex(bottommostItem)
		local topmostItemIndex = self._listView:getIndex(topmostItem)

		for i = topmostItemIndex, bottommostItemIndex do
			local item = self._listView:getItem(i)

			if item.data and item.data:getIsAt() then
				return i
			end
		end
	end

	return 0
end

function ChatMainMediator:getCurrentViewIndex()
	local bottommostItem = self._listView:getBottommostItemInCurrentView()
	local topmostItem = self._listView:getTopmostItemInCurrentView()

	if bottommostItem and topmostItem then
		local bottommostItemIndex = self._listView:getIndex(bottommostItem)
		local topmostItemIndex = self._listView:getIndex(topmostItem)

		return bottommostItemIndex, topmostItemIndex
	end

	return 0
end

function ChatMainMediator:chatAt(event)
	if DisposableObject:isDisposed(self) then
		return
	end

	self._atIndex = self:getAtMsgIndex()

	dump(self._atIndex, " @@@@@chatAt self._atIndex ============ ")

	if self._atIndex > 0 then
		self._atMeTip:setVisible(true)

		if not self._atMsgItem or DisposableObject:isDisposed(self._atMsgItem) then
			self._atMeTipBg:setScaleY(-1)
		else
			local y = self._atMsgItem:getPositionY()
			local bottommostItem = self._listView:getBottommostItemInCurrentView()
			local by = bottommostItem:getPositionY()
			local topmostItem = self._listView:getTopmostItemInCurrentView()
			local ty = topmostItem:getPositionY()

			if ty < y then
				self._atMeTipBg:setScaleY(-1)
			elseif y < by then
				self._atMeTipBg:setScaleY(1)
			else
				self._atMeTip:setVisible(false)

				local realTabType = self._chatTabData[self._curTabType].realTabType

				self._chat:setAtMessage(nil, TabTypeToChannelId[realTabType])
			end
		end
	else
		self._atMeTip:setVisible(false)
	end

	if self._atMeTip:isVisible() then
		self._unreadTipBar:setVisible(false)
	end

	self._tabBtnWidget:refreshAllRedPoint()
end

function ChatMainMediator:getAtMsgIndex()
	local index = 0
	local channel = self:getCurChannel()
	local messages = channel:getMessages()

	for i = #messages, 1, -1 do
		if messages[i]:getIsAt() then
			index = #messages - i + 1

			break
		end
	end

	return index
end

function ChatMainMediator:clickAtMe()
	local function clear()
		if self._atIndex > 0 then
			self._atMsgItem = nil

			local realTabType = self._chatTabData[self._curTabType].realTabType

			self._chat:setAtMessage(nil, TabTypeToChannelId[realTabType])
		end
	end

	if self._atIndex > self._messageItemCount then
		local channel = self:getCurChannel()
		local messages = channel:getMessages()

		for i = self._messageItemCount, self._atIndex do
			local function func()
				self:insertMessageWidget(messages[i], i)

				if i == self._atIndex then
					self._listView:jumpToTop()
					clear()
				end
			end

			self._listView:runAction(DelayAction:create(func, 0.001 * (i - 1)))
		end
	elseif self._atMsgItem and not DisposableObject:isDisposed(self._atMsgItem) then
		local index = self._listView:getIndex(self._atMsgItem)

		self._listView:scrollToItem(index, cc.p(0, 0), cc.p(0, 0), 1)
		clear()
	end
end
