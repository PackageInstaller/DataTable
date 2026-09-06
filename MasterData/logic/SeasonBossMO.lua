-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonBossMO.lua

module("logic.extensions.season.model.SeasonBossMO", package.seeall)

local SeasonBossMO = class("SeasonBossMO")

function SeasonBossMO:ctor()
	self.phaseId = 0
	self._lastProgressPhaseId = -1
	self._maxProgress = 0
	self._progress = 0
	self.doppelgangerPhaseInfoMap = {}
end

function SeasonBossMO:update(bossInfo)
	local currPhaseId = self.phaseId

	self.phaseId = bossInfo.phaseId

	self:updateBossLockTeam(bossInfo.doppelgangerPhaseInfo, true)
	GlobalDispatcher:dispatch(GlobalNotify.SeasonBossInfoUpdated, currPhaseId, self.phaseId)
end

function SeasonBossMO:getDoppelgangerLockCount()
	return table.nums(self.doppelgangerPhaseInfoMap)
end

function SeasonBossMO:isDoppelgangerLockByGridId(gridId)
	return checkbool(self.doppelgangerPhaseInfoMap[gridId] ~= nil)
end

function SeasonBossMO:updateResetBossLockTeam(teamId)
	return
end

function SeasonBossMO:updateBossLockTeam(array, bIgnoreDispatchEvent)
	self.doppelgangerPhaseInfoMap = {}

	for i, v in ipairs(array or {}) do
		self.doppelgangerPhaseInfoMap[v.doppelgangerPointId] = checknumber(v.lockTeamId)
	end

	self:_updateTeamsLockState()

	if not bIgnoreDispatchEvent then
		GlobalDispatcher:dispatch(GlobalNotify.SeasonBossInfoUpdated)
	end
end

function SeasonBossMO:updateCurPhaseProgress(phaseId, progress, maxProgress)
	progress = math.min(progress, maxProgress)

	if self._lastProgressPhaseId ~= phaseId or self._progress ~= progress or self._maxProgress ~= maxProgress then
		self._lastProgressPhaseId = phaseId
		self._progress = progress
		self._maxProgress = maxProgress

		GlobalDispatcher:dispatch(GlobalNotify.SeasonBossProgressUpdated)
	end
end

function SeasonBossMO:getCurPhaseProgress()
	return self._progress, self._maxProgress, self._progress >= self._maxProgress
end

function SeasonBossMO:_updateTeamsLockState()
	local teamModel = SeasonTeamsModel.instance
	local teams = teamModel:getTeams()
	local teamIdsMap = {}

	for i, teamId in pairs(self.doppelgangerPhaseInfoMap) do
		teamIdsMap[teamId] = true
	end

	for i, teamMo in ipairs(teams) do
		teamModel:setTeamServerLockState(teamMo.teamId, teamIdsMap[teamMo.teamId] == true)
	end
end

return SeasonBossMO
