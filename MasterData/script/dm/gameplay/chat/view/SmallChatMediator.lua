-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/chat/view/SmallChatMediator.lua

SmallChatMediator = class("SmallChatMediator", DmPopupViewMediator, _M)

SmallChatMediator:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")
SmallChatMediator:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")

function SmallChatMediator:initialize()
	super.initialize(self)

	self._runningNewMsg = {}
	self._suspendedNewMsg = {}
	self._tag = 0
end

function SmallChatMediator:dispose()
	self._shareMessageWidget:dispose()
	super.dispose(self)
end

function SmallChatMediator:onRegister()
	super.onRegister(self)

	self.channelListeners = {}

	local messageView = SimpleMessageWidget:createWidgetNode()

	self._shareMessageWidget = SimpleMessageWidget:new(messageView)
	self.pl_main = self:getView():getChildByFullName("chatPanel.text_panel")

	self._shareMessageWidget:getView():addTo(self.pl_main)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHAT_NEW_MESSAGE, self, self.receiveNewMessage)
end

function SmallChatMediator:setChatItemContent(size)
	self._chatItemSize = size
end

function SmallChatMediator:setChatBgSize(size)
	local bg = self:getView():getChildByFullName("chatPanel.Image_11")

	bg:setContentSize(size)
end

function SmallChatMediator:initWidget()
	self.btn_chat = self:getView():getChildByFullName("btn_chat")

	self.btn_chat:addClickEventListener(function()
		self:openMessageBox()
	end)

	self._passPanel = self:getView():getChildByFullName("passPanel")

	if self._passPanel ~= nil and CommonUtils.GetSwitch("fn_pass") then
		local anim = cc.MovieClip:create("m1_tongxingzhengrukou")

		anim:addEndCallback(function(cid, mc)
			anim:stop()
		end)
		anim:addTo(self._passPanel):center(self._passPanel:getContentSize())
		self._passPanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				-- block empty
			elseif eventType == ccui.TouchEventType.ended then
				self._passSystem:showMainPassView()
			end
		end)
	end
end

function SmallChatMediator:enterWithData(data)
	self:initWidget()
end

function SmallChatMediator:openMessageBox()
	AudioEngine:getInstance():playEffect("Se_Click_Fold_1", false)

	local data = {}
	local view = self:getInjector():getInstance("chatMainView")

	if self._messageBoxType then
		data.tabType = self._messageBoxType
	end

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end

function SmallChatMediator:setMessageBoxType(tabType)
	self._messageBoxType = tabType
end

function SmallChatMediator:refreshAll()
	return
end

function SmallChatMediator:isShowMessage(message)
	for _, v in pairs(message:getChannelIds()) do
		if v == TabTypeToChannelId[6] then
			return false
		end
	end

	if #self._filterList == 0 then
		return true
	end

	for i, tabType in pairs(self._filterList) do
		local channelId = TabTypeToChannelId[tabType]

		for _, v in pairs(message:getChannelIds()) do
			if channelId == v then
				return true
			end
		end
	end
end

function SmallChatMediator:receiveNewMessage(event)
	local message = event:getData().message

	if message and not message:isPrivateMessage() then
		local msgTab = self:getRunningNewMsgTab()

		msgTab[#msgTab + 1] = message

		if not self._isRunning then
			self:startShowNewMessage()
		end
	end
end

function SmallChatMediator:receiveHistoryMessage(event)
	if self._syncHistory then
		return
	end

	self._syncHistory = true

	local messages = event:getData().message

	if not messages or not next(messages) then
		return
	end

	local ret = {}

	for i = #messages, 1, -1 do
		local message = messages[i]

		if message and not message:isPrivateMessage() then
			table.insert(ret, message)

			if #ret > 2 then
				break
			end
		end
	end

	if not next(ret) then
		return
	end

	local msgTab = self:getRunningNewMsgTab()

	for i = #ret, 1, -1 do
		msgTab[#msgTab + 1] = ret[i]
	end

	if not self._isRunning then
		self:startShowNewMessage()
	end
end

function SmallChatMediator:getRunningNewMsgTab()
	if self._tag == 0 then
		return self._runningNewMsg, self._tag
	else
		return self._suspendedNewMsg, self._tag
	end
end

function SmallChatMediator:swapNewMsgTab()
	self._tag = self._tag == 0 and 1 or 0
end

local scrollTime = 0.3
local messageShowTime = 1

function SmallChatMediator:startShowNewMessage()
	self._isRunning = true

	local msgTab, tag = self:getRunningNewMsgTab()

	self:swapNewMsgTab()

	local contentLayoutSize = self.pl_main:getContentSize()
	local messageView = self._shareMessageWidget:getView()

	messageView:stopAllActions()

	local index = 1
	local actions = {}

	actions[#actions + 1] = cc.CallFunc:create(function()
		local message = msgTab[index]

		if message then
			local sender

			self._shareMessageWidget:decorateView(message, (message:getType() == MessageType.kPlayer or nil) and self._chatSystem:getChat():getSender(message:getSenderId()))

			local viewSize = messageView:getContentSize()

			messageView:setPosition(cc.p(0, -(viewSize.height / 2)))

			index = index + 1
		end
	end)
	actions[#actions + 1] = cc.MoveTo:create(scrollTime, cc.p(0, contentLayoutSize.height - 5))
	actions[#actions + 1] = cc.DelayTime:create(messageShowTime)

	local repeatAct = cc.Repeat:create(cc.Sequence:create(unpack(actions)), #msgTab)

	messageView:runAction(repeatAct)

	if tag == 0 then
		self._runningNewMsg = {}
	else
		self._suspendedNewMsg = {}
	end

	self._isRunning = false
end
