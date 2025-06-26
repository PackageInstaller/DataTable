-- chunkname: @IQIGame\\UI\\ChatUI.lua

local ChatUI = Base:Extend("ChatUI", "IQIGame.Onigao.UI.ChatUI", {
	cancelRecordAudio = false,
	_isInit = false,
	_isNewMsgComing = false,
	_isNewMsgIsMine = false,
	_newMsgNum = 0,
	_isInBottom = false,
	_privateChatPanelIndex = 0,
	_isInitMsgList = false,
	_CurrentMsgInfoPanelHeight = 0,
	_currentChatRoomNum = 0,
	curFileId = "",
	_isLoadRes = false,
	curFilePath = "",
	ChatRoomNodeTable = {},
	ChatButtonNodeTable = {},
	ChatChannelTable = {},
	_ChatMsgCellTable = {}
})
local ChatMsgCell = require("IQIGame.UI.Chat.ChatMsgCell")
local PrivateChatListCell = require("IQIGame.UI.Chat.PrivateChatListCell")
local PlayerInfoPanel = require("IQIGame.UI.Chat.PlayerInfoPanel")
local ExpressionView = require("IQIGame.UI.Chat.Expression.ExpressionView")

function ChatUI:OnInit()
	self:Initialize()

	self._chatMsgPrefab = self.UIController:GetPreloadedAsset(self.leftNewsPrefabPath)

	function self.onChatRoomUpdateDelegate(chatRoom)
		self:OnChatRoomUpdate(chatRoom)
	end

	function self.DelegateOnNewMsgClick()
		self:OnNewMsgBottomClick()
	end

	function self.DelegateOnChatButtonClick()
		self:OnChatButtonClick()
	end

	function self.DelegateOnCloseUI()
		self:OnCloseUI()
	end

	function self.DelegateOnChangeRoomHandler()
		self:OnChangeRoomHandler()
	end

	function self.DelegateOncChangeChannel(isOn)
		self:OncChangeChannel(isOn)
	end

	function self.DelegateOnChangeRoomSuccess(chatRoom)
		self:OnChangeRoomSuccess(chatRoom)
	end

	function self.DelegateOnResponseChatMsg(chatRoom)
		self:OnResponseChatMsg(chatRoom)
	end

	function self.DelegateOnSelectExpression(expressionId)
		self:OnSelectExpression(expressionId)
	end

	function self.DelegateOnChangeExpressionPage(pageIndex)
		self:OnChangeExpressionPage(pageIndex)
	end

	function self.DelegateOnClickPlayerHead(PlayerData)
		self:OnClickPlayerHead(PlayerData)
	end

	function self.DelegateOnClosePlayerInfoPanel()
		self:OnClosePlayerInfoPanel()
	end

	function self.DelegateOnScrollViewChanged(value)
		self:OnScrollViewChanged(value)
	end

	function self.DelegateOnClickPrivateChatPlayer(playerData)
		self:OnClickPrivateChatPlayer(playerData)
	end

	function self.DelegateOnChangeToggle(isOn)
		self:OnInfoFilterToggle(isOn)
	end

	function self.DelegateOnDeletePrivate()
		self:OnDeletePrivatePerson()
	end

	function self.DelegateOnDeleteToggle()
		self:OnDeleteToggle()
	end

	function self.DelegateOnChatPrivate(data)
		self:OnOpenPrivateChatPanel(data)
	end

	function self.DelegateOnStartAudioBtn()
		self:OnStartRecord()
	end

	function self.DelegateOnStopAudioBtn()
		self:OnStopRecord()
	end

	function self.DelegateOnAudioBtnDown()
		self:OnStartRecord()
	end

	function self.DelegateOnAudioBtnUp(data)
		if self.cancelRecordAudio == true then
			self.cancelRecordAudio = false

			return
		end

		self:OnStopRecord(true)
	end

	function self.DelegateOnAudioBtnExit(data)
		self.cancelRecordAudio = true

		self:OnStopRecord(false)
	end

	function self.DelegateOnAudioUploadComplete(code, filePath, fileId, speakResult)
		self:OnAudioUploadComplete(code, filePath, fileId, speakResult)
	end

	function self.DelegateOnAudioDownComplete(code, filePath, fileId)
		self:OnAudioDownComplete(code, filePath, fileId)
	end

	function self.DelegateOnAudioPlayComplete(code, filePath)
		self:OnAudioPlayComplete(code, filePath)
	end

	function self.DelegateOnAudioSpeakToTextComplete(code, fileId, result)
		self:OnAudioSpeakToTextComplete(code, fileId, result)
	end

	function self.DelegateOnAudioStreamSpeechComplete(code, error, filePath, result)
		self:OnAudioStreamSpeechComplete(code, error, filePath, result)
	end

	function self.DelegateOnPlayerHeadFrameLoaded()
		self:OnPlayerHeadFrameLoaded()
	end

	function self.DelegateUpdatePlayerEvent()
		self:RefreshGuildToggle()
	end

	function self.DelegateOnUnlockNotify()
		self:OnUnlockFunction()
	end

	function self.DelegateBtnBubble()
		self:OnBtnBubble()
	end

	self.ChatButtonNodeTable = {}
	self.ChatRoomNodeTable = {}
	self.apiNodeTable = {}

	LuaCodeInterface.BindOutlet(self.apiNode, self.apiNodeTable)
	LuaCodeInterface.BindOutlet(self.chatButtonNode, self.ChatButtonNodeTable)
	LuaCodeInterface.BindOutlet(self.goTopRoom, self.ChatRoomNodeTable)

	self.ChatButtonNodeTable.goBtnSureTxt:GetComponent("Text").text = ChatUIApi:GetString("goBtnSureTxt")
	self.inputMsg = self.ChatButtonNodeTable.InputField:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.inputMsg.placeholder.text = ChatUIApi:GetString("msgDefaultTxt")

	local input = self.ChatRoomNodeTable.InputField:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	input.placeholder.text = ChatUIApi:GetString("roomNumDefaultTxt")
	self.apiNodeTable.btnRoomTxt:GetComponent("Text").text = ChatUIApi:GetString("btnChangeRoom")
	self.apiNodeTable.SysToggleTxt1:GetComponent("Text").text = ChatUIApi:GetString("SysToggleTxt1")
	self.apiNodeTable.SysToggleTxt2:GetComponent("Text").text = ChatUIApi:GetString("SysToggleTxt2")
	self.ChatChannelTable = {}
	self.ChatChannelTable[ChatModule.CHANNEL_WORLD] = self.goBtnWorld
	self.ChatChannelTable[ChatModule.CHANNEL_PRIVATE_CHAT] = self.privateChatChannel
	self.ChatChannelTable[ChatModule.CHANNEL_GUILD] = self.goBtnGuild
	self.ScrollAreaListChat = self.chatInfoScrollView:GetComponent("ScrollAreaListChat")

	function self.ScrollAreaListChat.onRenderCell(cell)
		self:OnRenderSubBtnGridCell(cell)
	end

	for key, value in pairs(self.ChatChannelTable) do
		value.gameObject:GetComponent("ToggleHelperComponent").text = ChatUIApi:GetString("TabBtn", key)
	end

	self.expressionView = ExpressionView.New(self.goExpressionView)
	self.PlayerInfoPanel = PlayerInfoPanel.PackageOrReuseView(self, self.playerInfo)
	self._isInit = false
	self._isLoadRes = false
	self._isNewMsgComing = false
	self.privateScrollPageList = self.goScrollPageList:GetComponent("ScrollAreaList")

	function self.privateScrollPageList.onRenderCell(cell)
		self:OnRenderPrivateCell(cell)
	end

	function self.privateScrollPageList.onSelectedCell(cell)
		self:OnSelectedCell(cell)
	end

	self.goDeleteToggle.transform:Find("Text_Name_Up"):GetComponent("Text").text = ChatUIApi:GetString("btnDeleteTxt")

	UGUIUtil.SetTextInChildren(self.EmptyView, ChatUIApi:GetString("EmptyViewText"))
end

function ChatUI:GetPreloadAssetPaths()
	return nil
end

function ChatUI:GetOpenPreloadAssetPaths(userData)
	self.leftNewsPrefabPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_Chat/Cell")

	local path = {
		self.leftNewsPrefabPath
	}

	return path
end

function ChatUI:OnOpen(userData)
	self:Refresh(userData)

	if userData ~= nil then
		self._privateChatTargetData = userData

		local playerData = {}

		playerData.pid = userData.pId
		playerData.pName = userData.pName
		playerData.headIcon = userData.headIcon
		playerData.vip = userData.vip
		playerData.pLv = userData.pLv
		playerData.serverId = userData.serverId

		ChatModule.SetPlayerIn(playerData)
		self.goDeleteToggle:SetActive(true)
		self.goChangeToggle:SetActive(false)

		self.goChangeToggle:GetComponent("Toggle").isOn = false

		self.PrivateTitle:SetActive(true)

		self.PrivateTitle:GetComponent("Text").text = ChatUIApi:GetString("goPrivateName", userData.pName)
	else
		self.goChangeToggle:SetActive(true)
		self.goDeleteToggle:SetActive(false)
		self.PrivateTitle:SetActive(false)
		self.goTopRoom:SetActive(true)

		self.goChangeToggle:GetComponent("Toggle").isOn = false
		self.goBtnWorld:GetComponent("Toggle").isOn = true

		self.playerInfo:SetActive(false)
	end

	self:RefreshGuildToggle()
	EventDispatcher.Dispatch(EventID.MoveLive2DToTarget)

	local chatData = PlayerModule.PlayerInfo.chatRoom

	self:SetRoomTitle(chatData)

	if self._isInit == false then
		self:InitChat()
	end

	if ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_PRIVATE_CHAT then
		local playerMsgList = ChatModule.GetPrivateChatMsgByKey(self._privateChatTargetData.pName)

		self:RefreshChatList(#playerMsgList)
	else
		local len = ChatModule.GetChatMsgByChannelTypeLen(ChatModule.CurrentChannelIndex)

		self:RefreshChatList(len)
	end

	local playerList = ChatModule.GetPlayerListIn()
	local selectedIndex = 1

	if userData ~= nil then
		for i, v in ipairs(playerList) do
			if v.pId == userData.pId then
				selectedIndex = i

				break
			end
		end
	end

	self.privateScrollPageList.defaultSelectedToggle = selectedIndex - 1

	self.privateScrollPageList:Refresh(#playerList)
	self:CheckBtnBubble()
end

function ChatUI:RefreshChatList(length, addCellNum)
	if addCellNum == nil then
		self.ScrollAreaListChat:Refresh(length)
	else
		self.ScrollAreaListChat:AddCell(length, addCellNum)
	end

	self.EmptyView:SetActive(length == 0)
end

function ChatUI:InitChat()
	self._currentMsgContentHeight = 0
	self._isNewMsgComing = false
	self._isNewMsgIsMine = false
	self._isDraggingMsgList = false
	self._newMsgNum = 0
	self._isInBottom = false
	self._isInitMsgList = false
	self._privateChatPanelIndex = 0

	self.PlayerInfoPanel:Clear()
	self.playerInfo:SetActive(false)

	if self._privateChatTargetData ~= nil then
		ChatModule.CurrentChannelIndex = ChatModule.CHANNEL_PRIVATE_CHAT
	else
		ChatModule.CurrentChannelIndex = ChatModule.CHANNEL_SYSTEM
	end

	local isHaveNewMsg = ChatModule.IsHavePrivateChatNewMsg()

	if isHaveNewMsg == true then
		self:SetPrivateChatRedPointVisible(true)
	else
		self:SetPrivateChatRedPointVisible(false)
	end

	self:DoChangeChannel()

	self._isInit = true
end

function ChatUI:OncChangeChannel(isOn)
	if isOn == true then
		if self.ChatChannelTable[ChatModule.CHANNEL_WORLD] == self.UIController:GetCurrentTarget() then
			ChatModule.CurrentChannelIndex = ChatModule.CHANNEL_WORLD
		elseif self.ChatChannelTable[ChatModule.CHANNEL_GUILD] == self.UIController:GetCurrentTarget() then
			ChatModule.CurrentChannelIndex = ChatModule.CHANNEL_GUILD
		else
			ChatModule.CurrentChannelIndex = ChatModule.CHANNEL_SYSTEM
		end

		self:DoChangeChannel()
		self:UpdateRoomUp()
	end
end

function ChatUI:DoChangeChannel()
	self:ClearChatMsgPanel()

	self._privateChatPanelIndex = 0

	self.ChatButtonNodeTable.sendChatMsgNode:SetActive(true)

	if ChatModule.CurrentChannelIndex ~= ChatModule.CHANNEL_PRIVATE_CHAT then
		self._privateChatTargetData = nil

		self.chatButtonNode:SetActive(true)
	elseif self._privateChatTargetData ~= nil then
		self._privateChatPanelIndex = ChatModule.PrivateChat_TargetPanel
	else
		self._privateChatPanelIndex = ChatModule.PrivateChat_ListPanel
	end

	if ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_WORLD or ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_PRIVATE_CHAT then
		self.ChatButtonNodeTable.newChatMsgNode:SetActive(false)

		if ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_PRIVATE_CHAT then
			if self._privateChatPanelIndex == ChatModule.PrivateChat_TargetPanel then
				self.chatButtonNode:SetActive(true)
			elseif self._privateChatPanelIndex == ChatModule.PrivateChat_ListPanel then
				self.chatButtonNode:SetActive(false)
			end

			self:SetPrivateChatRedPointVisible(false)
		else
			self.goDeleteToggle:SetActive(false)
		end
	else
		self.ChatButtonNodeTable.newChatMsgNode:SetActive(false)
	end
end

function ChatUI:OnClickPrivateChatPlayer(playerData)
	self._privateChatPanelIndex = ChatModule.PrivateChat_TargetPanel

	self.chatButtonNode:SetActive(true)

	self._privateChatTargetData = playerData

	self:ClearChatMsgPanel()
	self:UpdateRoomUp(playerData)
end

function ChatUI:UpdateRoomUp(playerData)
	if ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_PRIVATE_CHAT then
		self.goChangeToggle:SetActive(false)
		self.goDeleteToggle:SetActive(true)
		self.PrivateTitle:SetActive(true)

		if playerData ~= nil then
			self.PrivateTitle:GetComponent("Text").text = ChatUIApi:GetString("goPrivateName", playerData.pName)
		end

		self.goTopRoom:SetActive(false)
	else
		self.goDeleteToggle:SetActive(false)

		if ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_GUILD then
			self.goChangeToggle:SetActive(false)

			self.goChangeToggle:GetComponent("Toggle").isOn = false
		else
			self.goChangeToggle:SetActive(true)
		end

		self.PrivateTitle:SetActive(false)
		self.goTopRoom:SetActive(ChatModule.CurrentChannelIndex ~= ChatModule.CHANNEL_GUILD)
	end
end

function ChatUI:OnInfoFilterToggle(isOn)
	ChatModule.isFillerSys = isOn

	local len = ChatModule.GetChatMsgByChannelTypeLen(ChatModule.CurrentChannelIndex)

	self:RefreshChatList(len)
end

function ChatUI:OnDeletePrivatePerson()
	local v = ChatModule.GetPlayerListIn()
	local len = #v

	if len > 0 then
		self._privateChatTargetData = v[1]
		self.privateScrollPageList.defaultSelectedToggle = 0

		self.privateScrollPageList:RenderCells()
	else
		self.goBtnWorld:GetComponent("Toggle").isOn = true

		self.privateScrollPageList:RenderCells()
	end
end

function ChatUI:OnDeleteToggle()
	ChatModule.DeletePlayer(self.selectedPrivateCell._playerData.pId)
	EventDispatcher.Dispatch(EventID.DeletePrivatePerson, self.selectedPrivateCell._playerData)
end

function ChatUI:OnChangeRoomHandler()
	local input = self.ChatRoomNodeTable.InputField:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	if input.text == "" then
		NoticeModule.ShowNotice(21045007)

		return
	end

	local num = tonumber(input.text)
	local max = CfgDiscreteDataTable[6506032].Data[4]
	local min = CfgDiscreteDataTable[6506032].Data[5]

	if num then
		if num < min or max < num then
			NoticeModule.ShowNotice(21045007)

			return
		end
	else
		NoticeModule.ShowNotice(21045007)

		return
	end

	local selectRoomNum = tonumber(input.text)

	if self._currentChatRoomNum ~= selectRoomNum then
		ChatModule.ChangeRoom(tonumber(input.text))
	end

	input.text = ""
end

function ChatUI:OnStartRecord()
	return
end

function ChatUI:OnStopRecord(isUpload)
	return
end

function ChatUI:OnAudioUploadComplete(code, filePath, fileId)
	self.curFilePath = filePath
	self.curFileId = fileId
end

function ChatUI:OnAudioDownComplete(code, filePath, fileId)
	return
end

function ChatUI:OnAudioPlayComplete(code, filePath)
	return
end

function ChatUI:OnAudioSpeakToTextComplete(code, fileId, result)
	if self.curFileId ~= fileId then
		return
	end

	if result == "" then
		return
	end

	local s = "#(audio)#|" .. self.curFilePath .. "~" .. fileId .. "~" .. result

	self:OnSendMsg(s)
end

function ChatUI:OnAudioStreamSpeechComplete(code, error, filePath, result)
	if self.curFilePath ~= filePath then
		return
	end

	local s = "#(audio)#|" .. filePath .. "~" .. self.curFileId .. "~" .. result

	self:OnSendMsg(s)
end

function ChatUI:OnOpenPrivateChatPanel(userData)
	self._privateChatTargetData = userData

	local playerData = {}

	playerData.pid = userData.pId
	playerData.pName = userData.pName
	playerData.headIcon = userData.headIcon
	playerData.vip = userData.vip
	playerData.pLv = userData.pLv
	playerData.serverId = userData.serverId

	ChatModule.SetPlayerIn(playerData)
	self.goDeleteToggle:SetActive(true)
	self.goChangeToggle:SetActive(false)

	self.goChangeToggle:GetComponent("Toggle").isOn = false

	self.PrivateTitle:SetActive(true)

	self.PrivateTitle:GetComponent("Text").text = ChatUIApi:GetString("goPrivateName", userData.pName)

	local playerList = ChatModule.GetPlayerListIn()
	local selectedIndex = 1

	if userData ~= nil then
		for i, v in ipairs(playerList) do
			if v.pId == userData.pId then
				selectedIndex = i

				break
			end
		end
	end

	self.privateScrollPageList.defaultSelectedToggle = selectedIndex - 1

	local len = #playerList

	if len > self.privateScrollPageList.dataCount then
		self.privateScrollPageList:Refresh(len)
	else
		self.privateScrollPageList:RenderCells()
	end
end

function ChatUI:OnChangeRoomSuccess(chatRoom)
	self:SetRoomTitle(chatRoom)
	self:ClearChatMsgPanel()
end

function ChatUI:OnChatRoomUpdate(chatRoom)
	self:SetRoomTitle(chatRoom)
end

function ChatUI:SetRoomTitle(ChatRoomPOD)
	self._currentChatRoomNum = ChatRoomPOD.roomNumber
	self.ChatRoomNodeTable.roomInfoTxt:GetComponent("Text").text = ChatUIApi:GetString("CurrentRoomPlayerNum", ChatRoomPOD.roomNumber, ChatRoomPOD.onlineCount)
end

function ChatUI:OnSelectExpression(expressionId)
	local CfgChatEmoticonData = CfgChatEmoticonTable[expressionId]

	self:OnSendMsg(CfgChatEmoticonData.Name)
end

function ChatUI:OnChangeExpressionPage(pageIndex)
	self.expressionPanel:ChangeExpressionPage(pageIndex)
end

function ChatUI:OnClickPlayerHead(playerData)
	if playerData.PlayerSimplePOD.pid == PlayerModule.PlayerInfo.baseInfo.pid then
		return
	end

	self.PlayerInfoPanel:SetItem(playerData)
end

function ChatUI:OnChatButtonClick()
	if self.inputMsg.text == "" then
		NoticeModule.ShowNotice(21040050)

		return
	end

	if string.find(self.inputMsg.text, "/cmd") then
		self:OnSendMsg(self.inputMsg.text)

		if not ChatModule.isInChatDisable then
			self.inputMsg.text = ""
		end
	else
		SDKLoginModule.checkDirtyWords(self.inputMsg.text, function(contain, replaceContent)
			if contain then
				NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingPlayerInfoViewApi:GetString("ErrorMsg6"))

				if replaceContent ~= nil then
					self.inputMsg.text = replaceContent
				end
			end

			self:OnSendMsg(self.inputMsg.text)

			if not ChatModule.isInChatDisable then
				self.inputMsg.text = ""
			end
		end)
	end
end

function ChatUI:OnNewMsgBottomClick()
	self._newMsgNum = 0

	self:ClearChatMsgPanel()
end

function ChatUI:OnSendMsg(text)
	local CChatPOD = {}

	CChatPOD.channel = ChatModule.CurrentChannelIndex

	if CChatPOD.channel == ChatModule.CHANNEL_SYSTEM then
		CChatPOD.channel = ChatModule.CHANNEL_WORLD
	end

	local pid

	CChatPOD.type = 1

	if ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_PRIVATE_CHAT then
		if self._privateChatTargetData == nil or self._privateChatTargetData == {} then
			logError("self._privateChatTargetData == null")

			return
		else
			CChatPOD.target = self._privateChatTargetData.pName
			pid = self._privateChatTargetData.pId
		end
	else
		CChatPOD.target = ""
	end

	CChatPOD.content = text

	ChatModule.SendMsg(CChatPOD, pid)

	if self.ScrollAreaListChat == nil or self.ScrollAreaListChat:CheckReachedBottom() then
		-- block empty
	else
		self:ClearChatMsgPanel()
	end
end

function ChatUI:OnResponseChatMsg(chatMsg)
	if chatMsg.channel == ChatModule.CHANNEL_PRIVATE_CHAT and (self._privateChatTargetData == nil or self._privateChatTargetData.pId ~= chatMsg.sender.pid and PlayerModule.PlayerInfo.baseInfo.pid ~= chatMsg.sender.pid) then
		local isInTableList = false

		for i = 1, #self._ChatMsgCellTable do
			if self._ChatMsgCellTable[i]._playerData.pId == chatMsg.sender.pid then
				self._ChatMsgCellTable[i]:SetRedPointVisible(true)

				isInTableList = true

				break
			end
		end

		if isInTableList == false then
			local playerData = {}

			playerData.pId = chatMsg.sender.pid
			playerData.pName = chatMsg.sender.pName
			playerData.headIcon = chatMsg.sender.headIcon
			playerData.vip = chatMsg.sender.vip
			playerData.pLv = chatMsg.sender.pLv
			playerData.serverId = chatMsg.sender.serverId

			local friendData = FriendModule.GetFriendByPId(playerData.pId)

			if friendData ~= nil then
				playerData.remark = friendData.remark
			else
				playerData.remark = ""
			end

			local v = ChatModule.GetPlayerListIn()
			local len = #v

			if len > self.privateScrollPageList.dataCount then
				self.privateScrollPageList:Refresh(len)
			else
				self.privateScrollPageList:RenderCells()
			end

			ChatModule.SetPlayerIn(chatMsg.sender)
		end

		return
	end

	self.ChatButtonNodeTable.newChatMsgNode:SetActive(false)

	if chatMsg ~= nil then
		self._isNewMsgComing = true

		if chatMsg.sender ~= nil and PlayerModule.PlayerInfo.baseInfo.pid == chatMsg.sender.pid then
			self._isNewMsgIsMine = true
		elseif self.ScrollAreaListChat:CheckReachedBottom() then
			self._isInBottom = true
		else
			self._isInBottom = false
			self._newMsgNum = self._newMsgNum + 1

			self.ChatButtonNodeTable.newChatMsgNode:SetActive(true)

			self.ChatButtonNodeTable.unReadNewsTxt:GetComponent("Text").text = ChatUIApi:GetString("NewMsg", self._newMsgNum)
		end

		if ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_PRIVATE_CHAT then
			local playerMsgList = ChatModule.GetPrivateChatMsgByKey(self._privateChatTargetData.pName)
			local len = #playerMsgList

			if len > self.ScrollAreaListChat.dataCount then
				self:RefreshChatList(len, 50)
			end
		else
			local len = ChatModule.GetChatMsgByChannelTypeLen(ChatModule.CurrentChannelIndex)

			if len > self.ScrollAreaListChat.dataCount then
				self:RefreshChatList(len, 50)
			end
		end
	end
end

function ChatUI:SetPrivateChatRedPointVisible(value)
	if self._privateChatRedBg ~= nil then
		self._privateChatRedBg:SetActive(value)
	end
end

function ChatUI:ClearChatMsgPanel()
	if ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_PRIVATE_CHAT then
		local playerMsgList = ChatModule.GetPrivateChatMsgByKey(self._privateChatTargetData.pName)
		local len = #playerMsgList

		self:RefreshChatList(len)
	else
		local len = ChatModule.GetChatMsgByChannelTypeLen(ChatModule.CurrentChannelIndex)

		self:RefreshChatList(len)
	end
end

function ChatUI:OnScrollViewChanged(value)
	if value.y <= 0 then
		self._newMsgNum = 0

		self.ChatButtonNodeTable.newChatMsgNode:SetActive(false)
	end
end

function ChatUI:OnRenderSubBtnGridCell(cell)
	local index = cell.index + 1
	local channelModel

	channelModel = ChatModule.GetChatMsgByChannelType(ChatModule.CurrentChannelIndex)

	if ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_PRIVATE_CHAT then
		channelModel = ChatModule.GetPrivateChatMsgByKey(self._privateChatTargetData.pName)
	end

	local chatMsg

	if channelModel ~= nil then
		chatMsg = channelModel[index]
	end

	if chatMsg == nil then
		cell.gameObject:SetActive(false)

		return
	else
		cell.gameObject:SetActive(true)
	end

	local chatMsgCell = ChatMsgCell.PackageOrReuseView(self, cell.gameObject)

	chatMsgCell:SetItem(chatMsg)

	chatMsg.isRead = true

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(cell.transform)
end

function ChatUI:OnRenderPrivateCell(cell)
	local playerList = ChatModule.GetPlayerListIn()
	local index = cell.index + 1
	local data = playerList[index]

	if data == nil then
		cell.gameObject:SetActive(false)
	else
		cell.gameObject:SetActive(true)

		local privateChatPlayerCell = PrivateChatListCell.PackageOrReuseView(self, cell.gameObject)

		privateChatPlayerCell:SetItem(data)

		local has = false

		for i, v in pairs(self._ChatMsgCellTable) do
			if v == privateChatPlayerCell then
				has = true

				break
			end
		end

		if has == false then
			table.insert(self._ChatMsgCellTable, privateChatPlayerCell)
		end
	end
end

function ChatUI:OnSelectedCell(cell)
	for i, v in pairs(self._ChatMsgCellTable) do
		if v.cellObj == cell.gameObject then
			self.selectedPrivateCell = v

			self.goDeleteToggle:SetActive(true)

			break
		end
	end
end

function ChatUI:OnRenderPage(cell)
	return
end

function ChatUI:OnCloseUI()
	ChatModule.privateChatCount = 0

	UIModule.Close(Constant.UIControllerName.ChatUI)
end

function ChatUI:OnClose(userData)
	self:OnHide()

	ChatModule.CurrentChannelIndex = ChatModule.CHANNEL_WORLD

	EventDispatcher.Dispatch(EventID.MoveBackLive2D)

	self._isInit = false
	self._privateChatTargetData = nil
end

function ChatUI:OnPause()
	return
end

function ChatUI:OnResume()
	return
end

function ChatUI:OnCover()
	return
end

function ChatUI:OnReveal()
	return
end

function ChatUI:OnRefocus(userData)
	return
end

function ChatUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.ScrollAreaListChat:CheckReachedBottom() then
		self._newMsgNum = 0

		self.ChatButtonNodeTable.newChatMsgNode:SetActive(false)
	end
end

function ChatUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChatUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChatUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChatUI:Initialize()
	self.btnExpression = self.goBtnExpression:GetComponent("Button")

	function self.onClickBtnExpressDelegate()
		self:OnClickBtnExpression()
	end
end

function ChatUI:Refresh(userData)
	self.expressionView:Close()
end

function ChatUI:OnHide()
	self.expressionView:OnHide()
end

function ChatUI:OnDestroy()
	self.expressionView:OnDestroy()
	PrivateChatListCell.DisposeIn(self)
	ChatMsgCell.DisposeIn(self)
	self.PlayerInfoPanel:Dispose()
	LuaCodeInterface.ClearOutlet(self.apiNode, self.apiNodeTable)
	LuaCodeInterface.ClearOutlet(self.chatButtonNode, self.ChatButtonNodeTable)
	LuaCodeInterface.ClearOutlet(self.goTopRoom, self.ChatRoomNodeTable)
end

function ChatUI:RefreshGuildToggle()
	self.goBtnGuild:SetActive(PlayerModule.PlayerInfo.guildId ~= 0)

	if ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_GUILD and PlayerModule.PlayerInfo.guildId == 0 then
		self.goBtnWorld:GetComponent("Toggle").isOn = true
	end

	local show = ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_PRIVATE_CHAT or ChatModule.CurrentChannelIndex == ChatModule.CHANNEL_GUILD

	self.goTopRoom:SetActive(not show)
	self.goDeleteToggle:SetActive(false)
	self.goChangeToggle:SetActive(not show)
end

function ChatUI:OnAddListeners()
	self.btnExpression.onClick:AddListener(self.onClickBtnExpressDelegate)
	self.goChangeToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnChangeToggle)
	self.ChatButtonNodeTable.SendBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnChatButtonClick)
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseUI)
	self.ChatRoomNodeTable.changeRoomBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnChangeRoomHandler)

	for key, value in pairs(self.ChatChannelTable) do
		value:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOncChangeChannel)
	end

	self.ChatButtonNodeTable.newChatMsgNode:GetComponent("Button").onClick:AddListener(self.DelegateOnNewMsgClick)
	self.goDeleteToggle:GetComponent("Button").onClick:AddListener(self.DelegateOnDeleteToggle)
	self.BtnBubble:GetComponent("Button").onClick:AddListener(self.DelegateBtnBubble)
	EventDispatcher.AddEventListener(EventID.DeletePrivatePerson, self.DelegateOnDeletePrivate)
	EventDispatcher.AddEventListener(EventID.ChangeRoomSuccess, self.DelegateOnChangeRoomSuccess)
	EventDispatcher.AddEventListener(EventID.ResponseChatMsg, self.DelegateOnResponseChatMsg)
	EventDispatcher.AddEventListener(EventID.SelectExpression, self.DelegateOnSelectExpression)
	EventDispatcher.AddEventListener(EventID.ChangeExpressionPage, self.DelegateOnChangeExpressionPage)
	EventDispatcher.AddEventListener(EventID.ClickHead, self.DelegateOnClickPlayerHead)
	EventDispatcher.AddEventListener(EventID.ClickPrivateChatPlayer, self.DelegateOnClickPrivateChatPlayer)
	EventDispatcher.AddEventListener(EventID.OpenPrivateChatPanel, self.DelegateOnChatPrivate)
	EventDispatcher.AddEventListener(EventID.ChatRoomUpdate, self.onChatRoomUpdateDelegate)
	EventDispatcher.AddEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
	EventDispatcher.AddEventListener(EventID.GuildUpdatePlayerEvent, self.DelegateUpdatePlayerEvent)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockNotify)
end

function ChatUI:OnRemoveListeners()
	self.btnExpression.onClick:RemoveListener(self.onClickBtnExpressDelegate)
	self.goChangeToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnChangeToggle)
	self.ChatButtonNodeTable.SendBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnChatButtonClick)
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseUI)
	self.ChatRoomNodeTable.changeRoomBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnChangeRoomHandler)

	for key, value in pairs(self.ChatChannelTable) do
		value:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOncChangeChannel)
	end

	self.ChatButtonNodeTable.newChatMsgNode:GetComponent("Button").onClick:RemoveListener(self.DelegateOnNewMsgClick)
	self.goDeleteToggle:GetComponent("Button").onClick:RemoveListener(self.DelegateOnDeleteToggle)
	self.BtnBubble:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBubble)
	EventDispatcher.RemoveEventListener(EventID.ChangeRoomSuccess, self.DelegateOnChangeRoomSuccess)
	EventDispatcher.RemoveEventListener(EventID.ResponseChatMsg, self.DelegateOnResponseChatMsg)
	EventDispatcher.RemoveEventListener(EventID.SelectExpression, self.DelegateOnSelectExpression)
	EventDispatcher.RemoveEventListener(EventID.ChangeExpressionPage, self.DelegateOnChangeExpressionPage)
	EventDispatcher.RemoveEventListener(EventID.ClickHead, self.DelegateOnClickPlayerHead)
	EventDispatcher.RemoveEventListener(EventID.ClickPrivateChatPlayer, self.DelegateOnClickPrivateChatPlayer)
	EventDispatcher.RemoveEventListener(EventID.DeletePrivatePerson, self.DelegateOnDeletePrivate)
	EventDispatcher.RemoveEventListener(EventID.OpenPrivateChatPanel, self.DelegateOnChatPrivate)
	EventDispatcher.RemoveEventListener(EventID.ChatRoomUpdate, self.onChatRoomUpdateDelegate)
	EventDispatcher.RemoveEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdatePlayerEvent, self.DelegateUpdatePlayerEvent)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockNotify)
end

function ChatUI:OnClickBtnExpression()
	self.expressionView:Open()
end

function ChatUI:OnPlayerHeadFrameLoaded()
	local mask = self.ScrollAreaListChat:GetComponent(typeof(UnityEngine.UI.RectMask3D))

	mask:SetDirtyTarget()
end

function ChatUI:OnUnlockFunction()
	self:CheckBtnBubble()
end

function ChatUI:CheckBtnBubble()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.CHAT_BUBBLE)

	self.BtnBubble:SetActive(result)
end

function ChatUI:OnBtnBubble()
	UIModule.Open(Constant.UIControllerName.ChatBubbleUI, Constant.UILayer.UI)
end

return ChatUI
