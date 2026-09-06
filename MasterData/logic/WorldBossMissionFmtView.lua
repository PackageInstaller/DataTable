-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossMissionFmtView.lua

module("logic.extensions.worldboss.view.WorldBossMissionFmtView", package.seeall)

local WorldBossMissionFmtView = class("WorldBossMissionFmtView", MissionFmtView)

function WorldBossMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "？？？"
end

function WorldBossMissionFmtView:_getCreepCos()
	local _todayBossId = WorldBossController.instance:getTodayBossId() or 0
	local _enemyTeamId = WorldBossController.instance:getEnemyTeamId(_todayBossId) or 0
	local _teamInfo = WorldBossController.instance:getBossCreeps(_enemyTeamId)

	return _teamInfo or {}
end

function WorldBossMissionFmtView:_getMonsterCo()
	local _todayBossId = WorldBossController.instance:getTodayBossId() or 0
	local _enemyTeamId = WorldBossController.instance:getEnemyTeamId(_todayBossId) or 0
	local _worldBossTeam = WorldBossConfig.instance:getWorldBossTeam() or {}

	return _worldBossTeam[_enemyTeamId] or {}
end

function WorldBossMissionFmtView:_selectItem(index)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return WorldBossMissionFmtView
