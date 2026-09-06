-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeditem/config/TimedItemConfig.lua

module("logic.extensions.timeditem.config.TimedItemConfig", package.seeall)

local TimedItemConfig = class("TimedItemConfig", BaseConfig)

function TimedItemConfig:onInit()
	TimedItemConfig.super.onInit(self)
end

function TimedItemConfig:getNames()
	return {
		"timed_item",
		"expirable_item"
	}
end

function TimedItemConfig:handleConfig(name, content)
	if name == "timed_item" then
		self.timed_item = content
	elseif name == "expirable_item" then
		self.expirable_item = content
	end
end

function TimedItemConfig:getTimedItemCfg(id)
	return self.timed_item[id]
end

function TimedItemConfig:getExpirableItemCfg(id)
	return self.expirable_item[id]
end

TimedItemConfig.instance = TimedItemConfig.New()

return TimedItemConfig
