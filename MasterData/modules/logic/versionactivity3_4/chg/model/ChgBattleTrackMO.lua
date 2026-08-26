-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgBattleTrackMO.lua

module("modules.logic.versionactivity3_4.chg.model.ChgBattleTrackMO", package.seeall)

local ChgBattleTrackMO = class("ChgBattleTrackMO")

function ChgBattleTrackMO:ctor()
	self:clear()
end

function ChgBattleTrackMO:clear()
	self._startTs = 0
	self._roundStartTs = 0
end

function ChgBattleTrackMO:onGameStart()
	self._startTs = os.time()
end

function ChgBattleTrackMO:onRoundStart()
	self._roundStartTs = os.time()
end

function ChgBattleTrackMO:track_act_chengheguang_operation(elementId, mapMO, eOperationType, IsFirst, IsWin)
	elementId = elementId or 0

	local MapId = mapMO:curRound()
	local UseTime = os.time() - self._startTs
	local Time = os.time() - self._roundStartTs

	if elementId == 0 then
		elementId = -1
		MapId = -1
		UseTime = -1
		Time = -1
	end

	SDKDataTrackMgr.instance:track_act_chengheguang_operation(eOperationType, elementId, MapId, UseTime, Time, IsWin, IsFirst)
end

return ChgBattleTrackMO
