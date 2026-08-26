-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/config/LengZhou6EliminateConfig.lua

module("modules.logic.versionactivity2_7.lengzhou6.config.LengZhou6EliminateConfig", package.seeall)

local LengZhou6EliminateConfig = class("LengZhou6EliminateConfig", EliminateConfig)

function LengZhou6EliminateConfig:_initEliminateChessConfig()
	LengZhou6EliminateConfig.super._initEliminateChessConfig(self)

	self._eliminateLevelConfig = {}

	for i = 1, #T_lua_eliminate_level do
		local data = T_lua_eliminate_level[i]

		self._eliminateLevelConfig[data.id] = data
	end
end

function LengZhou6EliminateConfig:getEliminateChessLevelConfig(levelId)
	if self._eliminateLevelConfig == nil then
		self:_initEliminateChessConfig()
	end

	return (self._eliminateLevelConfig[levelId] or nil) and (self._eliminateLevelConfig[levelId].chess or "")
end

LengZhou6EliminateConfig.instance = LengZhou6EliminateConfig.New()

return LengZhou6EliminateConfig
