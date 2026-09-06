-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/remembertheater/config/RememberTheaterConfig.lua

module("logic.extensions.remembertheater.config.RememberTheaterConfig", package.seeall)

local RememberTheaterConfig = class("RememberTheaterConfig", BaseConfig)

function RememberTheaterConfig:onInit()
	RememberTheaterConfig.super:onInit(self)
end

function RememberTheaterConfig:getNames()
	return {
		"remember_theater",
		"remember_theater_story"
	}
end

function RememberTheaterConfig:handleConfig(name, content)
	if name == "remember_theater" then
		self._remember_theater = content
	elseif name == "remember_theater_story" then
		self._remember_theater_story = content
	end
end

function RememberTheaterConfig:getTabCfgs()
	return self._remember_theater.dataList
end

function RememberTheaterConfig:getTabCfg(tabId)
	return self._remember_theater[tabId]
end

function RememberTheaterConfig:getStoryCfgs()
	return self._remember_theater_story.dataList
end

function RememberTheaterConfig:getStoryCfgByTableId(tableId)
	return self._remember_theater_story[tableId]
end

function RememberTheaterConfig:getStoryCfgCopyByTableId(tableId)
	local copy = {}

	for i, v in ipairs(self._remember_theater_story[tableId]) do
		table.insert(copy, v)
	end

	return copy
end

RememberTheaterConfig.instance = RememberTheaterConfig.New()

return RememberTheaterConfig
