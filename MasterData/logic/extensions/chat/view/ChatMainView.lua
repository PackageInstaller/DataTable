-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatMainView.lua

module("logic.extensions.chat.view.ChatMainView", package.seeall)

local M = class("ChatMainView", ViewComponent)

M.SubViewType = {
	Friend = GameEnum.ChannelTypeEnum.Friend,
	Team = GameEnum.ChannelTypeEnum.Team,
	Guild = GameEnum.ChannelTypeEnum.Guild
}

local kSystemIdList = {
	GameEnum.SystemEnum.Friend,
	90000,
	GameEnum.SystemEnum.Guild
}
local cameraCode = 13
local movePos = Vector3.New(-9, -1, 30)

function M:ctor(...)
	M.super.ctor(self, ...)

	self._relationType = GameEnum.RelationTypeEnum.Friend
	self._chatMoList = {}
	self._params = false
end

function M:buildUI()
	self._friendScrollGo = self:getGo("chat_main_view_1812014172")
	self._friendLoopList = LoopListHelper.New(self._friendScrollGo)

	self._friendLoopList:InitListView(0, self._updateFrinedCell, self)

	self._scrollAdapter = self:getScrollRect("chat_main_view_694640116")
	self._chatScrollGo = self:getGo("chat_main_view_694640116")
	self._chatLoopList = LoopListHelper.New(self._chatScrollGo)

	self._chatLoopList:InitListView(0, self._updateChatCell, self)

	self._contentTRF = goutil.findChild(self._chatScrollGo, "ViewPort/Content").transform
	self._toggltTabList = {}

	for index = 1, #kSystemIdList do
		local go = goutil.findChild(self.mainGO, "chat_panel/leftTabList/tab_" .. index)
		local tabView = Astral.LuaComponentContainer.Add(go, ChatTabView)

		table.insert(self._toggltTabList, tabView)

		local isOpen = SystemOpenFacade.instance:isOpen(kSystemIdList[index])

		tabView:setStatus(isOpen and ChatTabView.Status.Off or ChatTabView.Status.Disable)
		tabView:AddListener(function(self)
			self:_onClickTab(index)
		end, self)
	end

	self._txtTopHint1 = self:getText("chat_main_view_748777457")
	self._btnBack = self:getBtn("chat_main_view_942841972")
	self._topGo = self:getGo("chat_main_view_1902883513")
	self._newChatHintGo = self:getGo("chat_main_view_1982730086")

	self._newChatHintGo:SetActive(false)

	self._txtNewChatHint = self:getText("chat_main_view_2140693706")
	self._btnJumpBottom = self:getBtn("chat_main_view_1293331391")
	self._btnClose = self:getBtn("chat_main_view_1000467822")
	self._inputField = self:getInput("chat_main_view_-1017699085")
	self._btnSend = self:getBtn("chat_main_view_-1001451271")
	self._downGo = self:getGo("chat_main_view_925640396")
	self._tipsPosGo = self:getGo("chat_main_view_794476948")
	self._toggleBtnFace = self:getUIComponent("chat_main_view_1701004614", UIComponentType.SpaceXToggle)

	local emojiPanelGo = self:getGo("chat_main_view_1024225480")

	self._emojiView = Astral.LuaComponentContainer.Add(emojiPanelGo, ChatEmojiView)
	self._emptyGo = self:getGo("chat_main_view_-2069637350")

	local guildGo = goutil.findChild(self.mainGO, "chat_panel/leftTabList/tab_3")

	goutil.setActive(guildGo, false)
end

function M:bindEvents()
	self._scrollAdapter:AddOnValueChanged(self._onScrollValChanged, self)
	self._btnClose:AddClickListener(self._onClickBtnBack, self)
	self._btnBack:AddClickListener(self._onClickBtnBack, self)
	self._btnJumpBottom:AddClickListener(self._onClickBtnJumpBottom, self)
	self._btnSend:AddClickListener(self._onClickBtnSend, self)
	self._toggleBtnFace:AddListener(self._onClickToggleBtnFace, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_FRIEND_LIST, self._onUpdateFriendList, self)
	GlobalDispatcher:addEventListener(EventType.CHAT_MESSAGE_UPDATE, self._handleMessageUpdate, self)
	GlobalDispatcher:addEventListener(EventType.CHAT_MESSAGE_SEND_SUCCESS, self._handleMessageSendSuccess, self)
	GlobalDispatcher:addEventListener(EventType.CHAT_EMOJI_SELECTED, self._handleSelectEmoji, self)
	GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._onSystemOpen, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_SET_ALIAS_SUCCESS, self._onUpdateAlias, self)
	GlobalDispatcher:addEventListener(EventType.CHAT_ENTER_PRIVATE, self._enterPrivateChat, self)
end

function M:unbindEvents()
	self._scrollAdapter:RemoveOnValueChanged()
	self._btnClose:RemoveClickListener()
	self._btnBack:RemoveClickListener()
	self._btnJumpBottom:RemoveClickListener()
	self._btnSend:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.UPDATE_FRIEND_LIST, self._onUpdateFriendList, self)
	GlobalDispatcher:removeEventListener(EventType.CHAT_MESSAGE_UPDATE, self._handleMessageUpdate, self)
	GlobalDispatcher:removeEventListener(EventType.CHAT_MESSAGE_SEND_SUCCESS, self._handleMessageSendSuccess, self)
	GlobalDispatcher:removeEventListener(EventType.CHAT_EMOJI_SELECTED, self._handleSelectEmoji, self)
	GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._onSystemOpen, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_SET_ALIAS_SUCCESS, self._onUpdateAlias, self)
	GlobalDispatcher:removeEventListener(EventType.CHAT_ENTER_PRIVATE, self._enterPrivateChat, self)
end

function M:onEnter()
	self._params = self:getFirstParam() or {}

	local targetId = self._params.targetId
	local index = self._params.index or self._curShowType or M.SubViewType.Friend

	self:_onClickTab(index, targetId)
	self:_clearInput()

	self._toggleBtnFace.IsOn = false

	FriendAgent.instance:sendGetUserListRequest(self._relationType)

	local allParams = self:getOpenParam()

	self._isMoveCamera = allParams[2]

	if self._isMoveCamera then
		local cameraPos = VirtualCameraMgr.instance:getFollowPosition()

		self._vectPos = Vector3.New(cameraPos.x, cameraPos.y, cameraPos.z)

		self:_showHUD(false)
	end
end

function M:onExit()
	ChatHistoryModel.instance:saveCurrent()
	printWarn("~~~~~~~~~~~~~执行保存完成~~~~~~~~")

	if self._isMoveCamera then
		self:_showHUD(true)
	end
end

function M:destroyUI()
	return
end

function M:_showHUD(isShow)
	local rootHUD = ViewMgr.instance:getRoot(ViewRootType.Hud)

	goutil.setActive(rootHUD, isShow)
end

function M:_onClickTab(index, targetId)
	local isOpen = SystemOpenFacade.instance:isOpen(kSystemIdList[index], true)

	if not isOpen then
		return
	end

	self._curShowType = index

	for _index, view in ipairs(self._toggltTabList) do
		local isOpen = SystemOpenFacade.instance:isOpen(kSystemIdList[_index])

		if isOpen then
			view:setStatus(_index == index and ChatTabView.Status.On or ChatTabView.Status.Off)
		end
	end

	local msgMoList

	if index == M.SubViewType.Friend then
		if targetId then
			msgMoList = ChatModel.instance:getMsgMoList(index, targetId)

			self:openConversation(msgMoList)
		else
			self:openPrivateList()
		end
	else
		msgMoList = ChatModel.instance:getMsgMoList(index)

		self:openConversation(msgMoList)
	end
end

function M:_enterPrivateChat(_, params)
	self._params = params

	local targetId = params.targetId
	local index = params.index or self._curShowType or M.SubViewType.Friend

	self:_onClickTab(index, targetId)
end

function M:_onUpdateFriendList()
	self:_updateFriendLoopList()
end

function M:_updateFriendLoopList()
	self._friendMoList = FriendModel.instance:getMoList(self._relationType)

	table.sort(self._friendMoList, ChatUtil.chatFriendSortFunc)
	self._friendLoopList:SetListItemCount(#self._friendMoList)
	self._friendLoopList:RefreshAllShownItem()
	goutil.setActive(self._emptyGo, #self._friendMoList == 0)
end

function M:openPrivateList()
	self._downGo:SetActive(false)
	self._friendScrollGo:SetActive(true)
	self._chatScrollGo:SetActive(false)
	self._topGo:SetActive(false)
	self:_updateFriendLoopList()

	if self._curShowType == M.SubViewType.Friend then
		self._txtTopHint1.text = lang("tip_friend_list")
	else
		self._txtTopHint1.text = ""
	end

	self:_checkShowNewMsg()
end

function M:openConversation(msgMoList)
	self._downGo:SetActive(true)
	self._chatScrollGo:SetActive(true)
	self._friendScrollGo:SetActive(false)
	self._topGo:SetActive(true)
	self._btnBack.gameObject:SetActive(true)

	self._chatMoList = msgMoList

	self._chatLoopList:ClearCells()
	self._chatLoopList:SetListItemCount(#self._chatMoList)
	self:_moveToBottom(true)

	self._txtTopHint1.text = ""

	if self._curShowType == M.SubViewType.Friend then
		local targetId = self._params.targetId
		local relationType = GameEnum.RelationTypeEnum.Friend
		local friendMo = FriendModel.instance:getUser(relationType, targetId)

		if friendMo then
			local alias = friendMo:getAlias()
			local nickName = friendMo:getNickName()

			if not string.nilorempty(alias) then
				self._txtTopHint1.text = string.format("<color=#a8e3ff>%s</color>\n<size=18>(%s)</size>", alias, nickName)
			else
				self._txtTopHint1.text = nickName
			end
		end
	elseif self._curShowType == M.SubViewType.Team then
		self._txtTopHint1.text = lang("tip_chat_team")

		self._btnBack.gameObject:SetActive(false)
	end

	self:_checkShowNewMsg()
end

function M:_onSystemOpen()
	for index, view in ipairs(self._toggltTabList) do
		local isOpen = SystemOpenFacade.instance:isOpen(kSystemIdList[index])
		local curStatus = view:getStatus()

		if isOpen and curStatus == ChatTabView.Status.Disable then
			tabView:setStatus(ChatTabView.Status.Off)
		end
	end
end

function M:_onClickBtnBack()
	if self._curShowType == M.SubViewType.Friend and self._chatScrollGo.activeSelf then
		self:openPrivateList()
	else
		self:back()
	end
end

function M:_onClickToggleBtnFace(_, isOn)
	self._emojiView:setVisible(isOn)
end

function M:_onClickBtnJumpBottom()
	self._chatLoopList:SetListItemCount(#self._chatMoList)
	self:_moveToBottom(true)
end

function M:_onClickBtnSend()
	if string.nilorempty(self._inputField:GetText()) then
		return
	end

	local channelType = self._curShowType
	local messageType = GameEnum.MessageTypeEnum.Text
	local content = self._inputField:GetText()

	if self._curShowType == M.SubViewType.Friend then
		local targetId = self._params.targetId

		ChatAgent.instance:sendSendMessageRequest(channelType, messageType, content, targetId)
	else
		ChatAgent.instance:sendSendMessageRequest(channelType, messageType, content)
	end

	self:_clearInput()
end

function M:_moveToBottom(immediately)
	self._chatLoopList:MoveToItemIndex(#self._chatMoList - 1)
end

function M:_clearInput()
	self._inputField:SetText("")
end

function M:_updateFrinedCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._friendLoopList:NewListViewItem("private_chat_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, ChatFriendItemCell)
	local mo = self._friendMoList[curIndex]

	itemView:updateData(mo)

	return item
end

function M:_updateChatCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local mo = self._chatMoList[curIndex]
	local item

	if mo:isSendByMe() then
		item = self._chatLoopList:NewListViewItem("normal_chat_item2")
	else
		item = self._chatLoopList:NewListViewItem("normal_chat_item1")
	end

	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, ChatMsgItemCell)

	itemView:updateData(mo)
	itemView:setTipsPosGo(self._tipsPosGo)
	itemView:setTimeVisible(false)

	local previousMo = self._chatMoList[curIndex - 1]

	if previousMo then
		local previousSendTime = previousMo:getTime()
		local curSentTime = mo:getTime()

		if (curSentTime - previousSendTime) / 1000 >= ServerTime.HOUR_SECONDS then
			itemView:setTimeVisible(true)
		end
	end

	return item
end

function M:_onScrollValChanged(v2)
	local val = v2.y

	if not self._lastScrollVal then
		self._lastScrollVal = val
	end

	if math.abs(self._lastScrollVal - val) > 0.01 then
		self._lastScrollVal = val

		self:_checkShowNewMsg()
	end
end

function M:_handleSelectEmoji(_, emojiId)
	local channelType = self._curShowType
	local messageType = GameEnum.MessageTypeEnum.Emoji
	local content = tostring(emojiId)

	if self._curShowType == M.SubViewType.Friend then
		local targetId = self._params.targetId

		ChatAgent.instance:sendSendMessageRequest(channelType, messageType, content, targetId)
	else
		ChatAgent.instance:sendSendMessageRequest(channelType, messageType, content)
	end

	self._toggleBtnFace.IsOn = false
end

function M:_handleMessageSendSuccess()
	self:_moveToBottom(true)
end

function M:_handleMessageUpdate()
	self:_checkShowNewMsg()
	self:_onUpdateFriendList()
end

function M:_handleChatSnapFinished()
	self:_checkShowNewMsg()
end

function M:_checkShowNewMsg()
	local scrollHeight = goutil.getHeight(self._chatScrollGo.transform)
	local contentHeight = goutil.getHeight(self._contentTRF)
	local x, y = Astral.TransformUtil.GetAnchoredPos(self._contentTRF, 0, 0)
	local showHint = true

	showHint = not (math.abs(contentHeight - scrollHeight - y) < 10) and not (scrollHeight + y - contentHeight > 0)

	local chatItemCount = self._chatLoopList:GetListItemCount()

	if not showHint then
		self._newChatHintGo:SetActive(false)

		if chatItemCount ~= #self._chatMoList then
			self._chatLoopList:SetListItemCount(#self._chatMoList)
			self:_moveToBottom(true)
		end
	else
		self._newChatHintGo:SetActive(true)

		if chatItemCount ~= #self._chatMoList then
			self._txtNewChatHint.text = string.format(lang("tip_has_s_info"), #self._chatMoList - chatItemCount)
		else
			self._txtNewChatHint.text = lang("tip_roll_to_down")
		end
	end
end

function M:_onUpdateAlias()
	if self._curShowType == M.SubViewType.Friend then
		local targetId = sel._params.targetId
		local relationType = GameEnum.RelationTypeEnum.Friend
		local friendMo = FriendModel.instance:getUser(relationType, targetId)

		if friendMo then
			local alias = friendMo:getAlias()
			local nickName = friendMo:getNickName()

			if not string.nilorempty(alias) then
				self._txtTopHint1.text = string.format("<color=#a8e3ff>%s</color>\n<size=18>%s</size>", alias, nickName)
			else
				self._txtTopHint1.text = nickName
			end
		end
	end
end

return M
