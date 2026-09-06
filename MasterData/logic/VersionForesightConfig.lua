-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/versionforesight/config/VersionForesightConfig.lua

module("logic.extensions.versionforesight.config.VersionForesightConfig", package.seeall)

local VersionForesightConfig = class("VersionForesightConfig", BaseConfig)

function VersionForesightConfig:onInit()
	VersionForesightConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function VersionForesightConfig:getNames()
	return {
		"version_show_pet",
		"version_foresight_grid",
		"version_foresight",
		"version_foresight_add_times"
	}
end

function VersionForesightConfig:handleConfig(name, content)
	if name == "version_show_pet" then
		self._version_show_pet = content
	elseif name == "version_foresight_grid" then
		self._version_foresight_grid = content
	elseif name == "version_foresight" then
		self._version_foresight = content
	elseif name == "version_foresight_add_times" then
		self._version_foresight_add_times = content
	end
end

function VersionForesightConfig:getCfgById(id)
	return self._version_foresight[id]
end

function VersionForesightConfig:getShowPetCfg(actId)
	return self._version_show_pet[actId]
end

function VersionForesightConfig:getForesightGridCfgById(actId)
	return self._version_foresight_grid[actId]
end

function VersionForesightConfig:getForesightGridIds(actId)
	local list = {}
	local cfg = self._version_foresight_grid[actId]

	for i, v in ipairs(cfg) do
		table.insert(list, v.id)
	end

	return list
end

function VersionForesightConfig:getAddTimesById(actId)
	return self._version_foresight_add_times[actId]
end

VersionForesightConfig.instance = VersionForesightConfig.New()

return VersionForesightConfig
