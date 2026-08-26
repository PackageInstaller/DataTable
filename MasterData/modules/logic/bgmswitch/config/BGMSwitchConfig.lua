-- chunkname: @modules/logic/bgmswitch/config/BGMSwitchConfig.lua

module("modules.logic.bgmswitch.config.BGMSwitchConfig", package.seeall)

local BGMSwitchConfig = class("BGMSwitchConfig", BaseConfig)

function BGMSwitchConfig:ctor()
	self._bgmSwitchConfig = nil
	self._bgmTypeConfig = nil
	self._bgmEasterEggConfig = nil
end

function BGMSwitchConfig:reqConfigNames()
	return {
		"bgm_switch",
		"bgm_type",
		"bgm_easteregg"
	}
end

function BGMSwitchConfig:onConfigLoaded(configName, configTable)
	if configName == "bgm_switch" then
		self._bgmSwitchConfig = configTable
	elseif configName == "bgm_type" then
		self._bgmTypeConfig = configTable
	elseif configName == "bgm_easteregg" then
		self._bgmEasterEggConfig = configTable
	end
end

function BGMSwitchConfig:getBGMSwitchCos()
	return self._bgmSwitchConfig.configDict
end

function BGMSwitchConfig:getBGMSwitchCO(id)
	return self._bgmSwitchConfig.configDict[id]
end

function BGMSwitchConfig:getBGMSwitchCoByAudioId(audioId)
	for _, v in pairs(self._bgmSwitchConfig.configDict) do
		if v.audio == audioId then
			return v
		end
	end

	return nil
end

function BGMSwitchConfig:getBGMTypeCos()
	return self._bgmTypeConfig.configDict
end

function BGMSwitchConfig:getBGMTypeCO(typeId)
	return self._bgmTypeConfig.configDict[typeId]
end

function BGMSwitchConfig:getBgmEasterEggCos()
	return self._bgmEasterEggConfig.configDict
end

function BGMSwitchConfig:getBgmEasterEggCosByType(type)
	local cos = {}

	for _, v in pairs(self._bgmEasterEggConfig.configDict) do
		if v.type == type then
			table.insert(cos, v)
		end
	end

	return cos
end

function BGMSwitchConfig:getBgmEasterEggCo(id)
	return self._bgmEasterEggConfig.configDict[id]
end

function BGMSwitchConfig:getBgmNames(bgmIds)
	local ans = {}

	for _, bgm in ipairs(bgmIds) do
		local bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(bgm)

		if bgmCo then
			table.insert(ans, bgmCo.audioName)
		end
	end

	return ans
end

function BGMSwitchConfig:getBgmName(bgm)
	local bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(bgm)

	return bgmCo and bgmCo.audioName
end

BGMSwitchConfig.instance = BGMSwitchConfig.New()

return BGMSwitchConfig
