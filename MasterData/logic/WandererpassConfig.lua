-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/config/WandererpassConfig.lua

module("logic.extensions.wandererpass.config.WandererpassConfig", package.seeall)

local WandererpassConfig = class("WandererpassConfig", BaseConfig)

function WandererpassConfig:getNames()
	return {
		"wanderer_pass_activity",
		"wanderer_pass_gift_list_activity"
	}
end

function WandererpassConfig:handleConfig(name, content)
	if name == "wanderer_pass_activity" then
		self._wanderer_pass_activity = content
	elseif name == "wanderer_pass_gift_list_activity" then
		self._wanderer_pass_gift_list_activity = content
	end
end

function WandererpassConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

function WandererpassConfig:getActivityCfgById(id)
	return self._wanderer_pass_activity[id]
end

function WandererpassConfig:getGiftListCfgById(id)
	return self._wanderer_pass_gift_list_activity[id]
end

WandererpassConfig.instance = WandererpassConfig.New()

return WandererpassConfig
