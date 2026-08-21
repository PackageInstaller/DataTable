-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/CameraConfig.lua

module("logic.battle.config.CameraConfig", package.seeall)

local CameraConfig = class("CameraConfig", BaseConfig)

function CameraConfig:onInit()
	self._cfgCamera = false
end

function CameraConfig:getNames()
	return {
		ConfigName.Camera
	}
end

function CameraConfig:handleConfig(name, content)
	if name == ConfigName.Camera then
		self._cfgCamera = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function CameraConfig:getCameraCO(code)
	local cameraCO = self._cfgCamera[code]

	if code > 0 and not cameraCO and BattleLog.enableError then
		BattleLog.error(string.format("CameraConfig::cannot find skill config for code[%s]", code))
	end

	return cameraCO
end

CameraConfig.instance = CameraConfig.New()

return CameraConfig
