-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/model/LevelRankMO.lua

module("logic.extensions.rank.model.LevelRankMO", package.seeall)

local M = class("LevelRankMO", RankBaseMO)

function M:ctor()
	M.super.ctor(self)

	self._level = nil
end

function M:updateData(rankId, data)
	M.super.updateData(self, rankId, data)

	local levelData = data.level

	self:setLevelData(levelData)
end

function M:setLevelData(levelData)
	if not levelData then
		return
	end

	self._level = levelData.level
end

function M:getLevel()
	return self._level
end

function M:clear()
	M.super.clear(self)

	self._level = nil
end

return M
