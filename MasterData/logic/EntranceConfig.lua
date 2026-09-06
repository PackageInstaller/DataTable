-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/entrance/config/EntranceConfig.lua

module("logic.extensions.entrance.config.EntranceConfig", package.seeall)

local EntranceConfig = class("EntranceConfig", BaseConfig)

function EntranceConfig:onInit()
	EntranceConfig.super.onInit(self)
end

function EntranceConfig:getNames()
	return {
		"entrance_text",
		"entrance_common"
	}
end

function EntranceConfig:handleConfig(name, content)
	if name == "entrance_text" then
		self._entranceText = content
	elseif name == "entrance_common" then
		self._entranceCommon = content
	end
end

function EntranceConfig:getTextById(id)
	return self._entranceText[id]
end

function EntranceConfig:getCommonValue(key)
	return self._entranceCommon[key].value
end

EntranceConfig.instance = EntranceConfig.New()

return EntranceConfig
