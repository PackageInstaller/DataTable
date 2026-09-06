-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/UnitCompSeasonSyncPos.lua

module("logicscene.scene.unit.component.season.UnitCompSeasonSyncPos", package.seeall)

local UnitCompSeasonSyncPos = class("UnitCompSeasonSyncPos", UnitComponentBase)

function UnitCompSeasonSyncPos:onInit()
	self._lastGridX = nil
	self._lastGridY = nil
	self.enabled = true

	GlobalDispatcher:addListener(GlobalNotify.SeasonTeamServerPosUpdated, self._onServerPositionUpdated, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonTeamClientPosRollback, self._onClientPositionRollback, self)
end

function UnitCompSeasonSyncPos:onDestroy()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonTeamServerPosUpdated, self._onServerPositionUpdated, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonTeamClientPosRollback, self._onClientPositionRollback, self)
end

function UnitCompSeasonSyncPos:onUnitVisible(go)
	return
end

function UnitCompSeasonSyncPos:onUnitInVisible(go)
	return
end

function UnitCompSeasonSyncPos:trySyncPosition()
	return
end

function UnitCompSeasonSyncPos:_onServerPositionUpdated(teamId)
	if self._unit.teamData and self._unit.teamData.teamId == teamId and not self._unit.teamData:isClientServerPosSame() and self._unit.actions then
		self._unit.actions:stopAllActions()
	end
end

function UnitCompSeasonSyncPos:_onClientPositionRollback(teamId)
	if self._unit.teamData and self._unit.teamData.teamId == teamId and self._unit.actions then
		self._unit.actions:stopAllActions()
	end
end

function UnitCompSeasonSyncPos:syncPos()
	return
end

function UnitCompSeasonSyncPos:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	return
end

return UnitCompSeasonSyncPos
