-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/controller/NewChatController.lua

module("logic.extensions.view.controller.NewChatController", package.seeall)

local NewChatController = class("NewChatController", BaseController)

function NewChatController:ctor()
	return
end

function NewChatController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.BattleEnter, self._onBattleEnter, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleEnd, self._onBattleEnd, self)
end

function NewChatController:onReset()
	self._curShowChannel = nil
	self._curShowTeamChannel = nil

	if self._resLoadersEP then
		for k, v in pairs(self._resLoadersEP) do
			GameUtil.unloadMultiResLoaderResource(v)

			self._resLoadersEP[k] = nil
		end

		self._resLoadersEP = nil
	end
end

function NewChatController:getShowChannel()
	return self._curShowChannel
end

function NewChatController:setShowChannel(channel)
	self._curShowChannel = channel
end

function NewChatController:getCurChannel()
	if self._curChannel then
		return self._curChannel
	else
		return GameEnum.ChatChannel.World
	end
end

function NewChatController:setCurChannel(channel)
	self._curChannel = channel
end

function NewChatController:getSendLeftTime(channel)
	local cd = ChatConfig.instance:GetSendCd(channel) or 0

	if cd <= 0 then
		return 0
	else
		self._lastSendTime = self._lastSendTime or {}

		if not self._lastSendTime[channel] then
			return 0
		else
			return cd - ServerTime.now() + self._lastSendTime[channel]
		end
	end
end

function NewChatController:setSendTime(channel)
	self._lastSendTime = self._lastSendTime or {}
	self._lastSendTime[channel] = ServerTime.now()
end

function NewChatController:GetIsOnBattle()
	return self._isOnBattle or false
end

function NewChatController:_onBattleEnter()
	self._battleMsgId = -1
	self._isOnBattle = true
	self._lastChannel = self._curChannel

	self:setCurChannel(GameEnum.ChatChannel.Battle)
	GlobalDispatcher:addListener(GlobalNotify.BattleRecords, self._onBattleRecords, self)
end

function NewChatController:_onBattleEnd()
	self._isOnBattle = false

	self:setCurChannel(self._lastChannel)
	NewChatModel.instance:ClearChannelMsg(GameEnum.ChatChannel.Battle)
	GlobalDispatcher:removeListener(GlobalNotify.BattleRecords, self._onBattleRecords, self)
end

function NewChatController:_onBattleRecords(records)
	if not records then
		return
	end

	for _, v in ipairs(records) do
		local t = {
			senderId = 0,
			senderName = "",
			msgId = self._battleMsgId,
			channelType = GameEnum.ChatChannel.Battle,
			msgType = GameEnum.ChatType.System,
			content = v,
			sendTime = ServerTime.now()
		}

		NewChatModel.instance:OnNotifyNewMsg({
			t
		})

		self._battleMsgId = self._battleMsgId - 1
	end
end

function NewChatController:sendPM_SelectChatBubbleReq(bubbleId)
	self._sendBublleId = bubbleId

	ChatAgent.instance:sendPM_SelectChatBubbleReq(bubbleId)
end

function NewChatController:handlePM_SelectChatBubbleRes()
	NewChatModel.instance:OnGetChatBubbleId(self._sendBublleId)
	GlobalDispatcher:dispatch(GlobalNotify.ChatFrameChange)
end

function NewChatController:handlePM_GetEmoticonGroupInfoRes(msg)
	NewChatModel.instance:setUnlockedEmoticonGroupIds(msg.unlockedEmoticonGroupIds)
	GlobalDispatcher:dispatch(GlobalNotify.ChatEmojiInfo)
end

function NewChatController:getShowTeamChannel()
	return self._curShowTeamChannel
end

function NewChatController:setShowTeamChannel(flag)
	self._curShowTeamChannel = flag
end

function NewChatController:loadEmojiPack(id, finishedCall)
	self._resLoadersEP = self._resLoadersEP or {}

	local loader = self._resLoadersEP[id]

	if loader ~= nil and loader.isAllLoaded then
		finishedCall(loader)
	elseif loader == nil then
		loader = MultiResLoader.New()
		loader.finishCalls = {}

		local cfg = ChatConfig.instance:getEmojiCfg(id)
		local urlList = {}

		if cfg then
			local groupCfg = ChatConfig.instance:getEmojiGroupCfg(cfg.groupId)

			for i = 1, cfg.length do
				local url = string.format("ui/emoji/%s/%s/%s_%s.png", groupCfg.groupPrefix, cfg.icon, cfg.icon, i)

				table.insert(urlList, url)
			end
		end

		loader.isAllLoaded = false

		loader:setResPaths(urlList)
		table.insert(loader.finishCalls, finishedCall)
		loader:load(self._onResLoaded, nil, self)

		self._resLoadersEP[id] = loader
	else
		table.insert(loader.finishCalls, finishedCall)
	end
end

function NewChatController:_onResLoaded(loader)
	loader.isAllLoaded = true

	local finishCalls = loader.finishCalls

	for i = 1, #finishCalls do
		finishCalls[i](loader)
	end

	loader.finishCalls = nil
end

function NewChatController:removeLoadEmojiPackCallback(id, finishedCall)
	self._resLoadersEP = self._resLoadersEP or {}

	local loader = self._resLoadersEP[id]

	if loader and loader.finishCalls then
		table.removebyvalue(loader.finishCalls, finishedCall, true)
	end
end

NewChatController.instance = NewChatController.New()

return NewChatController
