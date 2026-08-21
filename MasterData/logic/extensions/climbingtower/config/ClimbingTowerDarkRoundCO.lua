-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/config/ClimbingTowerDarkRoundCO.lua

module("logic.extensions.climbingtower.config.ClimbingTowerDarkRoundCO", package.seeall)

local M = class("ClimbingTowerDarkRoundCO")

function M:ctor(cfg)
	self._round = cfg.round
	self._startTime = cfg.startTime
	self._endTime = cfg.endTime
	self._ids = {}

	if cfg.ids and #cfg.ids > 0 then
		for _, towerCfgId in ipairs(cfg.ids) do
			table.insert(self._ids, towerCfgId)
		end
	end
end

function M:getRound()
	return self._round
end

function M:getIds()
	return self._ids
end

function M:getDungeonCount()
	return #self._ids
end

function M:getDungeonIds()
	if not self._dungeonIds then
		self._dungeonIds = {}

		local ids = self:getIds()

		for _, towerCfgId in ipairs(ids or {}) do
			local co = ClimbingTowerConfig.instance:getDarkTowerCO(towerCfgId)
			local dungeonId = co and co:getDungeonId() or -1

			table.insert(self._dungeonIds, dungeonId)
		end
	end

	return self._dungeonIds
end

function M:getDungeonPreDungeonIds()
	if not self._dungeonPreDungeonIds then
		self._dungeonPreDungeonIds = {}

		local dungeonIds = self:getDungeonIds()
		local preDungeonId

		for _, dungeonId in ipairs(dungeonIds) do
			self._dungeonPreDungeonIds[dungeonId] = preDungeonId
			preDungeonId = dungeonId
		end
	end

	return self._dungeonPreDungeonIds
end

function M:getDungeonId2TowerCfgIdLst()
	if not self._dungeonId2TowerCfgIds then
		self._dungeonId2TowerCfgIds = {}

		local ids = self:getIds()
		local dungeonIds = self:getDungeonIds()

		for i, dungeonId in ipairs(dungeonIds or {}) do
			local towerCfgId = ids[i]

			self._dungeonId2TowerCfgIds[dungeonId] = towerCfgId
		end
	end

	return self._dungeonId2TowerCfgIds
end

function M:getStartTime()
	return self._startTime
end

function M:getStartTimeStamp()
	local timeStamp = 0

	if not string.nilorempty(self:getStartTime()) then
		timeStamp = TimeUtil.instance:dateStr2TimeStamp(self:getStartTime())
	end

	return timeStamp
end

function M:getEndTime()
	return self._endTime
end

function M:getEndTimeStamp()
	local timeStamp = 0

	if not string.nilorempty(self:getEndTime()) then
		timeStamp = TimeUtil.instance:dateStr2TimeStamp(self:getEndTime())
	end

	return timeStamp
end

function M:isExpired()
	local canOnLine = false
	local nowT = ServerTime.now()
	local beginT = false
	local endT = false

	if not string.nilorempty(self:getStartTime()) then
		beginT = TimeUtil.instance:dateStr2TimeStamp(self:getStartTime())
	end

	if not string.nilorempty(self:getEndTime()) then
		endT = TimeUtil.instance:dateStr2TimeStamp(self:getEndTime())
	end

	if beginT then
		if endT then
			canOnLine = nowT < endT and beginT <= nowT
		else
			canOnLine = beginT <= nowT
		end
	elseif endT then
		canOnLine = nowT < endT
	else
		canOnLine = true
	end

	return not canOnLine
end

return M
