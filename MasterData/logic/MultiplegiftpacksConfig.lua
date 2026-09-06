-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/config/MultiplegiftpacksConfig.lua

module("logic.extensions.hdsummerlotteryrecommend.config.MultiplegiftpacksConfig", package.seeall)

local MultiplegiftpacksConfig = class("MultiplegiftpacksConfig", BaseConfig)

function MultiplegiftpacksConfig:onInit()
	MultiplegiftpacksConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function MultiplegiftpacksConfig:getNames()
	return {
		"qing_gu_activity",
		"qing_gu_activity_extra"
	}
end

function MultiplegiftpacksConfig:handleConfig(name, content)
	if name == "qing_gu_activity" then
		self._qing_gu_activityCfg = content
	elseif name == "qing_gu_activity_extra" then
		self._qing_gu_activity_extraCfg = content
	end
end

function MultiplegiftpacksConfig:getActivityCfgById(id)
	return self._qing_gu_activityCfg[id]
end

function MultiplegiftpacksConfig:getExtraCfgById(id)
	return self._qing_gu_activity_extraCfg[id]
end

MultiplegiftpacksConfig.instance = MultiplegiftpacksConfig.New()

return MultiplegiftpacksConfig
