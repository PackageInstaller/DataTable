-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\MsgManager.lua

local UserData = require("Helper/UserData")
local OtherPlayer = require("Common/Object/OtherPlayer")
local EventConst = require("EventConst")
local HeadHelper = require("UI/RoleInfo/HeadHelper")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResRentHelpHonour = require("ClientData/ResRentHelpHonour")
local ResItem = require("ClientData/ResItem")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local ResColor = require("ClientData/ResColor")
local ResRedPacketShow = require("ClientData/ResRedPacketShow")
local CHATRPC = CHATRPC
local Time = Time
local MsgManager = {}
local MAX_PERSONAL_RECORD = 50
local MAX_SHIELD_COUNT = 50
local SAVE_COUNTER = {
	[Const.CHANNEL_WORLD] = 10,
	[Const.CHANNEL_GUILD] = 30,
	[Const.CHANNEL_PRIVATE] = 10
}
local SAVE_INTERVAL = 300
local self = MsgManager
local UserDataKey = "chat_save"
local bulletDatakey = "Bullet_save"
local UserDataCount = 300
local SEND_CD = {
	[Const.CHANNEL_WORLD] = 0,
	[Const.CHANNEL_GUILD] = 2,
	[Const.CHANNEL_SHOUT] = 1
}

self.receivers = {}
self.mMsgDatas = {}
self.privateRepeatMap = {}
self.mSendCDInfo = {}

function MsgManager.initMsg()
	self._initCounter()
	self._loadMsg()

	local bulletDlg = UIManager.getUI("bulletDlg", nil, false)

	if bulletDlg then
		bulletDlg:clearAll()
	end

	for i, receiver in ipairs(self.receivers) do
		receiver:update()
	end
end

function MsgManager._initCounter(...)
	self.counter = {}
	self.shieldDic = {}
	self.saveTime = os.time()

	if self.curUid == nil or self.curUid ~= CurAvatar.uid then
		self._loadBulletConfig()
	end

	self.curUid = CurAvatar.uid

	for i, channelData in ipairs(Const.CHANNEL_TABS) do
		self.counter[channelData.sendChannel] = 0
	end

	self.getBulletChannels()
end

function MsgManager._loadMsg()
	self._puid = CurAvatar.uid
	self.mMsgDatas = {}
	self.privateRepeatMap = {}

	local saveInfo = UserData.loadCommonData(CurAvatar.uid .. UserDataKey)

	if saveInfo == nil then
		return
	end

	saveInfo = utils.unserialize(saveInfo)

	if saveInfo ~= nil then
		if saveInfo.uid == self._puid and saveInfo.msgs ~= nil then
			for i, msg in ipairs(saveInfo.msgs) do
				if msg.time == nil then
					msg.time = 0
				end

				self._addMsg(msg)

				self.privateRepeatMap[msg.seq] = true
			end
		end

		self.notFriends = saveInfo.friendInfos or {}
		self.shieldDic = saveInfo.shieldDic or {}
	end

	self.refreshRed()
end

function MsgManager.saveMsg()
	if not CurAvatar or not CurAvatar.uid then
		return
	end

	self.saveTime = os.time()

	local saveData = {}

	saveData.uid = self._puid

	local checkRepeat = {
		count = 0
	}
	local msgs = {}
	local index = 0
	local privateMsgs = self.mMsgDatas[Const.CHANNEL_PRIVATE] or {}
	local len = #privateMsgs

	for i = 1, len do
		index = len - i + 1

		local msgItem = privateMsgs[index]

		if msgItem ~= nil then
			local uid = 0

			if msgItem.ruid == CurAvatar.uid then
				uid = msgItem.suid
			else
				uid = msgItem.ruid
			end

			if ClientUtils.record.checkRecord[uid] and msgItem.is_unread then
				msgItem.is_unread = msgItem.suid ~= CurAvatar.uid and msgItem.time > ClientUtils.record.checkRecord[uid].time
			end

			if checkRepeat[uid] then
				if checkRepeat[uid] < MAX_PERSONAL_RECORD then
					table.insert(msgs, 1, msgItem)

					checkRepeat[uid] = checkRepeat[uid] + 1
				end
			elseif checkRepeat.count < Const.MAX_PRIVATE_FRIEND then
				checkRepeat[uid] = 1
				checkRepeat.count = checkRepeat.count + 1

				table.insert(msgs, 1, msgItem)
			end
		end

		if #msgs >= UserDataCount then
			break
		end
	end

	local friends = {}

	for uid, info in pairs(checkRepeat) do
		if self.notFriends and self.notFriends[uid] then
			friends[uid] = self.notFriends[uid]
		end
	end

	saveData.shieldDic = self.shieldDic
	saveData.friendInfos = friends
	saveData.msgs = msgs

	UserData.saveCommonData(CurAvatar.uid .. UserDataKey, utils.serialize(saveData))
	self.saveBulletConfig()
end

function MsgManager.onAccountChange(...)
	self.saveMsg()
end

function MsgManager.clearMsgByChannel(cid)
	if cid and self.mMsgDatas[cid] then
		self.mMsgDatas[cid] = {}
	end
end

function MsgManager.isPrivateRepeat(seq)
	return self.privateRepeatMap[seq] == true
end

function MsgManager.getNewestPrivateSeq(...)
	local data = self.mMsgDatas[Const.CHANNEL_PRIVATE]

	if data and #data > 0 then
		local msg = data[#data]

		return msg.seq
	else
		return "1420750023695540201"
	end
end

function MsgManager._getLastMsgTime(channel)
	if self.mMsgDatas then
		local data = self.mMsgDatas[channel]

		if data and #data > 0 then
			return data[#data].time
		end
	end

	return -1
end

function MsgManager._addMsg(msg)
	self.mMsgDatas[msg.channel] = self.mMsgDatas[msg.channel] or {}

	local data = self.mMsgDatas[msg.channel]
	local len = #data

	if len == 0 or data[len].time <= msg.time then
		table.insert(data, msg)
	else
		local idx = 1

		for i = 0, len - 1 do
			local item = data[len - i]

			if item.time <= msg.time then
				idx = len - i + 1

				break
			end
		end

		table.insert(data, idx, msg)
	end

	self.mMsgDatas[msg.channel] = self.checkMsgCount(self.mMsgDatas[msg.channel], msg.channel)
end

function MsgManager.checkMsgCount(msgDatas, channel)
	if msgDatas == nil or channel == nil then
		return msgDatas
	end

	local limitCount, removeNum, config = self.getMsgLimitCount(channel)

	if limitCount <= #msgDatas then
		if config and config.keepConfig then
			local data = {}
			local normalCount = 0
			local redPacketCount = 0
			local msg

			for i = #msgDatas, 1, -1 do
				msg = msgDatas[i]

				if self.isRedMsgRelate(msg) then
					if redPacketCount < config.keepConfig.redPacket then
						redPacketCount = redPacketCount + 1

						table.insert(data, 1, msg)
					end
				elseif normalCount < config.keepConfig.normal then
					normalCount = normalCount + 1

					table.insert(data, 1, msg)
				end
			end

			msgDatas = data
		else
			for i = 1, removeNum do
				table.remove(msgDatas, 1)
			end
		end
	end

	return msgDatas
end

function MsgManager.getMsgLimitCount(channel)
	if channel == nil then
		return Const.DEFAULT_MAX_MSG_COUNT, Const.DEFAULT_REMOVE_MSG_COUNT
	end

	local info = Const.CHANNEL_CONFIG[channel]

	if info then
		return info.limitCount or Const.DEFAULT_MAX_MSG_COUNT, info.removeNum or Const.DEFAULT_REMOVE_MSG_COUNT, info
	end

	return Const.DEFAULT_MAX_MSG_COUNT, Const.DEFAULT_REMOVE_MSG_COUNT, info
end

function MsgManager.getChannelMsgs(channelIds)
	channelIds = channelIds or {}

	local tempData = {}

	for i, cid in pairs(channelIds) do
		local data = self.mMsgDatas[cid]

		if data then
			for i, msg in ipairs(data) do
				table.insert(tempData, msg)
			end
		end
	end

	table.sort(tempData, function(v1, v2)
		return v1.time < v2.time
	end)

	return tempData
end

function MsgManager.receive(msg, channel, name, uid, time, voiceID, voiceLength)
	local sattr = {}

	sattr.name = name or ""

	local msgItem = {}

	msgItem.suid = uid or ""
	msgItem.time = time
	msgItem.content = msg
	msgItem.sattr = sattr
	msgItem.voiceid = voiceID
	msgItem.voicetime = voiceLength
	msgItem.show = {}

	self.receiveFromServer(channel, msgItem)
end

function MsgManager.receiveFromServer(channel, msgItem, history)
	local entity = CurAvatar

	if entity and msgItem.ruid ~= entity.uid then
		if entity and msgItem.suid and entity.inMyBlackList and entity:inMyBlackList(msgItem.suid) then
			return
		end

		if channel == Const.CHANNEL_GUILD then
			if tostring(entity:getCircleChatId()) ~= msgItem.gid then
				return
			end
		elseif channel == Const.CHANNEL_WORLD and entity.chatWorldGid ~= msgItem.gid then
			return
		end
	end

	msgItem.channel = msgItem.channel or channel
	msgItem.is_unread = true

	if msgItem.time == 0 or msgItem.time == nil then
		local time = self._getLastMsgTime(msgItem.channel)

		time = time + 0.5

		if time < 0 then
			time = ClientUtils.getServerTime()
		end

		msgItem.time = time
	end

	msgItem.isVoice = false

	self._addMsg(msgItem)
	self.checkPlayerInfo(msgItem)

	for i, receiver in pairs(self.receivers) do
		receiver:onReceive(msgItem)
	end

	EventCenter.sendEvent(EventConst.RECEIVE_NEW_MSG, channel, msgItem)

	if entity and msgItem.suid == entity.uid then
		EventCenter.sendEvent(EventConst.MSG_SELF_SENDED, msgItem)

		if channel == Const.CHANNEL_WORLD then
			RPC.masterClientUpdateProgress("kResMasterApprenticeTaskActionWorldChatTimes", 1)
		elseif channel == Const.CHANNEL_PRIVATE then
			local ruid = msgItem.ruid

			if CurAvatar:isMyApprentice(ruid) or CurAvatar:isMyMaster(ruid) then
				RPC.masterClientUpdateProgress("kResMasterApprenticeTaskActionMasterApprenticeChatTimes", 1)
			end
		end
	end

	self._checkSaveCounter(msgItem)
	self.refreshRed()
end

function MsgManager.sendBySystem(msg, channel, other)
	self.send(msg, channel, nil, nil, true, other)
end

function MsgManager.send(msg, channel, uid, gid, isSystem, other)
	isSystem = isSystem or false

	if uid == nil then
		uid = "0"
	end

	if channel == Const.CHANNEL_WORLD then
		gid = gid or CurAvatar.chatWorldGid
	elseif channel == Const.CHANNEL_GUILD then
		if CurAvatar:isInCircle() == false then
			self.notice(Lang.get(30050))

			return
		end

		gid = gid or CurAvatar:getCircleChatId()
	elseif channel == Const.CHANNEL_SERVER then
		gid = gid or CurAvatar.chatZoneId
	end

	if utils.isRobot(uid) then
		CurAvatar:receiveFakePersonMsg(msg, uid)
	else
		CHATRPC.chatSend(channel, uid, gid, msg, nil, nil, isSystem, self._getTencentToken(), other)

		local Analytics = require("SDK/Analytics")

		Analytics.onChatSend(channel, uid, gid, msg)
	end

	return true
end

function MsgManager._getTencentToken()
	local infoStr

	if ChannelUtil.isQQGame() then
		local SDKImpFlowNew = require("SDK/SDKImp/SDKImpFlowNew")
		local id, key = SDKImpFlowNew.GetInstance():getQQInfo()

		if id and key then
			infoStr = id .. "|" .. key
		end
	end

	return infoStr
end

function MsgManager.clientNotice(noticeId)
	if ResClientNotice[noticeId] then
		self.notice(ResClientNotice[noticeId].notice or "")
	end
end

function MsgManager.notice(msg)
	self.receive(msg, Const.CHANNEL_NOTICE)
end

function MsgManager.registReceiver(newReceiver)
	local length = 999

	for i = 1, length do
		local receiver = self.receivers[i]

		if receiver == nil then
			self.receivers[i] = newReceiver

			return i
		end
	end

	talbe.insert(self.receivers, newReceiver)

	return #self.receivers
end

function MsgManager.unregistReceiver(id)
	self.receivers[id] = nil
end

function MsgManager._checkSaveCounter(msgItem)
	if not self.counter then
		return
	end

	local isSave = false

	if os.time() - self.saveTime > SAVE_INTERVAL then
		self.saveMsg()

		isSave = true
		self.counter[Const.CHANNEL_PRIVATE] = 0
	end

	local channel = msgItem.channel
	local num = self.counter[channel]

	if not self.isRedMsgRelate(msgItem) then
		self.refreshBulletTimeInfo(msgItem)
	end

	if channel == Const.CHANNEL_PRIVATE and isSave == false then
		num = num + 1

		if num >= SAVE_COUNTER[channel] then
			self.saveMsg()

			num = 0
		end

		self.counter[channel] = num
	end
end

function MsgManager.checkPlayerInfo(msgItem)
	if msgItem.channel ~= Const.CHANNEL_PRIVATE then
		return
	end

	local ui = UIManager.getUI("chatDlg", nil, false)
	local player
	local uid = 0
	local comm

	if msgItem.ruid == CurAvatar.uid then
		uid = msgItem.suid
		comm = msgItem.sattr
	else
		uid = msgItem.ruid
	end

	if ui then
		player = ui:getPlayerInfo(uid)
	end

	if player == nil then
		player = OtherPlayer()

		player:initDataByMsg(msgItem)
	end

	local isChange = self._updatePlayerInfo(player, comm)

	if player then
		self.notFriends[player.uid] = player
	end

	if isChange and ui then
		ui:refreshFriendList(player)
	end
end

function MsgManager._updatePlayerInfo(player, comm)
	if comm and player then
		local isChange = false

		for k, attr in pairs(comm) do
			if player[k] == nil or player[k] ~= attr then
				isChange = true
			end

			player[k] = attr
		end

		return isChange
	end
end

function MsgManager.getPlayerInfo(uid)
	return self.notFriends[uid]
end

function MsgManager._loadBulletConfig(...)
	local saveInfo = UserData.loadCommonData(bulletDatakey)

	if saveInfo == nil or saveInfo == "" then
		self.saveBulletConfig()

		return
	end

	local data = utils.unserialize(saveInfo)

	if data.bulletChannels then
		self.bulletChannels = {}

		for k, v in pairs(Const.DEFAULT_BULLET_CHANNELS) do
			if data.bulletChannels[k] then
				self.bulletChannels[k] = data.bulletChannels[k]
			else
				self.bulletChannels[k] = false
			end
		end
	else
		self.bulletChannels = utils.copyTable(Const.DEFAULT_BULLET_CHANNELS)
	end

	local checkInfo = UserData.loadCommonData(CurAvatar.uid .. bulletDatakey)
	local data = utils.unserialize(checkInfo)

	self.checkTimeInfo = data.checkTimeInfo or {}

	self._setLastBulletTime(self.checkTimeInfo)
end

function MsgManager.getLastBulletTime(channel)
	return self.lastBulletTimeInfo and self.lastBulletTimeInfo[channel] or 0
end

function MsgManager.saveLastBulletTime(...)
	self.saveBulletConfig()
	self._setLastBulletTime(self.checkTimeInfo)
end

function MsgManager._setLastBulletTime(timeInfo)
	self.lastBulletTimeInfo = {}

	for c, t in pairs(timeInfo) do
		self.lastBulletTimeInfo[c] = t
	end
end

function MsgManager.getBulletChannels(...)
	if not self.bulletChannels then
		self._loadBulletConfig()
	end

	return self.bulletChannels
end

function MsgManager.changeBulletAllChannels(isOn)
	for channel, _ in pairs(Const.DEFAULT_BULLET_CHANNELS) do
		self.changeBulletChannels(channel, isOn)
	end
end

function MsgManager.getBulletChannelState(channel)
	return self.getBulletChannels()[channel] ~= false
end

function MsgManager.isAllBulletChannelOff(...)
	for c, _ in pairs(Const.DEFAULT_BULLET_CHANNELS) do
		if self.getBulletChannelState(c) then
			return false
		end
	end

	return true
end

function MsgManager.changeBulletChannels(channel, isOn)
	local curChannels = self.getBulletChannels()

	if isOn then
		if not curChannels[channel] then
			curChannels[channel] = Const.CHANNEL_TO_TYPE[channel] or 0
		end
	else
		curChannels[channel] = false
	end

	self.checkTimeInfo[channel] = self.checkTimeInfo[channel] or 0

	self.saveBulletConfig()
	self._setLastBulletTime(self.checkTimeInfo)

	local ui = UIManager.getUI("bulletDlg", nil, false)

	if ui then
		ui:refreshChannels(self.getBulletChannels())
	end
end

function MsgManager.getTableCountWithoutNil(t)
	local count = 0

	for i, data in pairs(t) do
		if data then
			count = count + 1
		end
	end

	return count
end

function MsgManager.saveBulletConfig()
	local data = {}

	if self.bulletChannels == nil then
		self.bulletChannels = utils.copyTable(Const.DEFAULT_BULLET_CHANNELS)
	end

	self.checkTimeInfo = self.checkTimeInfo or {}

	for name, id in pairs(self.bulletChannels) do
		self.checkTimeInfo[name] = self.checkTimeInfo[name] or 0
	end

	data.bulletChannels = self.bulletChannels

	local checkData = {}

	checkData.checkTimeInfo = self.checkTimeInfo

	if not CurAvatar or not CurAvatar.uid then
		return
	end

	UserData.saveCommonData(CurAvatar.uid .. bulletDatakey, utils.serialize(checkData))
	UserData.saveCommonData(bulletDatakey, utils.serialize(data))
end

function MsgManager.getBulletTimeInfo(channel)
	if self.checkTimeInfo then
		return self.checkTimeInfo[channel] or 0
	end
end

function MsgManager.refreshBulletTimeInfo(msgItem, forceNow)
	self.checkTimeInfo = self.checkTimeInfo or {}

	local channels = self.getBulletChannels()

	if forceNow then
		for c, t in pairs(channels) do
			self.checkTimeInfo[c] = math.max(self.checkTimeInfo[c] or 0, 0)
		end

		self.saveLastBulletTime()
	elseif msgItem and channels[msgItem.channel] ~= nil then
		local preTime = self.checkTimeInfo[msgItem.channel] or 0

		self.checkTimeInfo[msgItem.channel] = math.max(self.checkTimeInfo[msgItem.channel] or 0, msgItem.time)
	end
end

function MsgManager.addShield(uid)
	if utils.getTableElemCount(self.shieldDic, true) >= MAX_SHIELD_COUNT then
		utils.removeTableElements(self.shieldDic, 5, function(v1, v2)
			return v1 < v2
		end)
	end

	self.shieldDic[uid] = os.time()
end

function MsgManager.removeShield(uid)
	self.shieldDic[uid] = nil
end

function MsgManager.isInShield(uid)
	return self.shieldDic[uid] or false
end

function MsgManager.showMsgOnScreen(v)
	local ui = UIManager.getUI("bulletDlg", nil, false)

	if ui then
		ui:showMsg(v)
	end

	local ui = UIManager.getUI("speakerbox", nil, false)

	if ui then
		ui:showMsg(v)
	end
end

function MsgManager.getScreenMsgHideflag()
	local hideFlag = false
	local ui = UIManager.getUI("speakerbox", nil, false)

	if ui then
		hideFlag = ui.hideFlag
	end

	return hideFlag
end

local COLOR_HEADFRAME = {
	nil,
	nil,
	nil,
	"cf75fe",
	"eecb42",
	"ff71b1",
	"ff3700"
}
local CIRCLE_DUTY_COLOR = {
	[Const.CIRCLE_DUTY_BOSS] = ResColor.ORANGE,
	[Const.CIRCLE_DUTY_ASSISTANT] = ResColor.COLORRANK04,
	[Const.CIRCLE_DUTY_MANAGER] = ResColor.CIRCLEJOB03,
	[Const.CIRCLE_DUTY_MEMBER] = ResColor.WHITE
}

function MsgManager.getMsgColorFormatByMsg(msg)
	if msg == nil or msg.content == nil or MsgManager.isSystemMsg(msg) then
		return
	end

	if utils.isLargeEmoji(msg.content) then
		return
	end

	local color

	if CurAvatar.myCircle and msg.channel == Const.CHANNEL_GUILD then
		local uid = msg.sattr.uid
		local member = CurAvatar.myCircle:getCircleMember(uid)

		if member and member.duty ~= Const.CIRCLE_DUTY_MEMBER then
			color = CIRCLE_DUTY_COLOR[member.duty].ff
		end
	end

	if not color then
		local info = HeadHelper.getHeadFrameInfoById(msg.sattr.head_frame_id or 0)

		if info and info.msg_color then
			if (msg.sattr.head_frame_end_time or 0) < msg.time then
				return
			end

			color = COLOR_HEADFRAME[info.msg_color]
		end
	end

	if color then
		return "<color=#" .. color .. ">%s" .. "</color>"
	end
end

function MsgManager.isSuperRedPacket(msg)
	if msg == nil or msg.content == nil or MsgManager.isSystemMsg(msg) then
		return false
	end

	if msg.share ~= Const.CHAT_SHARE_TYPE.RED_PACKET then
		return false
	end

	local specData = msg.share_content.specData

	if specData then
		local itemId = specData.item_id
		local item = ResItem[specData.item_id]
		local showType = item and item.extend_args5 and item.extend_args5[1] or 1

		if itemId == ResRedPacketShow[showType].super_item_id then
			return item
		end
	end
end

function MsgManager.isNormalRedPacket(msg)
	if msg == nil or msg.content == nil or MsgManager.isSystemMsg(msg) then
		return false
	end

	if msg.share ~= Const.CHAT_SHARE_TYPE.RED_PACKET then
		return false
	end

	local specData = msg.share_content.specData

	if specData then
		local itemId = specData.item_id
		local item = ResItem[specData.item_id]
		local showType = item and item.extend_args5 and item.extend_args5[1] or 1

		if itemId == ResRedPacketShow[showType].normal_item_id then
			return item
		end
	end
end

function MsgManager.isRedMsgRelate(msg)
	if msg == nil or msg.content == nil or MsgManager.isSystemMsg(msg) then
		return false
	end

	local _isRedMsgRelate = false

	if self.isNormalRedPacket(msg) or self.isSuperRedPacket(msg) then
		_isRedMsgRelate = true
	end

	if not _isRedMsgRelate then
		local data = CurAvatar:parseMsgOtherInfo(msg.other)

		if data and (data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_THX or data[1] == Const.CUSTOM_MSG_DATA_TYPE.RED_CLAIM) then
			_isRedMsgRelate = true
		end
	end

	return _isRedMsgRelate
end

function MsgManager.setHideRedMsg(v)
	self._isHideRedMsg = v

	local value = 0

	if v then
		value = 1
	end

	UserData.saveCommonDataInt("keyHideRedMsgOnChatDlg", value)

	local ui = UIManager.tryGetUI("chatDlg")

	if ui then
		ui:onRedTogleStateChange()
	end
end

function MsgManager.isHideRedMsg(...)
	if not self._isHideRedMsg then
		self._isHideRedMsg = UserData.loadCommonDataInt("keyHideRedMsgOnChatDlg") == 1
	end

	return self._isHideRedMsg
end

function MsgManager.isLegalEmoji(key)
	if self.emojiDic == nil then
		self.emojiDic = {}

		for path, info in pairs(UIConst.EMOJI_DATA) do
			for i, eKey in ipairs(info.data or {}) do
				self.emojiDic[eKey] = true
			end
		end
	end

	return self.emojiDic[key]
end

function MsgManager.getRentEmoji(helpCount, uid)
	if CurAvatar.syncDataReady and uid == CurAvatar.uid then
		helpCount = RentTaskUtils.getTotalHelpCount()
	end

	for i = #ResRentHelpHonour, 1, -1 do
		local info = ResRentHelpHonour[i]

		if helpCount >= info.help_cnt then
			return info.icon
		end
	end
end

function MsgManager.getCirclePreFix(msg, isLeft)
	if not Const.FORCE_OPEN_CIRCLE_BATTLE then
		return
	end

	if not CurAvatar.syncDataReady or not CurAvatar:isInCircle() or not CurAvatar.myCircle then
		return
	end

	local uid = msg.sattr.uid
	local member = CurAvatar.myCircle:getCircleMember(uid)

	if member then
		local dutyIcon = CurAvatar:getDutyIcon(member.duty)
		local titleInfo = CurAvatar.myCircle:getCircleTitle(uid)

		if titleInfo then
			if isLeft then
				return titleInfo.icon .. dutyIcon
			else
				return dutyIcon .. titleInfo.icon
			end
		else
			return dutyIcon
		end
	end
end

function MsgManager.getChannelUIConfig(msg)
	if not msg then
		return
	end

	if msg.sub_channel ~= Const.CHANNEL_NONE then
		return UIConst.CHANNEL_ICON_MAP[msg.sub_channel]
	else
		return UIConst.CHANNEL_ICON_MAP[msg.channel]
	end
end

function MsgManager.isSystemMsg(msg)
	if msg.channel ~= Const.MAIN_CHANNEL_SYSTEM and msg.sub_channel == Const.CHANNEL_NONE then
		return false
	end

	return true
end

function MsgManager.getMsgShowRange(msg)
	local config = Const.MSG_COMMON_CONFIG[msg.sub_channel]

	config = config or Const.MSG_COMMON_CONFIG[msg.channel]

	if config then
		return config.timeRange or 0
	end

	return 0
end

function MsgManager.checkShowMsg(time, msg)
	local range = self.getMsgShowRange(msg)

	if range > 0 then
		return msg.time > ClientUtils.getServerTime() - range
	end

	local _time = time or self.getBulletTimeInfo(msg.channel)

	if _time < msg.time then
		msg.is_unread = false
	end

	return _time < msg.time
end

function MsgManager.refreshRed()
	if not CurAvatar then
		return
	end

	local msgDatas = self.getChannelMsgs({
		Const.CHANNEL_PRIVATE
	})
	local checkPrivateRed = false
	local checkMasterApprenticeRed = false
	local checkHaveMaster = CurAvatar:checkHaveMaster()
	local checkHaveApprentice = CurAvatar:checkHaveApprentice()

	for _, data in ipairs(msgDatas) do
		local uid = data.suid

		if uid == CurAvatar.uid or not data.is_unread then
			-- block empty
		else
			if checkHaveMaster then
				if CurAvatar:isMyMaster(uid) then
					checkMasterApprenticeRed = true
				end
			elseif checkHaveApprentice then
				if CurAvatar:isMyApprentice(uid) then
					checkMasterApprenticeRed = true
				end
			else
				checkPrivateRed = true
			end

			if checkPrivateRed and (not checkHaveMaster and not checkHaveApprentice or checkMasterApprenticeRed) then
				break
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_CHAT_PRIVATE, checkPrivateRed)
	RedDotManager.setKeyState(UIConst.RD_HINT_CHAT_MASTER_APPRENTICE, checkMasterApprenticeRed)
end

return MsgManager
