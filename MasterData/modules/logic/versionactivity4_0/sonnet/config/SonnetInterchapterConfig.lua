-- chunkname: @modules/logic/versionactivity4_0/sonnet/config/SonnetInterchapterConfig.lua

module("modules.logic.versionactivity4_0.sonnet.config.SonnetInterchapterConfig", package.seeall)

local SonnetInterchapterConfig = class("SonnetInterchapterConfig", BaseConfig)

function SonnetInterchapterConfig:reqConfigNames()
	return {
		"sonnet_dialog",
		"sonnet_ink",
		"sonnet_poem",
		"sonnet_task",
		"sonnet_words"
	}
end

function SonnetInterchapterConfig:onInit()
	return
end

function SonnetInterchapterConfig:onConfigLoaded(configName, configTable)
	if configName == "sonnet_words" then
		self:_initWords(configTable)
	end
end

function SonnetInterchapterConfig:_initWords()
	self._words = {}

	for i, v in ipairs(lua_sonnet_words.configList) do
		self._words[v.elementId] = self._words[v.elementId] or {}

		table.insert(self._words[v.elementId], v)
	end
end

function SonnetInterchapterConfig:getDialogs(id)
	return lua_sonnet_dialog.configDict[id]
end

function SonnetInterchapterConfig:getWords(id)
	return self._words[id]
end

function SonnetInterchapterConfig:getWordConfig(id)
	return lua_sonnet_words.configDict[id]
end

function SonnetInterchapterConfig:getTaskCo(id)
	return lua_sonnet_task.configDict[id]
end

SonnetInterchapterConfig.instance = SonnetInterchapterConfig.New()

return SonnetInterchapterConfig
