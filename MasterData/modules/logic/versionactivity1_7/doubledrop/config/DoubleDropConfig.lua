-- chunkname: @modules/logic/versionactivity1_7/doubledrop/config/DoubleDropConfig.lua

module("modules.logic.versionactivity1_7.doubledrop.config.DoubleDropConfig", package.seeall)

local DoubleDropConfig = class("DoubleDropConfig", BaseConfig)

function DoubleDropConfig:reqConfigNames()
	return {
		"activity153",
		"activity153_extra_bonus"
	}
end

function DoubleDropConfig:onInit()
	self._actCfgDict = {}
	self._actEpisodeDict = {}
end

function DoubleDropConfig:onConfigLoaded(configName, configTable)
	local func = self[string.format("on%sConfigLoaded", configName)]

	if func then
		func(self, configTable)
	end
end

function DoubleDropConfig:onactivity153ConfigLoaded(configTable)
	self._actCfgDict = configTable.configDict
end

function DoubleDropConfig:onactivity153_extra_bonusConfigLoaded(configTable)
	self._actEpisodeDict = configTable.configDict
end

function DoubleDropConfig:getAct153Co(actId)
	return self._actCfgDict[actId]
end

function DoubleDropConfig:getAct153ExtraBonus(actId, episodeId)
	if self._actEpisodeDict[actId] then
		return self._actEpisodeDict[actId] and self._actEpisodeDict[actId].extraBonus
	end
end

function DoubleDropConfig:getAct153ActEpisodes(actId)
	return self._actEpisodeDict[actId]
end

DoubleDropConfig.instance = DoubleDropConfig.New()

return DoubleDropConfig
