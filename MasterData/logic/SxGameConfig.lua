-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/config/SxGameConfig.lua

module("logic.extensions.sxgame.config.SxGameConfig", package.seeall)

local SxGameConfig = class("SxGameConfig", BaseConfig)

function SxGameConfig:onInit()
	SxGameConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function SxGameConfig:getNames()
	return {
		"ancient_fossil_site_config"
	}
end

function SxGameConfig:handleConfig(name, content)
	if name == "ancient_fossil_site_config" then
		self._cofignameCfg = content
	end
end

function SxGameConfig:getCfgById(id)
	return self._cofignameCfg[id].value
end

function SxGameConfig:getStep()
	return checknumber(self:getCfgById("MAX_STEP_PER_GAME"))
end

SxGameConfig.instance = SxGameConfig.New()

return SxGameConfig
