-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/controller/ChatController.lua

module("logic.extensions.chat.controller.ChatController", package.seeall)

local json = require("cjson")
local PrivateChatFormat_Key = "PrivateChat_%d"
local FriendList_Key = "FriendList"
local ChatController = class("ChatController", BaseController)

function ChatController:ctor()
	self._curChannel = GameEnum.ChatChannel.Zone
	self._settingViewOpened = false
	self._onBattle = false
end

function ChatController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.ApplicationPause, self._SaveMsg, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationPause, self.SaveLeagueChat, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationQuit, self._SaveMsg, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationQuit, self.SaveLeagueChat, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendAdd, self.LoadPrivateChat, self)
	GlobalDispatcher:addListener(GlobalNotify.BlackListAdd, self.LoadPrivateChat, self)
	GlobalDispatcher:addListener(GlobalNotify.StrangerAdd, self.LoadPrivateChat, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendRemove, self.DeletePrivateChat, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendListReset, self._RemoveDeletedFriend, self)
end

function ChatController:onReset()
	return
end

function ChatController:SavePrivateChat()
	return
end

function ChatController:LoadPrivateChat(id)
	return
end

function ChatController:DeletePrivateChat(id)
	local key = string.format(PrivateChatFormat_Key, id)

	Framework.LocalStorage.Instance:DeleteKey(key)
	Framework.LocalStorage.Instance:Save()
end

function ChatController:_RemoveDeletedFriend()
	local key = FriendList_Key

	if not Framework.LocalStorage.Instance:HasKey(key) then
		return
	end

	local value = Framework.LocalStorage.Instance:GetString(key, nil)

	if not string.nilorempty(value) then
		local t = json.decode(value)

		for _, id in ipairs(t) do
			if not FriendModel.instance:getFriendMo(id) then
				self:DeletePrivateChat(id)
			end
		end
	end
end

function ChatController:SaveLeagueChat()
	return
end

function ChatController:LoadLeagueChat()
	return
end

function ChatController:LoadOfflineMsg()
	ChatAgent.instance:sendGetChatSettingsAndOfflineMsgsReq()
end

function ChatController:SetConumeNotice(channel, notice)
	ChatSettingModel.instance:SetConumeNotice(channel, notice)
	ChatAgent.instance:sendSetChatSettingsReq()
end

function ChatController:SendMsg(channel, type, content, receiveId, decrType)
	ChatAgent.instance:sendSendMsgReq(channel, type, content, receiveId, decrType)
end

function ChatController:MainShow()
	return {
		"Zone",
		"World",
		"League",
		"Nearby",
		"System",
		"Battle"
	}
end

function ChatController:AutoVoice()
	return {
		"Zone",
		"Nearby"
	}
end

function ChatController:_SaveMsg()
	self:SavePrivateChat()
	self:SaveLeagueChat()
end

function ChatController:SetMainShow(channel, value)
	ChatSettingModel.instance:SetMainShow(channel, value)
end

function ChatController:SetAutoVoice(channel, value)
	ChatSettingModel.instance:SetAutoVoice(channel, value)
	ChatAgent.instance:sendSetChatSettingsReq()
end

function ChatController:OpenChatView()
	ViewMgr.instance:open(ViewName.chat)
end

function ChatController:CloseChatView()
	ViewMgr.instance:close(ViewName.chat)
end

function ChatController:OpenChatSettingView()
	UIStateManager.instance:open(ViewName.chatSetting)

	self._settingViewOpened = true
end

function ChatController:CloseChatSettingView()
	UIStateManager.instance:pop()

	self._settingViewOpened = false
end

function ChatController:IsChatSettingViewOpened()
	return self._settingViewOpened
end

function ChatController:SetCurChannel(channel)
	self._curChannel = channel
end

function ChatController:GetCurChannel()
	return self._curChannel
end

function ChatController:GetMainShowMsg()
	local settings = ChatSettingModel.instance:GetAllMainShow()

	return (TableUtil.Where(ChatModel.instance:GetDatas(), function(v)
		local channel = v:GetChannel()

		if channel == GameEnum.ChatChannel.Battle then
			return false
		end

		return ChatSettingModel.instance:GetMainShow(channel)
	end, pairs))
end

function ChatController:checkIsAllLimit(channel, isShowTips)
	if channel == GameEnum.ChatChannel.All then
		local funcId = FriendConfig.instance:getCommonValue("CHANNEL_ALL_LIMIT_FUN_ID", true)

		if FuncOpenModel.instance:getFuncIsOpen(funcId) then
			return false
		else
			if isShowTips then
				local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

				FuncOpenController.instance:showLockTips(cfg)
			end

			return true
		end
	end

	return false
end

ChatController.instance = ChatController.New()

return ChatController
