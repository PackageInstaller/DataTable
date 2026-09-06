-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/config/OfflineConfig.lua

module("logic.extensions.offline.config.OfflineConfig", package.seeall)

local OfflineConfig = class("OfflineConfig", BaseConfig)

function OfflineConfig:onInit()
	OfflineConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function OfflineConfig:getNames()
	return {
		"anniversary_publicity",
		"anniversary_publicity_prize"
	}
end

function OfflineConfig:handleConfig(name, content)
	if name == "anniversary_publicity" then
		self.anniversary_publicityCfg = content
	elseif name == "anniversary_publicity_prize" then
		self.anniversary_publicity_prizeCfg = content
	end
end

function OfflineConfig:getCfgById(id)
	return self.anniversary_publicityCfg[id]
end

function OfflineConfig:getPrizeListCfgById(planId)
	return self.anniversary_publicity_prizeCfg[planId]
end

function OfflineConfig:getPrizeCfgById(planId, id)
	if self.anniversary_publicity_prizeCfg[planId] then
		return self.anniversary_publicity_prizeCfg[planId][id]
	end
end

OfflineConfig.instance = OfflineConfig.New()

return OfflineConfig
