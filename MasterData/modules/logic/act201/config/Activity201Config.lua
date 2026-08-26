-- chunkname: @modules/logic/act201/config/Activity201Config.lua

module("modules.logic.act201.config.Activity201Config", package.seeall)

local Activity201Config = class("Activity201Config", BaseConfig)

function Activity201Config:reqConfigNames()
	return {
		"turnback_sp_h5_channel",
		"turnback_sp_h5_roletype"
	}
end

local function _roleTypeCO(id)
	return lua_turnback_sp_h5_roletype.configDict[id]
end

function Activity201Config:onConfigLoaded(configName, configTable)
	if configName == "turnback_sp_h5_channel" then
		self:_initTurnBackH5Config(configTable)
	end
end

function Activity201Config:_initTurnBackH5Config(configTable)
	local channelDic = {}
	local channelTestDic = {}

	for _, config in ipairs(configTable.configList) do
		if channelDic[config.channelId] == nil then
			channelDic[config.channelId] = config.url
			channelTestDic[config.channelId] = config.testUrl
		end
	end

	self._channelUrlDic = channelDic
	self._channelTestDic = channelTestDic
end

function Activity201Config:getChannelConfig(id)
	return lua_turnback_sp_h5_channel.configDict[id]
end

function Activity201Config:getUrlByChannelId(channelId)
	return self._channelUrlDic[channelId]
end

function Activity201Config:getTestUrlByChannelId(channelId)
	if self._channelTestDic[channelId] ~= nil then
		return self._channelTestDic[channelId]
	end

	return self._channelUrlDic[channelId]
end

function Activity201Config:getRoleTypeStr(roleTypeId)
	local CO = _roleTypeCO(roleTypeId or 1) or _roleTypeCO(1)

	return gohelper.getRichColorText(CO.name, CO.nameHexColor)
end

Activity201Config.instance = Activity201Config.New()

return Activity201Config
