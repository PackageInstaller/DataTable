-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/ChatMsgMo.lua

module("logic.extensions.chat.model.ChatMsgMo", package.seeall)

local ChatMsgMo = class("ChatMsgMo")
local json = require("cjson")

function ChatMsgMo:ctor()
	self._msgId = nil
	self._senderId = nil
	self._senderName = nil
	self._receiverId = nil
	self._channel = nil
	self._msgType = nil
	self._content = nil
	self._sendTime = nil
	self._isRead = false
	self.headIconId = nil
	self.headFrameId = nil
	self.bubbleId = nil
	self._regressEndTime = nil
	self.areaName = nil
	self.enableChatWordEffect = false
end

function ChatMsgMo:InitWithChatMsgNo(msg)
	self._msgId = msg.msgId
	self._senderId = msg.senderId
	self._channel = msg.channelType
	self.areaName = msg.areaName
	self._senderName = ""
	self.headIconId = 0
	self.headFrameId = 0
	self.vipLv = 0
	self.playerLv = 0

	if msg.HasField == nil then
		if msg.headInfo then
			self._senderName = msg.headInfo.userName
			self.headIconId = msg.headInfo.headIconId
			self.headFrameId = msg.headInfo.headFrameId
			self.vipLv = msg.headInfo.vipLv
			self.playerLv = msg.headInfo.playerLv
		else
			local friendMo = FriendModel.instance:getFriendMo(msg.senderId)

			if friendMo then
				self._senderName = friendMo:getValue("name")
				self.headIconId = friendMo.headIconId
				self.headFrameId = friendMo.headFrameId
				self.vipLv = friendMo.vipLv
				self.playerLv = friendMo.playerLv
			end
		end
	elseif msg:HasField("headInfo") then
		self._senderName = msg.headInfo.userName
		self.headIconId = msg.headInfo.headIconId
		self.headFrameId = msg.headInfo.headFrameId
		self.vipLv = msg.headInfo.vipLv
	else
		local friendMo = FriendModel.instance:getFriendMo(msg.senderId)

		if friendMo then
			self._senderName = friendMo:getValue("name")
			self.headIconId = friendMo.headIconId
			self.headFrameId = friendMo.headFrameId
			self.vipLv = friendMo.vipLv
			self.playerLv = friendMo.playerLv
		end
	end

	self._regressEndTime = checknumber(msg.regressEndTime) / 1000

	if string.nilorempty(self._senderName) then
		if self._senderId == tostring(LoginModel.instance.userId) then
			self._senderName = RoleModel.instance:getUserName()

			local headId = RoleModel.instance:getHeadIconId()

			self.headIconId = headId
			self.headFrameId = RoleModel.instance:getHeadFrameId()
			self.vipLv = RoleModel.instance:getVipLvl()

			local recallInfo = RoleModel.instance:getRegressInfo()

			if recallInfo and checknumber(recallInfo.touchTimeMillis) > 0 then
				self._regressEndTime = RecallTaskModel.instance:getReturnPlayerEndTime()
			end
		elseif self._channel == GameEnum.ChatChannel.Private then
			local mo = FriendModel.instance:getFriendMo(self._senderId)

			if mo ~= nil then
				self._senderName = mo:getValue("name")
				self.headIconId = mo.headIconId
				self.headFrameId = mo.headFrameId
				self.vipLv = mo.vipLv
				self.playerLv = mo.playerLv
			end
		end
	end

	if checknumber(msg.receiveId) > 0 then
		self._receiverId = msg.receiveId or tostring(LoginModel.instance.userId)
	end

	self._msgType = msg.msgType
	self._content = msg.content
	self.enableChatWordEffect = msg.enableChatWordEffect

	if self._channel == GameEnum.ChatChannel.Private then
		local friendMo = FriendModel.instance:getFriendMo(self._senderId)

		if friendMo then
			self.enableChatWordEffect = friendMo:getEnableChatWordEffect()
		end
	end

	self:_parseParams()

	self._sendTime = checknumber(msg.sendTime) / 1000
	self.bubbleId = msg.bubbleId

	if self:getIsMe() then
		self._isRead = true
		self.enableChatWordEffect = ChatSettingModel.instance:GetEnableChatWordEffect()
	end
end

function ChatMsgMo:InitWithLocalStore(t)
	self._msgId = t.msgId
	self._senderId = t.senderId
	self._senderName = t.senderName
	self._receiverId = t.receiveId
	self._channel = t.channel
	self._msgType = t.msgType
	self._content = t.content
	self._sendTime = t.sendTime
	self._isRead = t.isRead
	self.headIconId = t.headIconId
	self.headFrameId = t.headIconId
	self.bubbleId = t.bubbleId
	self._regressEndTime = t.regressEndTime
	self.vipLv = t.vipLv
	self.playerLv = t.playerLv

	local friendMo = FriendModel.instance:getFriendMo(t.senderId)

	if friendMo then
		self.enableChatWordEffect = friendMo:getEnableChatWordEffect()
	end

	if not self.headIconId and friendMo then
		self.headIconId = friendMo.headIconId
		self.headFrameId = friendMo.headFrameId
		self.vipLv = friendMo.vipLv
		self.playerLv = friendMo.playerLv
	end

	self:_parseParams()

	if self:getIsMe() then
		self._isRead = true
		self.enableChatWordEffect = ChatSettingModel.instance:GetEnableChatWordEffect()
	end
end

function ChatMsgMo:_parseParams()
	if self:isSystemMsg() and not string.nilorempty(self._content) then
		local t = json.decode(self._content)

		self._params = t.params or {}
	end

	return 0
end

function ChatMsgMo:getParam(name, toNumber)
	if toNumber == nil then
		toNumber = true
	end

	if self._params then
		local value = self._params[name]

		if toNumber then
			value = checknumber(value)
		end

		return value
	elseif toNumber then
		return 0
	else
		return nil
	end
end

function ChatMsgMo:hasParams()
	local hasParams = false

	if self._params then
		for _, v in pairs(self._params) do
			hasParams = true

			break
		end
	end

	return hasParams
end

function ChatMsgMo:Get(key)
	return self["_" .. key]
end

function ChatMsgMo:setCellHeight(value)
	self._contentHeight = value
end

function ChatMsgMo:getCellHeight()
	return self._contentHeight
end

function ChatMsgMo:getMsgType()
	return self._msgType
end

function ChatMsgMo:getIsMe()
	return self._senderId ~= nil and tostring(self._senderId) == tostring(LoginModel.instance.userId)
end

function ChatMsgMo:getFriendId()
	local userId = tostring(LoginModel.instance.userId)

	if self._senderId and tostring(self._senderId) == userId then
		return self._receiverId or -1
	elseif self._receiverId and tostring(self._receiverId) == userId then
		return self._senderId or -1
	else
		return -1
	end
end

function ChatMsgMo:getChannel()
	return self._channel
end

function ChatMsgMo:getReceiverId()
	return self._receiverId
end

function ChatMsgMo:getSenderId()
	return self._senderId
end

function ChatMsgMo:getHeadIconId()
	if self:getIsMe() then
		return RoleModel.instance:getHeadIconId()
	else
		local friendMo = FriendModel.instance:getFriendMo(self._senderId)

		if friendMo then
			return friendMo.headIconId
		else
			return checknumber(self.headIconId)
		end
	end
end

function ChatMsgMo:getHeadFrameId()
	if self:getIsMe() then
		return RoleModel.instance:getHeadFrameId()
	else
		local friendMo = FriendModel.instance:getFriendMo(self._senderId)

		if friendMo then
			return friendMo.headFrameId
		else
			return checknumber(self.headFrameId)
		end
	end
end

function ChatMsgMo:getSendTime()
	return self._sendTime
end

function ChatMsgMo:isSystemMsg()
	return self._msgType == GameEnum.ChatType.System or self._msgType == GameEnum.ChatType.Pet or self._msgType == GameEnum.ChatType.Form or self._msgType == GameEnum.ChatType.Share or self._msgType == GameEnum.ChatType.Lantern or self._msgType == GameEnum.ChatType.Recall or self._msgType == GameEnum.ChatType.Honor or self._msgType == GameEnum.ChatType.CutePetTravel
end

function ChatMsgMo:isSystemMsgWithHead()
	return self._msgType == GameEnum.ChatType.System and checknumber(self._senderId) <= 0
end

function ChatMsgMo:getContent()
	if self._channel == GameEnum.ChatChannel.ElementSpark then
		local content = self._content
		local chunkPlanId = self:getParam("chunkPlanId")

		if chunkPlanId and chunkPlanId > 0 then
			local chunkId = self:getParam("chunkId")
			local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(chunkPlanId, chunkId)

			return string.format("<color=#33B57FFF>(%s,%s)</color>", chunkCfg.pos[1], chunkCfg.pos[2])
		else
			return content
		end
	elseif self:isSystemMsg() then
		local content = ""

		if not string.nilorempty(self._content) then
			local t = GameUtil.jsonToTable(self._content)
			local id = checknumber(t.tpId)
			local cfg = ChatConfig.instance:getSystemMsgT(id)

			if cfg then
				content = StringUtil.parseJsonParams(cfg.template, t.params)
			end
		else
			print("chatMsg content isNil msgId = " .. tostring(self._msgId))
		end

		return content
	elseif self._msgType == GameEnum.ChatType.CodeWord then
		local content = self._content

		if not string.nilorempty(self._content) then
			local t = json.decode(self._content)
			local codeWordGroupId = checknumber(t.groupId)
			local codeWordId = checknumber(t.id)
			local cfgCodeWord = CodeWordConfig.instance:getTextCfg(codeWordGroupId, codeWordId)

			if cfgCodeWord then
				content = cfgCodeWord.text
			end
		end

		return content
	end

	return self._content or ""
end

function ChatMsgMo:getTpId()
	local status, result = xpcall(self._getTpId, function(errMsg)
		return
	end, self)

	if not status then
		return 0
	else
		return result or 0
	end
end

function ChatMsgMo:_getTpId()
	if not string.nilorempty(self._content) then
		local t = json.decode(self._content)

		return (checknumber(t.tpId))
	end

	return 0
end

function ChatMsgMo:getSenderName()
	if self._senderId == tostring(LoginModel.instance.userId) then
		self._senderName = RoleModel.instance:getUserName()
	end

	return self._senderName
end

function ChatMsgMo:getMainUIContent()
	local content = self:getContent()

	if self._msgType == GameEnum.ChatType.Word then
		if self._channel == GameEnum.ChatChannel.Private then
			return string.format("<color=#518cd6>[%s]</color><color=#c675e9>对我说：%s</color>", self._senderName, HyperlinkHandler.ChangeRichText(content))
		elseif self._channel == GameEnum.ChatChannel.System then
			return content
		else
			return string.format("<color=#4fd8fa>[%s]：</color>%s", self._senderName, HyperlinkHandler.ChangeRichText(content))
		end
	elseif self._msgType == GameEnum.ChatType.System then
		return content
	elseif self._msgType == GameEnum.ChatType.RedEnvelope then
		return "[红包]"
	elseif self._msgType == GameEnum.ChatType.Voice then
		return "[语音]"
	elseif self._msgType == GameEnum.ChatType.Sprite then
		local emojiId = checknumber(content)
		local cfg = ChatConfig.instance:getEmojiCfg(emojiId)
		local emojiContent = ""

		emojiContent = cfg ~= nil and "[表情-" .. cfg.name .. "]" or "[表情-]"

		if self._channel == GameEnum.ChatChannel.Private then
			return string.format("<color=#518cd6>[%s]</color><color=#c675e9>对我说：%s</color>", self._senderName, emojiContent)
		elseif self._channel == GameEnum.ChatChannel.System then
			return content
		else
			return string.format("<color=#4fd8fa>[%s]：</color>%s", self._senderName, emojiContent)
		end
	else
		return content
	end
end

function ChatMsgMo:getRegressEndTime()
	return checknumber(self._regressEndTime)
end

function ChatMsgMo:toTable()
	local t = {}

	t.msgId = self._msgId
	t.senderId = self._senderId
	t.senderName = self._senderName
	t.receiveId = self._receiverId
	t.channel = self._channel
	t.msgType = self._msgType
	t.content = self._content
	t.sendTime = self._sendTime
	t.isRead = self._isRead
	t.vipLv = self.vipLv
	t.playerLv = self.playerLv
	t.headIconId = self:getHeadIconId()
	t.headFrameId = self:getHeadFrameId()
	t.bubbleId = self.bubbleId
	t.regressEndTime = self._regressEndTime
	t.areaName = self.areaName

	return t
end

return ChatMsgMo
