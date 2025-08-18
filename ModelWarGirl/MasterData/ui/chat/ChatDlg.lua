-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\ChatDlg.lua

local MsgReceiver = require("System/MsgReceiver")
local ChatCell = require("UI/Chat/ChatCell")
local ChatPersonalPanel = require("UI/Chat/ChatPersonalPanel")
local ChatApprenticePanel = require("UI/Chat/ChatApprenticePanel")
local ChatMasterPanel = require("UI/Chat/ChatMasterPanel")
local ResCommonHardCode = require("ClientData/ResCommonHardCode")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local VersionUtils = require("System/VersionUtils")
local EventConst = require("EventConst")
local ChatService = require("Network/ChatService")
local ResUpperLimit = require("ClientData/ResUpperLimit")
local ResRedPacketShow = require("ClientData/ResRedPacketShow")
local EMOJI_PANEL_HEIGHT = 334
local MESSAGE_CONTENT_X_WIDTH = Vector2(190.45, 904)
local MESSAGE_CONTENT_TOP_BOTTOM = Vector2(211.99, 0)
local UIControls = UIControls
local strClassName = "ChatDlg"
local ChatDlg = Class(strClassName, UIControls.Window)
local emojiDic = {
	single = {},
	more = {}
}
local CHANNEL_CONFIG = {
	[Const.CHANNEL_WORLD] = {
		lastSendTime = -1,
		sendInterval = ResCommonHardCode[1].value[2],
		overTimeTip = Lang.get(30160)
	},
	[Const.CHANNEL_GUILD] = {
		lastSendTime = -1,
		sendInterval = ResCommonHardCode[1].value[5],
		overTimeTip = Lang.get(30160)
	},
	[Const.CHANNEL_PRIVATE] = {
		lastSendTime = -1,
		sendInterval = ResCommonHardCode[1].value[1],
		overTimeTip = Lang.get(30160)
	},
	[Const.CHANNEL_SERVER] = {
		lastSendTime = -1,
		sendInterval = ResCommonHardCode[1].value[4],
		overTimeTip = Lang.get(30160)
	}
}

function ChatDlg:ctor()
	self.mMsgDatas = {}

	self:initUI()

	self._selectIndex = 1
	self.mCurSend = nil
	self.mCurReceives = {}
	self.receiver = MsgReceiver({})
	self.receiver.mEventReceive = Slot(self.onMsgReceive, self)
	self.receiver.mEventUpdate = Slot(self.onMsgUpdate, self)
	self._isLock = false
	self._newMsgs = {}

	local isLarge = false

	for k, v in pairs(UIConst.EMOJI_DATA) do
		isLarge = true

		local key = isLarge and "single" or "more"

		for i, name in ipairs(v.data) do
			emojiDic[key][name] = 1
		end
	end

	local curTime = ClientUtils.getServerTime()

	if Const.RED_PACK_START_TIME and Const.RED_PACK_END_TIME and curTime >= Const.RED_PACK_START_TIME and curTime <= Const.RED_PACK_END_TIME then
		Const.RED_PACK_ENABLE = true
	else
		Const.RED_PACK_ENABLE = false
	end
end

function ChatDlg:destroy()
	MsgManager.saveMsg()
	self.receiver:destroy()

	if self.cells then
		for i, chatCell in pairs(self.cells) do
			chatCell:destroy()
		end
	end

	self.personalPanel:destroy()

	local ui = UIManager.getUI("chatEmojiBox", nil, false)

	if ui then
		ui:setVisible(false)
	end

	ChatDlg.super.destroy(self)
end

function ChatDlg:onOpenOver(...)
	self.isOpenOver = true

	ChatDlg.super.onOpenOver(self)

	if self.postOpenFunc then
		self.postOpenFunc()

		self.postOpenFunc = nil
	else
		self:initShow()
	end
end

function ChatDlg:initUI()
	self.mainPanel = UIControls.Panel(self, "ChatMainPanel")
	self.panelInput = UIControls.Panel(self, "ChatMainPanel/InputPanel")
	self.btnSend = UIControls.Button(self, "ChatMainPanel/InputPanel/BtnSend")

	self.btnSend:addEventClick(self.onMsgSend)

	self.btnEmoji = UIControls.Button(self, "ChatMainPanel/InputPanel/BtnEmoji")

	self.btnEmoji:addEventClick(self.onEmojiSelect)

	self.redHintEmoji = UIControls.RedDot(self, "ChatMainPanel/InputPanel/BtnEmoji/IconNew")

	self.redHintEmoji:addHint({
		UIConst.RD_HINT_CHAT_DYNAMIC_ICON_NEW
	})

	self.editInput = UIControls.Input(self, "ChatMainPanel/InputPanel/InputTextPanel/InputText")
	self.panelHint = UIControls.Panel(self, "ChatMainPanel/BgAlert")
	self.txtHint = UIControls.Label(self, "ChatMainPanel/BgAlert/TextAlert")
	self.btnJoin = UIControls.Button(self, "ChatMainPanel/BgAlert/BtnJoin")

	self.btnJoin:addEventClick(self.onBtnJoingClick)

	self.btnNewHint = UIControls.Button(self, "ChatMainPanel/BtnMoreMessage", "Text")

	self.btnNewHint:addEventClick(self.onHintGoTop)

	self.cells = {}
	self.view = UIControls.ScrollViewLoopV(self, "ChatMainPanel/MessagePanel", 0, self.onCellChanged)

	self.view:addEventValueChanged(self.onViewValueChanged)

	self.panelMessage = UIControls.Panel(self, "ChatMainPanel/MessagePanel")
	self.panelMessageSize = self.panelMessage:getRectSize()
	self.panelNothing = UIControls.Panel(self, "ChatMainPanel/MessagePanel/ImgNothing")
	self.togglePanel = UIControls.Panel(self, "ChatMainPanel/AutoSetPanel")
	self.toggleVoice = UIControls.Toggle(self, "ChatMainPanel/AutoSetPanel/VoicePanel", "Label")

	self.toggleVoice:addEventValueChanged(self.onVoiceToggle)

	self.toggleBullet = UIControls.Toggle(self, "ChatMainPanel/AutoSetPanel/CheckBulletScreen", "Label")

	self.toggleBullet:addEventValueChanged(self.onBulletToggle)

	self.toggleShowRedMsg = UIControls.Toggle(self, "ChatMainPanel/AutoSetPanel/CheckRedMoney", "Label")

	self.toggleShowRedMsg:addEventValueChanged(self.onShowRedMsgToggle)
	self.togglePanel:setVisible(false)

	self.toggleSize = self.togglePanel:getRectSize()
	self.personalPanel = ChatPersonalPanel(self, "ChatMainPanel/PersonalPanel")
	self.apprenticePanel = ChatApprenticePanel(self, "ChatMainPanel/TeacherPanel")
	self.masterPanel = ChatMasterPanel(self, "ChatMainPanel/StudentPanel")
	self.tabChannels = {}
	self.tabDic = {}

	local panels = {
		self.view,
		self.view,
		self.view,
		self.personalPanel
	}

	for i = 1, 5 do
		local tabChannel = UIControls.Button(self, "ChatMainPanel/TabPanel/BtnChannel" .. i, "Text")

		if i == 4 then
			local redHint = UIControls.RedDot(self, "ChatMainPanel/TabPanel/BtnChannel" .. i .. "/IconNew")

			redHint:addHint({
				UIConst.RD_HINT_CHAT_PRIVATE
			})
		end

		if i == 5 then
			local redHint = UIControls.RedDot(self, "ChatMainPanel/TabPanel/BtnChannel" .. i .. "/IconNew")

			redHint:addHint({
				UIConst.RD_HINT_CHAT_MASTER_APPRENTICE
			})
		end

		local tabConfig = Const.CHANNEL_TABS[i]

		tabChannel.tabType = tabConfig.tabType
		tabChannel.channel = tabConfig.sendChannel
		tabChannel.receiveChannels = tabConfig.receiveChannels
		tabChannel.index = i
		tabChannel.panel = panels[i]

		tabChannel:addEventClick(self.onChannelSelected)

		self.tabChannels[i] = tabChannel
		self.tabDic[tabConfig.tabType] = tabChannel

		if i == 4 and ChannelUtil.isDMMGame() then
			tabChannel:setVisible(false)
		end
	end

	self.mainPanel.size = self.mainPanel:getRectSize()
	self.btnRedPacket = UIControls.Button(self, "ChatMainPanel/InputPanel/BtnRedMoney")

	self.btnRedPacket:addEventClick(self.onBtnRedPacketClick)

	self.imageRedPacket = UIControls.Image(self, "ChatMainPanel/InputPanel/BtnRedMoney/Icon")
	self.btnJumpRedPacket = UIControls.Button(self, "ChatMainPanel/BtnMoreRedMoney", "Text")

	self.btnJumpRedPacket:addEventClick(self.onBtnJumpRedPacketClick)

	self.imgJumpRedArrow = UIControls.Image(self, "ChatMainPanel/BtnMoreRedMoney/Text/Icon")
	self.checkInitMap = {}

	local type = ResClientHardCode[13].value[1]

	if type and ResRedPacketShow[type] then
		local str = ResRedPacketShow[type].option_str

		self.toggleShowRedMsg:setText(str)
	end
end

function ChatDlg:onOpen()
	ChatDlg.super.onOpen(self)
	self:refreshMasterApprentice()
end

function ChatDlg:_checkMsgSend()
	local avatar = CurAvatar
	local now = os.time()
	local channelInfo = CHANNEL_CONFIG[self.mCurSend]
	local time = now - channelInfo.lastSendTime

	if time < ResCommonHardCode[1].value[1] then
		return Lang.get(30161)
	end

	if time < channelInfo.sendInterval then
		return string.format(channelInfo.overTimeTip, channelInfo.sendInterval - time)
	end
end

function ChatDlg:checkLimitState(...)
	local isLimit = false

	if self.selectTabType == Const.CHAT_TAB_TYPE.Private then
		if #self.mMsgDatas == 0 then
			local checkFriend = false

			for uid, info in pairs(CurAvatar.friendList) do
				if not CurAvatar:isMyMaster(uid) and not CurAvatar:isMyApprentice(uid) and info then
					checkFriend = true
				end
			end

			if not checkFriend and not self.personalPanel.linkHere then
				isLimit = true

				self.personalPanel:setVisible(false)
				self.txtHint:setText(Lang.get(30162))
				self.btnJoin:setVisible(true)
			else
				self.personalPanel:setVisible(true)
			end
		end
	elseif self.selectTabType == Const.CHAT_TAB_TYPE.Guild and CurAvatar:isInCircle() == false then
		isLimit = true

		if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_CIRCLE) then
			local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_CIRCLE)

			self.txtHint:setText(string.format(Lang.get(30158), unlockDesc))
			self.btnJoin:setVisible(false)
		else
			self.txtHint:setText(Lang.get(3425))
			self.btnJoin:setVisible(true)
		end
	end

	if isLimit == true then
		local ui = UIManager.getUI("chatEmojiBox", nil, false)

		if ui then
			ui:setVisible(false)
		end

		self.panelInput:setVisible(false)
		self.panelHint:setVisible(true)
	else
		self.panelInput:setVisible(true)
		self.panelHint:setVisible(false)
	end

	return isLimit
end

function ChatDlg:_getMaxCount(channel)
	local count = MsgManager.getMsgLimitCount(channel)

	return count
end

function ChatDlg:_updateMsgs(isBottom)
	if self.selectTabType == Const.CHAT_TAB_TYPE.Private then
		self.personalPanel:updateMsg(self.mMsgDatas)
	elseif self.selectTabType == Const.CHAT_TAB_TYPE.MasterApprentice then
		if self.selectTab.panel then
			self.selectTab.panel:updateMsg(self.mMsgDatas)
		end
	else
		self:refreshList(isBottom and 1 or nil)
	end
end

function ChatDlg:inputEnable()
	self.panelHint:setVisible(false)
	self.panelInput:setVisible(true)
end

function ChatDlg:onBtnJoingClick(sender)
	if self.mCurSend == Const.CHANNEL_PRIVATE then
		UIManager.getUI("friendAddDlg", true)
	elseif self.mCurSend == Const.CHANNEL_GUILD then
		local circleListDlg = UIManager.getUI("circleListDlg", true)

		circleListDlg:initCircleList()
	end

	self:setVisible(false)
end

function ChatDlg:_updateNews()
	local curNewCount = 0

	for i, msgData in ipairs(self._newMsgs) do
		for j, channel in ipairs(self.mCurReceives) do
			if msgData.channel == channel then
				curNewCount = curNewCount + 1
			end
		end
	end

	self:setNewHint(curNewCount)
end

function ChatDlg:setNewHint(curNewCount)
	local needHint = curNewCount ~= 0

	self.btnNewHint:setVisible(needHint)

	if needHint then
		if curNewCount > 99 then
			curNewCount = "99+"
		end

		self.btnNewHint:setText(string.format(Lang.get(30159), curNewCount))
	end
end

function ChatDlg:_checkCurChannelInfo()
	if not self:getVisible() then
		return
	end

	self.panelHint:setVisible(false)

	local info = Const.CHANNEL_TABS[self._selectIndex]

	self._isLock = false
	self.mCurSend = info.sendChannel
	self.mCurReceives = info.receiveChannels

	local canSend = self.mCurSend ~= nil

	self.panelInput:setVisible(canSend)

	if self.mCurSend == Const.CHANNEL_WORLD then
		if Const.RED_PACK_ENABLE then
			self.btnRedPacket:setVisible(true)

			local type = ResClientHardCode[13].value[1]

			if type and type ~= 1 and ResRedPacketShow[type] then
				local imagePath = ResRedPacketShow[type].chat_button_image_path
				local imageName = ResRedPacketShow[type].chat_button_image_name
				local newMsgText = ResRedPacketShow[type].chat_newmsg_str

				self.imageRedPacket:setImage(imagePath, imageName)
				self.btnJumpRedPacket:setText(newMsgText)
			end
		else
			self.btnRedPacket:setVisible(false)
		end
	else
		self.btnRedPacket:setVisible(false)
	end

	self.mMsgDatas = {}
	self._newMsgs = {}

	self.receiver:changeChannel(self.mCurReceives)

	local isLimit = self:checkLimitState()

	self.btnNewHint:setVisible(false)

	local useBullet = false
	local useRedMsg = false

	if Const.RED_PACK_ENABLE then
		useRedMsg = self.mCurSend == Const.CHANNEL_WORLD
	end

	local showBullet = MsgManager.getBulletChannels()[self.mCurSend] ~= false
	local showVoiceToggle = false

	self:_showToggle(useBullet, showVoiceToggle, showBullet, isLimit, useRedMsg)
end

function ChatDlg:_showToggle(useBullet, showVoice, showBullet, isLimit, useRedMsg)
	if isLimit == false and (useBullet or showVoice or useRedMsg) then
		self.togglePanel:setVisible(true)
		self.panelMessage:setRecttransform(UIConst.AnchorPresets.VertStretchLeft, MESSAGE_CONTENT_X_WIDTH, MESSAGE_CONTENT_TOP_BOTTOM)

		if useBullet then
			self.toggleBullet:setVisible(true)
			self.toggleBullet:setOn(showBullet)
		else
			self.toggleBullet:setVisible(false)
		end

		if showVoice then
			self.toggleVoice:setVisible(true)
		else
			self.toggleVoice:setVisible(false)
		end

		if useRedMsg then
			self.toggleShowRedMsg:setVisible(true)
			self.toggleShowRedMsg:setOn(not MsgManager.isHideRedMsg())
		else
			self.toggleShowRedMsg:setVisible(false)
		end
	else
		self.togglePanel:setVisible(false)

		local vec = Vector2(MESSAGE_CONTENT_TOP_BOTTOM.x - self.toggleSize.height, MESSAGE_CONTENT_TOP_BOTTOM.y)

		self.panelMessage:setRecttransform(UIConst.AnchorPresets.VertStretchLeft, MESSAGE_CONTENT_X_WIDTH, vec)
	end
end

function ChatDlg:refreshListTop(...)
	self:refreshList(1)
end

function ChatDlg:refreshList(jumpIdx)
	local count = #self.mMsgDatas

	if count > 5 then
		self.checkInitMap[self.mCurSend] = true
	end

	self.view:setTotalCount(count, jumpIdx)
	self.panelNothing:setVisible(count == 0)
end

function ChatDlg:_addMsg(msg)
	self:_limitMsgCount()
	table.insert(self.mMsgDatas, msg)
end

function ChatDlg:onMsgReceive(msgData)
	if self.selectTabType == Const.CHAT_TAB_TYPE.Private then
		self.personalPanel:onMsgReceive(msgData)
	elseif self.selectTabType == Const.CHAT_TAB_TYPE.MasterApprentice then
		if self.selectTab.panel then
			self.selectTab.panel:onMsgReceive(msgData)
		end
	elseif self:isShow(msgData) then
		local avatar = CurAvatar
		local isSelf = false

		if avatar and msgData.suid == avatar.uid then
			if msgData.channel == Const.CHANNEL_WORLD then
				local data = CurAvatar:parseMsgOtherInfo(msgData.other)

				if data and #data > 0 then
					if #data == 1 then
						-- block empty
					else
						isSelf = data[1] ~= Const.CUSTOM_MSG_DATA_TYPE.RED_THX and data[1] ~= Const.CUSTOM_MSG_DATA_TYPE.RED_CLAIM
					end
				else
					isSelf = true
				end
			else
				isSelf = true
			end
		end

		if isSelf or not self._isLock or self.checkInitMap[self.mCurSend] ~= true then
			self:_addMsg(msgData)
			self:refreshListTop()
		else
			table.insert(self._newMsgs, msgData)
			self:_updateNews()
		end
	end
end

function ChatDlg:_limitMsgCount(...)
	self.mMsgDatas = MsgManager.checkMsgCount(self.mMsgDatas, self.mCurSend)
end

function ChatDlg:onMsgUpdate(msgDatas)
	self.mMsgDatas = {}

	for i, msg in ipairs(msgDatas) do
		if self:isShow(msg) then
			local uid

			if msg.suid == CurAvatar.uid then
				uid = msg.ruid
			else
				uid = msg.suid
			end

			if self.selectTabType == Const.CHAT_TAB_TYPE.Private then
				if not CurAvatar:isMyMaster(uid) and not CurAvatar:isMyApprentice(uid) and (CurAvatar.friendList[uid] or MsgManager.getPlayerInfo(uid)) then
					table.insert(self.mMsgDatas, msg)
				end
			elseif self.selectTabType == Const.CHAT_TAB_TYPE.MasterApprentice then
				if CurAvatar:isMyMaster(uid) or CurAvatar:isMyApprentice(uid) then
					table.insert(self.mMsgDatas, msg)
				end
			else
				table.insert(self.mMsgDatas, msg)
			end
		end
	end

	self:_updateMsgs(true)
end

function ChatDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ChatCell(sender, "System/Chat/BroChatMessageInfoPanel", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setVisible(false)
	targetCell:setData(self.mMsgDatas[newIdx], self:isNeedShowTime(newIdx, self.mMsgDatas))
	targetCell:setVisible(true)
end

function ChatDlg:isNeedShowTime(index, msgs)
	if index == 1 then
		return true, true
	end

	if msgs[index].time - msgs[index - 1].time > Const.CHAT_TIME_INTERVAL then
		return true, true
	end

	return false
end

function ChatDlg:onViewValueChanged(sender, vx, vy)
	if vy < 99 then
		self._isLock = true
	else
		self._isLock = false

		self:checkNewMsg()
	end

	self:checkJumpRedPacketShow()
end

function ChatDlg:checkNewMsg(...)
	if #self._newMsgs > 0 then
		for i, msgData in ipairs(self._newMsgs) do
			for j, channel in ipairs(self.mCurReceives) do
				if msgData.channel == channel then
					self:_addMsg(msgData)

					break
				end
			end
		end

		self._newMsgs = {}

		self:_updateMsgs()
		self:_updateNews()
		self:refreshList()
	end
end

function ChatDlg:onHintGoTop(sender)
	if self.selectTabType == Const.CHAT_TAB_TYPE.Private then
		self.personalPanel:onHintGoTop()
	elseif self.selectTabType == Const.CHAT_TAB_TYPE.MasterApprentice then
		if self.selectTab.panel then
			self.selectTab.panel:onHintGoTop()
		end
	else
		local newIdx = #self._newMsgs

		self:checkNewMsg()
		self:refreshList(newIdx)

		self._isLock = false
	end

	self.btnNewHint:setVisible(false)
end

function ChatDlg:onChannelSelected(sender)
	if self.selectTab then
		self.selectTab:setEnable(true)

		if self.selectTab.panel then
			self.selectTab.panel:setVisible(false)
		end
	end

	self.selectTab = sender
	self._selectIndex = sender.index
	self.selectTabType = sender.tabType

	self.selectTab:setEnable(false)

	if sender.tabType == Const.CHAT_TAB_TYPE.MasterApprentice then
		if CurAvatar:checkHaveMaster() then
			sender.panel = self.masterPanel
		elseif CurAvatar:checkHaveApprentice() then
			sender.panel = self.apprenticePanel
		else
			sender.panel = nil
		end
	end

	if sender.panel then
		sender.panel:setVisible(true)
	end

	self:_checkCurChannelInfo()
	self:checkJumpRedPacketShow()
end

function ChatDlg:onBulletToggle(sender, isOn)
	local info = Const.CHANNEL_TABS[self._selectIndex]
	local avatar = CurAvatar

	if info and avatar then
		MsgManager.changeBulletChannels(info.sendChannel, isOn)
	end
end

function ChatDlg:onVoiceToggle(sender, isOn)
	for _, channel in ipairs(self.mCurReceives) do
		-- block empty
	end
end

function ChatDlg:onShowRedMsgToggle(sender, isOn)
	MsgManager.setHideRedMsg(not isOn)
end

local function OperaDebugMenu()
	local debugCanvas = UIManager.tryGetUI("debug")

	if debugCanvas and debugCanvas:isInShow() then
		UIManager.tryHideUI("debug")
		MsgManager.notice(Lang.get(51861))
	else
		UIManager.getUI("debug", true)
		MsgManager.notice(Lang.get(37074))
	end
end

function ChatDlg:onMsgSend(sender, content, moveEmojiFunc)
	local clear = true
	local text = ""

	if content then
		clear = false
		text = content
	else
		text = self.editInput:getText()
	end

	local mgr = MsgManager

	if VersionUtils.isTestVersion() and text == "//showdebug" then
		OperaDebugMenu()

		return
	end

	if string.find(text, "//") == 1 then
		if string.find(text, ",") then
			local args = utils.splitString(text, ",")
			local server = tonumber(args[2])

			RPC.executeGM(args[1], server)
		else
			RPC.executeGM(text)
		end

		return
	end

	if self.mCurSend == Const.CHANNEL_WORLD and CurAvatar:forbidWorldChannel() then
		local timeStr = ClientUtils.getTimeStrBySecond(CurAvatar.roleCreateTick + 604800 - ClientUtils.getServerTime())

		mgr.notice(string.format(Lang.get(102253), timeStr))

		return
	end

	if CurAvatar:isLockConditionChat() then
		return
	end

	if CurAvatar:isForbidChat() then
		return
	end

	if ChatService.isConnected() == false then
		mgr.notice(Lang.get(30164))

		return
	end

	local hint = self:_checkMsgSend()

	if hint ~= nil then
		mgr.notice(hint)

		return
	end

	if not moveEmojiFunc and text == "" then
		mgr.notice(Lang.get(30165))

		return
	end

	if self:_checkMsgLength(text) == false then
		return
	end

	local res = self:checkContent(text)
	local uid, gid

	if self.selectTabType == Const.CHAT_TAB_TYPE.Private then
		uid = self.personalPanel:getCurUid()
	elseif self.selectTabType == Const.CHAT_TAB_TYPE.MasterApprentice and self.selectTab.panel then
		uid = self.selectTab.panel:getCurUid()
	end

	local isResetTime = false

	if moveEmojiFunc then
		isResetTime = true

		moveEmojiFunc(self.mCurSend, uid)
	elseif mgr.send(res, self.mCurSend, uid, gid) then
		isResetTime = true

		if clear then
			self.editInput:setText("")
		end
	end

	if isResetTime then
		CHANNEL_CONFIG[self.mCurSend].lastSendTime = os.time()
	end
end

function ChatDlg:_checkMsgLength(text)
	local len = utils.utf8len(text, 2)

	if len > Const.MAX_CHAT_CHARACTER then
		MsgManager.notice(Lang.get(30166))

		return false
	end

	return true
end

function ChatDlg:checkContent(text)
	local res = string.gsub(text, "\r\n", "")
	local largeLength = 0

	for s in string.gmatch(res, "<.->") do
		if emojiDic.single[s] then
			largeLength = string.len(s)

			if string.len(res) ~= largeLength then
				res = string.gsub(res, s, "*")

				break
			end
		elseif not emojiDic.more[s] then
			res = string.gsub(res, s, "*")
		end
	end

	return res
end

function ChatDlg:onEmojiSelect(sender)
	local ui = UIManager.getUI("chatEmojiBox", nil, false)

	if ui then
		-- block empty
	else
		UIManager.getUI("chatEmojiBox", true):show(self.editInput, Slot(self.onMsgSend, self), Slot(self.onInVisivle, self))
		self.mainPanel:setRectSize(self.mainPanel.size.width, -EMOJI_PANEL_HEIGHT)
	end
end

function ChatDlg:onInVisivle()
	self.mainPanel:setRectSize(self.mainPanel.size.width, self.mainPanel.size.height)

	if self.selectTabType == Const.CHAT_TAB_TYPE.Private then
		self.personalPanel:refreshShow()
	elseif self.selectTabType == Const.CHAT_TAB_TYPE.MasterApprentice then
		if self.selectTab.panel then
			self.selectTab.panel:refreshShow()
		end
	else
		self:refreshShow()
	end
end

function ChatDlg:refreshShow(...)
	self:refreshListTop()
end

function ChatDlg:refreshFriendList(player)
	if self.selectTabType == Const.CHAT_TAB_TYPE.Private then
		self.personalPanel:refreshFriendList(player)
	end
end

function ChatDlg:addFriendTalk(otherPlayer)
	if self.isOpenOver == true then
		self:_addFriendTalk(otherPlayer)
	else
		self.postOpenFunc = Functor(self._addFriendTalk, self, otherPlayer)
	end
end

function ChatDlg:_addFriendTalk(otherPlayer)
	if CurAvatar:isMyMaster(otherPlayer.uid) or CurAvatar:isMyApprentice(otherPlayer.uid) then
		local tab = self.tabDic[Const.CHAT_TAB_TYPE.MasterApprentice]

		self:onChannelSelected(tab)

		if tab.panel then
			tab.panel:talkWithPlayer(otherPlayer)
		end
	else
		local tab = self.tabDic[Const.CHAT_TAB_TYPE.Private]

		self.personalPanel.linkHere = true

		self:onChannelSelected(tab)
		self.personalPanel:addFriendTalkOut(otherPlayer)
	end
end

function ChatDlg:openChannel(msg)
	local channel = Const.CHANNEL_WORLD

	if msg then
		channel = msg.channel
	end

	self.needJumpMsg = msg
	self._selectIndex = self:getIndexByChannel(channel)

	if self.isOpenOver == true then
		self:initShow()
	end
end

function ChatDlg:openChannelOnly(channel)
	channel = channel or Const.CHANNEL_WORLD
	self._selectIndex = self:getIndexByChannel(channel)

	if self.isOpenOver == true then
		self:initShow()
	end
end

function ChatDlg:initShow(...)
	self:onChannelSelected(self.tabChannels[self._selectIndex])
	self:jumpToMsg()
end

function ChatDlg:jumpToMsg()
	if self.needJumpMsg == nil then
		return
	end

	local index = 1

	if self.mMsgDatas then
		local msg

		for i = #self.mMsgDatas, 1, -1 do
			msg = self.mMsgDatas[i]

			if msg.seq == self.needJumpMsg.seq and msg.content == self.needJumpMsg.content then
				index = #self.mMsgDatas - i + 1

				break
			end
		end
	end

	self:refreshList(index)

	self.needJumpMsg = nil
end

function ChatDlg:getIndexByChannel(channel)
	if self.tabChannels then
		for _, tab in ipairs(self.tabChannels) do
			if tab.channel == channel then
				return tab.index
			end

			for _, c in ipairs(tab.receiveChannels) do
				if c == channel then
					return tab.index
				end
			end
		end
	end

	return 1
end

function ChatDlg:getPlayerInfo(uid)
	if self.selectTabType == Const.CHAT_TAB_TYPE.Private then
		return self.personalPanel:getPlayerInfo(uid)
	elseif self.selectTabType == Const.CHAT_TAB_TYPE.MasterApprentice and self.selectTab.panel then
		return self.selectTab.panel:getPlayerInfo(uid)
	end
end

function ChatDlg:onBtnRedPacketClick(...)
	local allRedPacket = CurAvatar:getItemsByStype({
		[Const.ITEM_STYPE_RED_PACKET] = true
	})
	local canUseRedPacket = false

	for _, item in ipairs(allRedPacket) do
		if not item:isOverdue() then
			canUseRedPacket = true

			break
		end
	end

	local type = ResClientHardCode[13].value[1]

	if type and type ~= 1 and ResRedPacketShow[type] then
		local prefabId = ResRedPacketShow[type].choose_canvas_id

		UIManager.replacePrefabOfDlg("chooseRedPacketDlg", prefabId)
	end

	if canUseRedPacket then
		local ui = UIManager.getUI("chooseRedPacketDlg", true)

		ui:show(type)
	else
		MsgManager.clientNotice(399)
	end
end

function ChatDlg:onBtnJumpRedPacketClick(...)
	local index = self:isRedPacketBtnShow()

	if index then
		self:refreshList(index)
	else
		local type = ResClientHardCode[13].value[1]
		local id = ResRedPacketShow[type].overdue_id or 398

		MsgManager.clientNotice(id)
		self:checkJumpRedPacketShow()
	end
end

function ChatDlg:isRedPacketBtnShow(...)
	if self.mCurSend ~= Const.CHANNEL_WORLD then
		return
	end

	if ConditionLimitManager.inLimitState(88) then
		return
	end

	if CurAvatar.redPacketData and CurAvatar.redPacketData.day_get >= ResUpperLimit[1].red_package_diamond then
		return
	end

	if self.cells then
		for i, cell in pairs(self.cells) do
			local msg = self.mMsgDatas[i]

			if msg and msg.share == Const.CHAT_SHARE_TYPE.RED_PACKET and not CurAvatar:isRedPacketClaimed(msg.seq) then
				return
			end
		end
	end

	for i = #self.mMsgDatas, 1, -1 do
		local msg = self.mMsgDatas[i]

		if msg and msg.share == Const.CHAT_SHARE_TYPE.RED_PACKET and not CurAvatar:isRedPacketClaimed(msg.seq) then
			local jumpIndex = #self.mMsgDatas - i + 1
			local isUp = false

			if self.cells then
				for j, cell in pairs(self.cells) do
					if i < j then
						isUp = true

						break
					end
				end
			end

			return jumpIndex, isUp
		end
	end
end

function ChatDlg:checkJumpRedPacketShow(refresh)
	if refresh then
		self:refreshList()
	end

	local index, isUp = self:isRedPacketBtnShow()

	if index then
		self.btnJumpRedPacket:setVisible(true)

		if isUp then
			self.imgJumpRedArrow:setRotate(0)
		else
			self.imgJumpRedArrow:setRotate(180)
		end
	else
		self.btnJumpRedPacket:setVisible(false)
	end
end

function ChatDlg:isShow(msg)
	if not MsgManager.isHideRedMsg() then
		return true
	end

	return not MsgManager.isRedMsgRelate(msg)
end

function ChatDlg:onRedTogleStateChange()
	self.toggleShowRedMsg:setOn(not MsgManager.isHideRedMsg())

	if self._selectIndex then
		self:onChannelSelected(self.tabChannels[self._selectIndex])
	end
end

function ChatDlg:refreshMasterApprentice()
	local checkShow = Const.Master_Apprentice_OPEN and (CurAvatar:checkHaveMaster() or CurAvatar:checkHaveApprentice())

	self.tabChannels[5]:setVisible(checkShow)

	if self.selectTabType == Const.CHAT_TAB_TYPE.MasterApprentice and not checkShow then
		self:onChannelSelected(self.tabChannels[1])
	end
end

return ChatDlg
