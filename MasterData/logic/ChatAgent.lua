-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/agent/ChatAgent.lua

module("logic.extensions.chat.agent.ChatAgent", package.seeall)

local ChatAgent = class("ChatAgent", BaseAgent)

function ChatAgent:sendGetChatSettingsAndOfflineMsgsReq()
	local req = ChatExtension_pb.GetChatSettingsAndOfflineMsgsReq()

	self:sendMsg(req)
end

function ChatAgent:handleGetChatSettingsAndOfflineMsgsRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadOfflineChatMsg===back")

	if status == 0 then
		print("getOffline")

		local dailyfreetimes = msg.dailyFreeTimes

		NewChatModel.instance:setUsedWorldChatFreeTimes(dailyfreetimes)
		NewChatModel.instance:setAllChatFreeTimes(msg.allFreeTimes)
		NewChatModel.instance:OnGetOfflineMsgs(msg.offlineMsgs)
		NewChatModel.instance:OnGetChatBubbleId(msg.chatBubbleId)
		ChatSettingModel.instance:Init(msg.settings)

		if msg.offlineMsgs ~= nil and #msg.offlineMsgs > 0 then
			self:sendDelOfflineMsgsReq()
		end
	end
end

function ChatAgent:sendDelOfflineMsgsReq()
	local req = ChatExtension_pb.DelOfflineMsgsReq()

	self:sendMsg(req)
end

function ChatAgent:handleDelOfflineMsgsRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChatAgent:sendSendMsgReq(channel, type, content, receiveId, decrType, callback)
	if not AntiAddictionController.instance:checkHasRealNameByTips() then
		return
	end

	self._sendCall = callback

	local req = ChatExtension_pb.SendMsgReq()

	req.channelType = channel
	req.msgType = type
	req.content = content

	if receiveId ~= nil then
		req.receiveId = receiveId
	end

	if decrType then
		req.decrType = decrType
	end

	self:sendMsg(req)
end

function ChatAgent:handleSendMsgRes(status, msg)
	if status == 0 then
		if self._sendCall then
			self._sendCall()

			self._sendCall = nil
		end

		if checknumber(msg.channelType) == GameEnum.ChatChannel.All then
			NewChatModel.instance:useAllChatFreeTimes()

			local times = VipModel.instance:getFreeTimesOfChatOnAll() - NewChatModel.instance:getAllChatFreeUseTimes()

			if times > 0 then
				TipsFacade.instance:openCommonTips(langPara("全服频道今日免费次数：%s", times))
			end
		end
	end
end

function ChatAgent:handleNotifyNewMsgRes(status, msg)
	if status == 0 then
		NewChatModel.instance:OnNotifyNewMsg(msg.newMsg)
		GlobalDispatcher:dispatch(GlobalNotify.LanternTriggerInfo, msg.newMsg)
	end
end

function ChatAgent:sendSetChatSettingsReq(callback)
	self._setChatSettingCall = callback

	local req = ChatExtension_pb.SetChatSettingsReq()
	local settings = req.settings

	settings.allConumeNotice = ChatSettingModel.instance:GetConumeNotice(GameEnum.ChatChannel.All)
	settings.zoneConumeNotice = ChatSettingModel.instance:GetConumeNotice(GameEnum.ChatChannel.Zone)
	settings.worldConumeNotice = ChatSettingModel.instance:GetConumeNotice(GameEnum.ChatChannel.World)

	local rollings = ChatSettingModel.instance:GetAllMainShow()
	local voices = ChatSettingModel.instance:GetAllAutoVoice()
	local rollingRet, voiceRet = 0, 0

	for _, i in pairs(GameEnum.ChatChannel) do
		if rollings[i] == true then
			rollingRet = GameUtil.setBitByDigit(rollingRet, i, true)
		end

		if voices[i] == true then
			voiceRet = GameUtil.setBitByDigit(voiceRet, i, true)
		end
	end

	settings.rollingShowSettings = rollingRet
	settings.autoPlayVoice = voiceRet
	settings.enableChatWordEffect = ChatSettingModel.instance:GetEnableChatWordEffect()

	self:sendMsg(req)
end

function ChatAgent:handleSetChatSettingsRes(status, msg)
	if status == 0 then
		ChatSettingModel.instance:Init(msg.settings)

		if self._setChatSettingCall then
			self._setChatSettingCall()
		end
	end
end

function ChatAgent:sendBatchSendMsgToBuddyReq(channel, msgType, content, buddIds, callback, target)
	self._callBack = callback
	self._target = target

	local req = ChatExtension_pb.BatchSendMsgToBuddyReq()
	local msg_pb = ChatExtension_pb.SendMsgReq()

	msg_pb.channelType = channel
	msg_pb.msgType = msgType
	msg_pb.content = content

	if msg_pb ~= nil then
		req.msg:ParseFromString(msg_pb:SerializeToString())
	end

	for i, v1 in ipairs(buddIds) do
		req.buddIds:append(v1)
	end

	self:sendMsg(req)
end

function ChatAgent:handleBatchSendMsgToBuddyRes(status, msg)
	if status == 0 and self._callBack then
		if self._target then
			self._callBack(self._target, self)
		else
			self._callBack()
		end
	end
end

function ChatAgent:sendPM_GetOtherUserPetReq(otherUerId, showOffKey, handler)
	self._handler = handler

	local req = ChatExtension_pb.PM_GetOtherUserPetReq()

	req.otherUerId = otherUerId
	req.showOffKey = showOffKey

	self:sendMsg(req)
end

function ChatAgent:handlePM_GetOtherUserPetRes(status, msg)
	if status == 0 then
		if self._handler then
			self._handler(msg)
		end
	end
end

function ChatAgent:sendPM_GetOtherUserFormReq(otherUserId, showOffKey, handler)
	self._handler = handler

	local req = ChatExtension_pb.PM_GetOtherUserFormReq()

	req.otherUserId = otherUserId
	req.showOffKey = showOffKey

	self:sendMsg(req)
end

function ChatAgent:handlePM_GetOtherUserFormRes(status, msg)
	if status == 0 then
		if self._handler then
			self._handler(msg)
		end
	end
end

function ChatAgent:sendPM_SelectChatBubbleReq(bubbleId)
	local req = ChatExtension_pb.PM_SelectChatBubbleReq()

	req.bubbleId = bubbleId

	self:sendMsg(req)
end

function ChatAgent:handlePM_SelectChatBubbleRes(status, msg)
	if status == 0 then
		NewChatController.instance:handlePM_SelectChatBubbleRes()
	end
end

function ChatAgent:sendPM_GetEmoticonGroupInfoReq()
	local req = ChatExtension_pb.PM_GetEmoticonGroupInfoReq()

	self:sendMsg(req)
end

function ChatAgent:handlePM_GetEmoticonGroupInfoRes(status, msg)
	if status == 0 then
		NewChatController.instance:handlePM_GetEmoticonGroupInfoRes(msg)
	end
end

function ChatAgent:sendPM_GetCodeWordInfoReq()
	local req = ChatExtension_pb.PM_GetCodeWordInfoReq()

	self:sendMsg(req)
end

function ChatAgent:handlePM_GetCodeWordInfoRes(status, msg)
	if status == 0 then
		CodeWordController.instance:onGetCodeWordInfoRes(msg)
	end
end

function ChatAgent:handlePM_NotifyCodeWordPrizeRes(status, msg)
	if status == 0 then
		CodeWordController.instance:onNotifyCodeWordPrizeRes(msg)
	end
end

function ChatAgent:handlePM_NotifyCodeWordChangeRes(status, msg)
	if status == 0 then
		CodeWordController.instance:onNotifyCodeWordChangeRes(msg)
	end
end

ChatAgent.instance = ChatAgent.New()

return ChatAgent
