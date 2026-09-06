-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightmo/config/SaintknightmoConfig.lua

module("logic.extensions.saintknightmo.config.SaintknightmoConfig", package.seeall)

local SaintknightmoConfig = class("SaintknightmoConfig", BaseConfig)

function SaintknightmoConfig:onInit()
	SaintknightmoConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function SaintknightmoConfig:getNames()
	return {
		"saint_knight_mo"
	}
end

function SaintknightmoConfig:handleConfig(name, content)
	if name == "saint_knight_mo" then
		self.saint_knight_mo = content
	end
end

function SaintknightmoConfig:getCfgById(id)
	return self.saint_knight_mo[id]
end

SaintknightmoConfig.instance = SaintknightmoConfig.New()

return SaintknightmoConfig
