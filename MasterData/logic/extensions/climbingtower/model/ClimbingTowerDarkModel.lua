-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/model/ClimbingTowerDarkModel.lua

module("logic.extensions.climbingtower.model.ClimbingTowerDarkModel", package.seeall)

local M = class("ClimbingTowerDarkModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._dungeonMoLstDark = {}
	self._nowDarkRound = nil
	self._lastBattleInfo = nil
end

function M:updateDarkRoundFromServer(darkRound)
	darkRound = darkRound or 0

	local boardCast = false

	if self:getDarkRound() ~= darkRound then
		self:onReset()

		boardCast = true
	end

	self:setDarkRound(darkRound)

	if boardCast then
		GlobalDispatcher:dispatchEvent(EventType.CLIMBING_TOWER_DARK_ROUND_CHANGE)
	end
end

function M:setDarkRound(darkRound)
	self._nowDarkRound = darkRound
end

function M:getDarkRound()
	return self._nowDarkRound or 0
end

function M:getDungeonMoById(dungeonId)
	local round = self:getDarkRound()

	if round == 0 then
		printError(string.format("暗面轮数[%s]，将不返回dungeon[%s]结果", round, dungeonId))

		return nil
	end

	local roundCO = ClimbingTowerConfig.instance:getDarkRoundCO(round)

	if roundCO == nil then
		return nil
	end

	if not self._dungeonMoLstDark[dungeonId] then
		local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonId)

		if not dungeonCo then
			printError(string.format("无法从[t_%s]中找到[%s]的配置", ConfigName.Dungeon, dungeonId))

			return
		end

		local preDungeonIdLst = roundCO:getDungeonPreDungeonIds() or {}
		local dungeonId2TowerCfgIdLst = roundCO:getDungeonId2TowerCfgIdLst() or {}
		local dungeonMo = ClimbingTowerDungeonMo.New()
		local towerCfgId = dungeonId2TowerCfgIdLst[dungeonId]
		local preDungeonId = preDungeonIdLst[dungeonId]

		dungeonMo:setTowerCfg(ClimbingTowerEnum.PageTyp.DarkSide, towerCfgId)
		dungeonMo:initByConfig(dungeonCo)
		dungeonMo:initByAgent(DungeonModel.instance:getDungeonPassDataByDungeonId(dungeonId))
		dungeonMo:setPreDungeonId(preDungeonId)

		self._dungeonMoLstDark[dungeonId] = dungeonMo
	end

	return self._dungeonMoLstDark[dungeonId]
end

function M:clearDarkDungeonMo()
	self._dungeonMoLstDark = {}
end

function M:getClearDungeonCount(darkRound)
	local count = 0
	local roundCO = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)

	if roundCO == nil then
		return count
	end

	local ids = roundCO:getIds()

	for _, darkTowerId in pairs(ids or {}) do
		local co = ClimbingTowerConfig.instance:getDarkTowerCO(darkTowerId)
		local dungeonId = co and co:getDungeonId() or 0

		if dungeonId > 0 then
			local passData = DungeonModel.instance:getDungeonPassDataByDungeonId(dungeonId)

			if passData then
				count = count + 1
			end
		end
	end

	return count
end

function M:setLastDungeonBattleInfo(darkRound, dungeonId)
	if not self._lastBattleInfo then
		self._lastBattleInfo = {}
	end

	self._lastBattleInfo.darkRound = darkRound
	self._lastBattleInfo.dungeonId = dungeonId
end

function M:getLastDungeonBattleInfo()
	return self._lastBattleInfo or {}
end

M.instance = M.New()

return M
