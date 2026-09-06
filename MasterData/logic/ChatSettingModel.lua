-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/ChatSettingModel.lua

module("logic.extensions.chat.model.ChatSettingModel", package.seeall)

local ChatSettingModel = class("ChatSettingModel", BaseModel)

function ChatSettingModel:ctor()
	self._conumeNotice = {}
	self._rollingShowSettings = {}
	self._autoVoice = {}

	for _, i in pairs(GameEnum.ChatChannel) do
		self._conumeNotice[i] = GameEnum.Notice.EveryTime
		self._rollingShowSettings[i] = true
		self._autoVoice[i] = true
	end

	self.enableChatWordEffect = false
end

function ChatSettingModel:Init(settings)
	if settings.zoneConumeNotice ~= nil then
		self._conumeNotice[GameEnum.ChatChannel.Zone] = settings.zoneConumeNotice
	end

	if settings.allConumeNotice ~= nil then
		self._conumeNotice[GameEnum.ChatChannel.All] = settings.allConumeNotice
	end

	if settings.worldConumeNotice ~= nil then
		self._conumeNotice[GameEnum.ChatChannel.World] = settings.worldConumeNotice
	end

	if settings.rollingShowSettings ~= nil then
		for _, i in pairs(GameEnum.ChatChannel) do
			self._rollingShowSettings[i] = GameUtil.isBitOpenByDigit(settings.rollingShowSettings, i)
		end
	end

	if settings.autoPlayVoice ~= nil then
		for _, i in pairs(GameEnum.ChatChannel) do
			self._autoVoice[i] = GameUtil.isBitOpenByDigit(settings.autoPlayVoice, i)
		end
	end

	if settings.enableChatWordEffect ~= nil then
		self.enableChatWordEffect = checkbool(settings.enableChatWordEffect)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ChatSettingChange)
end

function ChatSettingModel:GetConumeNotice(channel)
	return self._conumeNotice[channel]
end

function ChatSettingModel:SetConumeNotice(channel, notice)
	self._conumeNotice[channel] = notice
end

function ChatSettingModel:GetEnableChatWordEffect()
	return self.enableChatWordEffect
end

function ChatSettingModel:SetEnableChatWordEffect(bool)
	self.enableChatWordEffect = bool
end

function ChatSettingModel:GetAllMainShow()
	return self._rollingShowSettings
end

function ChatSettingModel:GetMainShow(channel)
	local showChanel = NewChatController.instance:getShowChannel()

	if not showChanel and channel == GameEnum.ChatChannel.Nearby then
		return false
	end

	if showChanel and showChanel ~= channel then
		return false
	end

	local isShow = self._rollingShowSettings[channel]

	if channel == GameEnum.ChatChannel.Share then
		return not isShow
	else
		return isShow
	end
end

function ChatSettingModel:SetMainShow(channel, value)
	if channel == GameEnum.ChatChannel.Share then
		value = not value
	end

	self._rollingShowSettings[channel] = value == true

	GlobalDispatcher:dispatch(GlobalNotify.ChatSettingChange)
end

function ChatSettingModel:GetAllAutoVoice()
	return self._autoVoice
end

function ChatSettingModel:GetAutoVoice(channel)
	if self._autoVoice[channel] == false then
		return false
	end

	return true
end

function ChatSettingModel:SetAutoVoice(channel, value)
	self._autoVoice[channel] = value == true

	GlobalDispatcher:dispatch(GlobalNotify.ChatSettingChange)
end

ChatSettingModel.instance = ChatSettingModel.New()

return ChatSettingModel
