-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceSwearMainMediator.lua

WordPeaceSwearMainMediator = class("WordPeaceSwearMainMediator", DmAreaViewMediator, _M)

WordPeaceSwearMainMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WordPeaceSwearMainMediator:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")
WordPeaceSwearMainMediator:has("_chat", {
	is = "r"
})
WordPeaceSwearMainMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

function WordPeaceSwearMainMediator:initialize()
	super.initialize(self)
end

function WordPeaceSwearMainMediator:dispose()
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

function WordPeaceSwearMainMediator:onRegister()
	super.onRegister(self)
end

function WordPeaceSwearMainMediator:enterWithData(data)
	data = data or {}
	self._data = data
	self._curTabType = ChatTabType.kWorld
	self._lockScreen = false
	self._newMessageCnt = 0
	self._messageItemCount = 0

	self:setUpView()
	self:setupListView()
	self:setupTopInfoWidget()
	self:setupChatOperatorWidget()
	self:refreshGroupInfos()
	self:checkShowGuideView()

	self._timeScheduler = LuaScheduler:getInstance():schedule(function(task, dt)
		self:update(dt)
	end, 0.03333333333333333, true)

	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_NEW_MESSAGE, self, self.refreshNewMessage)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_MESSAGE_REFRESH, self, self.refreshMessage)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_SWEAR_GROUPINFO_REFRESH, self, self.refreshGroupInfos)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
end

function WordPeaceSwearMainMediator:checkShowGuideView()
	local rid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()
	local value = cc.UserDefault:getInstance():getBoolForKey("WordPeaceGuide_chatSwear" .. rid, false)

	if not value then
		performWithDelay(self:getView(), function()
			local view = self:getInjector():getInstance("WordPeaceGuideView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				showType = "chatSwear"
			}))
		end, 0.2)
		cc.UserDefault:getInstance():setBoolForKey("WordPeaceGuide_chatSwear" .. rid, true)
	end
end

local rankRes = {
	"swear_img_paiming01.png",
	"swear_img_paiming02.png",
	"swear_img_paiming03.png"
}
local campColor = {
	"#fd62ff",
	"#ffe26e",
	"#81cdff"
}

function WordPeaceSwearMainMediator:doReset()
	self._worldPeaceSystem:pullSwearData()
end

function WordPeaceSwearMainMediator:buildUpGroupData()
	local matchGroup = self._worldPeaceSystem:getWorldPeace():getMatchGroup()

	self._worldPeaceSystem:setCampIndex(matchGroup)

	local groupData = self._worldPeaceSystem:getWorldSwearChat():getGroupData()
	local groupRank = self._worldPeaceSystem:getWorldSwearChat():getGroupRank()
	local data = {}

	for k, v in pairs(matchGroup) do
		local celldata = {}

		celldata.camp = v.camp
		celldata.name = v.name or v.groupName
		celldata.point = groupData[v.gId].point
		celldata.gId = v.gId

		local rewards = {}

		for i = 1, 5 do
			rewards[#rewards + 1] = {
				type = 2,
				code = "IB_Arena_Gold_4",
				amount = 45
			}
		end

		celldata.rank = 1

		for k_, v_ in pairs(groupRank) do
			if v_ == v.gId then
				celldata.rank = tonumber(k_)
			end
		end

		celldata.totalRewards = groupData[v.gId].totalRewards
		data[#data + 1] = celldata
	end

	self._groupData = data

	return self._groupData
end

function WordPeaceSwearMainMediator:refreshGroupInfos()
	self:buildUpGroupData()

	self._rewardList = self._rewardList or {}

	table.sort(self._groupData, function(a, b)
		return a.rank < b.rank
	end)

	for k, v in pairs(self._groupData) do
		local root = self:getView():getChildByName("cell0" .. k)
		local rank = root:getChildByName("rankicon")
		local title = root:getChildByName("title")
		local chat = root:getChildByName("chat")
		local score = root:getChildByName("cnt")
		local noReward = root:getChildByName("Text_1")
		local listView = root:getChildByName("ListView")

		listView:setScrollBarEnabled(false)
		rank:ignoreContentAdaptWithSize(true)
		rank:loadTexture("asset/commonRaw/" .. rankRes[v.rank])
		score:setString(v.point)
		title:setString("[" .. v.name .. "]")
		title:setColor(GameStyle:stringToColor(campColor[v.camp]))

		local clubSystem = DmGame:getInstance()._injector:getInstance(ClubSystem)
		local id = clubSystem:getClubInfoOj():getClubId()

		self._rewardList[v.name] = self._rewardList[v.name] or {}

		noReward:setVisible(#v.totalRewards == 0)
		listView:setVisible(#v.totalRewards > 0)
		listView:removeAllChildren()

		local iconScale = 0.5
		local iconWidth = 70
		local maxPerLine = 4
		local rowLayouts = {}

		for i, reward in pairs(v.totalRewards) do
			local icon

			if not self._rewardList[v.name][reward.code] then
				icon = IconFactory:createRewardIcon(reward, {
					showAmount = true,
					isWidget = true
				})

				icon:setScale(iconScale)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
					needDelay = true
				})

				self._rewardList[v.name][reward.code] = icon
				self._rewardList[v.name][reward.code]._amount = reward.amount
			else
				icon = self._rewardList[v.name][reward.code]

				self._rewardList[v.name][reward.code]:setAmount(reward.amount)
				icon:setVisible(true)

				self._rewardList[v.name][reward.code]._amount = reward.amount
			end

			local rowIndex = math.floor((i - 1) / maxPerLine)
			local posInRow = (i - 1) % maxPerLine

			if not rowLayouts[rowIndex] then
				local rowLayout = ccui.Layout:create()

				rowLayout:setContentSize(cc.size(listView:getContentSize().width, 70))
				rowLayout:setAnchorPoint(cc.p(0, 0))

				rowLayouts[rowIndex] = rowLayout

				listView:pushBackCustomItem(rowLayout)
			end

			local rowLayout = rowLayouts[rowIndex]

			icon:removeFromParent(false)
			rowLayout:addChild(icon)

			local x = posInRow * iconWidth + 50
			local y = rowLayout:getContentSize().height / 2

			icon:setPosition(cc.p(x, y))
		end

		for code, icon in pairs(self._rewardList[v.name]) do
			local isUsed = false

			for _, reward in pairs(v.totalRewards) do
				if reward.code == code then
					isUsed = true

					break
				end
			end

			if not isUsed and not tolua.isnull(icon) then
				icon:setVisible(false)
			end
		end

		root:getChildByName("chat"):addClickEventListener(function()
			if id == v.gId then
				self._worldPeaceSystem:tryEnterSwearDetailMain()
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			else
				self._worldPeaceSystem:getOtherClubDetail({
					clubId = v.gId
				}, true, function(data)
					local view = self:getInjector():getInstance("WordPeaceAssociationMainView")

					self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
				end)
			end
		end)

		if id == v.gId then
			root:getChildByFullName("chat"):loadTextures("common_btn_s01.png", "common_btn_s01.png", "common_btn_s01.png", ccui.TextureResType.plistType)
			root:getChildByFullName("chat.name"):setString(Strings:get("Unlock_Chat"))
		else
			root:getChildByFullName("chat"):loadTextures("common_btn_s01.png", "common_btn_s01.png", "common_btn_s01.png", ccui.TextureResType.plistType)
			root:getChildByFullName("chat.name"):setString(Strings:get("Club_Text14"))
		end
	end
end

function WordPeaceSwearMainMediator:clearListView()
	self._listView:removeAllItems()

	self._messageItemCount = 0

	self._listView:onScroll(function(event)
		return
	end)

	self._newMessageCnt = 0
end

function WordPeaceSwearMainMediator:setupListView()
	self:clearListView()

	local channelId = TabTypeToChannelId[7]

	if channelId == nil then
		return
	end

	local channel = self:getChat():getChannel(channelId)

	if channel == nil then
		return
	end

	local messages = channel:getMessages()
	local itemCount = math.min(5, #messages)
	local startIndex = math.max(#messages - itemCount + 1, 1)

	self._syncLoadMessage = coroutine.create(function()
		local time = os.clock()

		for k, v in pairs(messages) do
			self:pushMessageWidget(v, k)

			if os.clock() - time > 0.03333333333333333 then
				time = os.clock()

				coroutine.yield("unfinish")
			end
		end

		coroutine.yield("finish")
		self._listView:jumpToBottom()
	end)
	self._timeList = self._worldPeaceSystem:getTimeList()
end

function WordPeaceSwearMainMediator:update(dt)
	if self._syncLoadMessage and type(self._syncLoadMessage) == "thread" and coroutine.status(self._syncLoadMessage) == "suspended" then
		local success, result = coroutine.resume(self._syncLoadMessage)

		if not success then
			print("协程执行错误:", result)

			self._syncLoadMessage = nil
		elseif result == "finish" then
			self._syncLoadMessage = nil
		end
	end

	if self._timeList then
		if self._enterMaps then
			return
		end

		self._tickTime = self._tickTime or 0
		self._tickTime = self._tickTime + dt

		if self._tickTime > 3 then
			self._tickTime = 0
		else
			return
		end

		self._timeList = self._worldPeaceSystem:getTimeList()

		local battleEnterTime = self._timeList.enterTime
		local curTime = self._gameServerAgent:remoteTimestamp()

		if curTime >= battleEnterTime + 2 then
			self._enterMaps = true

			self._worldPeaceSystem:tryEnterMap(function()
				if checkDependInstance(self) then
					self:dismiss()
				end
			end)
		end
	end
end

local loadMessageLock = false

function WordPeaceSwearMainMediator:onListViewScroll(sender, eventType)
	local innerContainer = self._listView:getInnerContainer()
	local innerContentSize = innerContainer:getContentSize()
	local contentSize = self._listView:getContentSize()
	local innerContainerPos = cc.p(innerContainer:getPosition())

	if not loadMessageLock and contentSize.height + math.abs(innerContainerPos.y) >= innerContentSize.height then
		local channelId = TabTypeToChannelId[7]

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

function WordPeaceSwearMainMediator:insertMessageWidget(message, index)
	local messageWidget = self:createChatMessageWidget(message)
	local messageView = messageWidget:getView()

	self._listView:insertCustomItem(messageView, 0)

	self._messageItemCount = self._messageItemCount + 1

	local channelId = TabTypeToChannelId[7]
	local channel = self:getChat():getChannel(channelId)
	local messages = channel:getMessages()

	if messages[1] and message == messages[1] then
		self:insertTimeText(message)
	elseif self:isShowTime(index) then
		self:insertTimeText(message)
	end
end

local time = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Chat_Time_Space", "content")

function WordPeaceSwearMainMediator:setUpView()
	self._listView = self:getView():getChildByFullName("list")

	self._listView:setScrollBarEnabled(false)
end

function WordPeaceSwearMainMediator:createChatMessageView(message)
	local resFile
	local messageType = message:getType()

	if messageType == MessageType.kPlayer then
		resFile = self:getChatSystem():isMySend(message) and "asset/ui/WordPeaceChatPlayerMessageRight.csb" or "asset/ui/WordPeaceChatPlayerMessageLeft.csb"
	elseif messageType == MessageType.kSystem then
		resFile = "asset/ui/WordPeaceSystemMessage.csb"
	end

	local view = ccui.Layout:create()
	local node = cc.CSLoader:createNode(resFile)

	node:setAnchorPoint(cc.p(0, 1))
	node:addTo(view):setName("main")

	return view
end

function WordPeaceSwearMainMediator:createChatMessageWidget(message)
	local messageView = self:createChatMessageView(message)
	local messageWidget
	local messageType = message:getType()

	if messageType == MessageType.kPlayer then
		messageWidget = PlayerWordPeaceMessageWidget:new(messageView, {
			maxWidth = 480
		})

		self:getInjector():injectInto(messageWidget)
		messageWidget:decorateView(message, self:getChat():getSender(message:getSenderId()), self:getView())
	elseif messageType == MessageType.kSystem then
		messageWidget = WorldPeaceSystemMessageWidget:new(messageView, {
			maxWidth = 480
		})

		self:getInjector():injectInto(messageWidget)
		messageWidget:decorateView(message)
	end

	return messageWidget
end

function WordPeaceSwearMainMediator:isShowTime(index)
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
	local time1 = message1:getTime()
	local time2 = message2:getTime()

	if (time or 600) < (time2 - time1) * 0.001 then
		return true
	end

	return false
end

function WordPeaceSwearMainMediator:pushTimeText(message)
	local fontPath = TTF_FONT_FZYH_M
	local node = ccui.Widget:create()

	node:setAnchorPoint(cc.p(0.5, 0.5))

	local date = TimeUtil:localDate("%Y-%m-%d  %H:%M", message:getTime() * 0.001)
	local timeText = ccui.Text:create(date, fontPath, 18)

	timeText:setAnchorPoint(cc.p(0.5, 0))
	timeText:addTo(node):posite(310, 22)
	node:setContentSize(cc.size(timeText:getContentSize().width, 50))
	self._listView:pushBackCustomItem(node)
end

function WordPeaceSwearMainMediator:insertTimeText(message)
	local fontPath = TTF_FONT_FZYH_M
	local node = ccui.Widget:create()

	node:setAnchorPoint(cc.p(0.5, 0.5))

	local date = TimeUtil:localDate("%Y-%m-%d  %H:%M", message:getTime() * 0.001)
	local timeText = ccui.Text:create(date, fontPath, 16)

	timeText:setAnchorPoint(cc.p(0.5, 0))
	timeText:addTo(node):posite(310, 22)
	setTextWithFontStyle(timeText, "FontSZHText")
	node:setContentSize(cc.size(timeText:getContentSize().width, 50))
	self._listView:insertCustomItem(node, 0)
end

function WordPeaceSwearMainMediator:refreshMessage(event)
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

	local messageWidget = self:createChatMessageWidget(message)
	local messageView = messageWidget:getView()

	self._listView:removeItem(index)
	self._listView:insertCustomItem(messageView, index)
	self._listView:doLayout()
	self._listView:setInnerContainerPosition(innerPos)
end

function WordPeaceSwearMainMediator:pushMessageWidget(message, index, notDoLayout)
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

			goto label_29_0
		end
	end

	if not notDoLayout then
		self._listView:jumpToBottom()
	end

	::label_29_0::
end

function WordPeaceSwearMainMediator:refreshListViewCellVisible()
	return
end

function WordPeaceSwearMainMediator:refreshNewMessage(event)
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

function WordPeaceSwearMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kClubMapPotion
		},
		title = Strings:get("ClubMapBoss_Title01"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function WordPeaceSwearMainMediator:getCurChannel()
	self._curTabType = 2

	local channelId = TabTypeToChannelId[7]

	return (self:getChat():getChannel(channelId))
end

function WordPeaceSwearMainMediator:userInject(injector)
	self._chat = self._chatSystem:getChat()
end

function WordPeaceSwearMainMediator:setupChatOperatorWidget()
	self._main = self:getView()

	local operatorNode = self:getView():getChildByFullName("oprate")
	local chatOperatorWidget = self:getInjector():injectInto(WordPeaceChatOperatorWidget:new(operatorNode))

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
end

function WordPeaceSwearMainMediator:refreshView()
	return
end

function WordPeaceSwearMainMediator:checkItemEnouph(times)
	return
end

function WordPeaceSwearMainMediator:onClickBack()
	self:dismiss()
end
