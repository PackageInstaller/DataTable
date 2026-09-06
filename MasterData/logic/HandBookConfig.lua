-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/config/HandBookConfig.lua

module("logic.extensions.petshandbook.config.HandBookConfig", package.seeall)

local HandBookConfig = class("HandBookConfig", BaseConfig)

function HandBookConfig:onInit()
	HandBookConfig.super.onInit(self)

	self._getWaysCfg = nil
	self._getPetWaysCfg = nil
end

function HandBookConfig:getNames()
	return {
		"get_ways",
		"pet_way",
		"pet_manual_cube_exp"
	}
end

function HandBookConfig:handleConfig(name, content)
	if name == "get_ways" then
		self._getWaysCfg = content
	elseif name == "pet_way" then
		self._getPetWaysCfg = content
	elseif name == "pet_manual_cube_exp" then
		self._cubeExpCfg = content
	end
end

function HandBookConfig:getWaysCfgById(id)
	return self._getWaysCfg[id]
end

function HandBookConfig:getPetWaysCfgId(id)
	return self._getPetWaysCfg[id]
end

function HandBookConfig:getCubeExpById(id)
	return self._cubeExpCfg[id]
end

HandBookConfig.instance = HandBookConfig.New()

return HandBookConfig
