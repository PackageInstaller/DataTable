-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/title/config/TitleConfig.lua

module("logic.extensions.title.config.TitleConfig", package.seeall)

local TitleConfig = class("TitleConfig", BaseConfig)

function TitleConfig:onInit()
	TitleConfig.super.onInit(self)

	self._cfgTitle = nil
end

function TitleConfig:getNames()
	return {
		"title"
	}
end

function TitleConfig:handleConfig(name, content)
	if name == "title" then
		self._cfgTitle = content
	end
end

function TitleConfig:getCfgById(id)
	return self._cfgTitle[id]
end

function TitleConfig:getCfg()
	return self._cfgTitle
end

TitleConfig.instance = TitleConfig.New()

return TitleConfig
