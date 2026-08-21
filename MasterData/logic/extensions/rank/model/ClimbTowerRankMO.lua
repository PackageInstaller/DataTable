-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/model/ClimbTowerRankMO.lua

module("logic.extensions.rank.model.ClimbTowerRankMO", package.seeall)

local M = class("ClimbTowerRankMO", RankBaseMO)

function M:ctor()
	M.super.ctor(self)

	self._dungeonId = nil
	self._round = nil
	self._step = nil
	self._heros = nil
end

function M:updateData(rankId, data)
	M.super.updateData(self, rankId, data)

	local climbTowerData = data.dungeon

	self:setClimbTowerData(climbTowerData)
end

function M:setClimbTowerData(climbTowerData)
	if not climbTowerData then
		return
	end

	self._dungeonId = climbTowerData.dungeonId
	self._round = climbTowerData.round
	self._step = climbTowerData.step
	self._heros = climbTowerData.heros
end

function M:getProgress()
	local dungeonCfg = DungeonConfig.instance:getDungeonCfgById(self._dungeonId)

	return dungeonCfg and dungeonCfg.index
end

function M:getRound()
	return self._round
end

function M:getStep()
	return self._step
end

function M:getTeam()
	return self._heros
end

function M:clear()
	M.super.clear(self)

	self._dungeonId = nil
	self._round = nil
	self._heros = nil
end

return M
