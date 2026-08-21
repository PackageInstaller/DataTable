-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/config/power_challenge/PowerChallengeConfig.lua

module("logic.extensions.welfare.config.power_challenge.PowerChallengeConfig", package.seeall)

local M = class("PowerChallengeConfig", BaseConfig)

function M:onInit()
	self._chapterConf = {}
end

function M:getNames()
	return {
		ConfigName.PowerChallengeChapter
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.PowerChallengeChapter then
		self._chapterConf = content
	end
end

function M:getChapterConfById(id)
	return self._chapterConf[id] or {}
end

M.instance = M.New()

return M
