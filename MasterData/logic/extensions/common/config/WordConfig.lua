-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/config/WordConfig.lua

module("logic.extensions.common.config.WordConfig", package.seeall)

local M = class("WordConfig", BaseConfig)

function M:onInit()
	self._wordConfig = false
end

function M:getNames()
	return {
		ConfigName.Word
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.Word then
		self._wordConfig = content
	end
end

function M:getWordCO(wordKey)
	return self._wordConfig[wordKey]
end

M.instance = M.New()

return M
