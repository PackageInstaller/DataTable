-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzBattleTrackMO.lua

module("modules.logic.versionactivity3_7.wmz.model.WmzBattleTrackMO", package.seeall)

local WmzBattleTrackMO = class("WmzBattleTrackMO")

function WmzBattleTrackMO:ctor()
	self:clear()
end

function WmzBattleTrackMO:clear()
	self._startTs = 0
	self._resetTimes = -1
end

function WmzBattleTrackMO:onGameStart()
	self._resetTimes = 0
	self._startTs = os.time()
end

function WmzBattleTrackMO:onGameReset()
	self:_addResetTimes()
end

function WmzBattleTrackMO:_addResetTimes()
	self._resetTimes = self._resetTimes + 1
end

function WmzBattleTrackMO:track_act_WMZ_operation(mapMO, eOperationType, curEnergy)
	if self._resetTimes == -1 then
		return
	end

	local MapId = mapMO:gameId()
	local UseTime = os.time() - self._startTs
	local RoundNum = curEnergy or mapMO:curEnergy()
	local CompletedLayers = mapMO:clearZoneCnt()

	SDKDataTrackMgr.instance:track_act_WMZ_operation(eOperationType, MapId, UseTime, self._resetTimes, RoundNum, CompletedLayers)
end

return WmzBattleTrackMO
