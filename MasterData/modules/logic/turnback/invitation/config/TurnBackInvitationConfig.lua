-- chunkname: @modules/logic/turnback/invitation/config/TurnBackInvitationConfig.lua

module("modules.logic.turnback.invitation.config.TurnBackInvitationConfig", package.seeall)

local TurnBackInvitationConfig = class("TurnBackInvitationConfig", BaseConfig)

function TurnBackInvitationConfig:ctor()
	self._turnBackH5ChannelConfig = nil
end

function TurnBackInvitationConfig:reqConfigNames()
	return {
		"turnback_h5_channel"
	}
end

function TurnBackInvitationConfig:onConfigLoaded(configName, configTable)
	if configName == "turnback_h5_channel" then
		self._turnBackH5ChannelConfig = configTable

		self:_initTurnBackH5Config()
	end
end

function TurnBackInvitationConfig:_initTurnBackH5Config()
	local channelDic = {}
	local channelTestDic = {}

	for _, config in ipairs(self._turnBackH5ChannelConfig.configList) do
		if channelDic[config.channelId] == nil then
			channelDic[config.channelId] = config.url
			channelTestDic[config.channelId] = config.testUrl
		end
	end

	self._channelUrlDic = channelDic
	self._channelTestDic = channelTestDic
end

function TurnBackInvitationConfig:getChannelConfig(id)
	return self._turnBackH5ChannelConfig.configDict[id]
end

function TurnBackInvitationConfig:getUrlByChannelId(channelId)
	return self._channelUrlDic[channelId]
end

function TurnBackInvitationConfig:getTestUrlByChannelId(channelId)
	if self._channelTestDic[channelId] ~= nil then
		return self._channelTestDic[channelId]
	end

	return self._channelUrlDic[channelId]
end

TurnBackInvitationConfig.instance = TurnBackInvitationConfig.New()

return TurnBackInvitationConfig
