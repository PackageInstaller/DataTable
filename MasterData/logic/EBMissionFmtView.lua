-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/EBMissionFmtView.lua

module("logic.extensions.mission.view.EBMissionFmtView", package.seeall)

local EBMissionFmtView = class("EBMissionFmtView", MissionFmtView)

function EBMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function EBMissionFmtView:_getCreepCos()
	local waveId = EndlessBattleModel.instance:getCurWaveId()
	local stageCfgs = EndlessBattleConfig.instance:getStageCfgsByWaveId(waveId)
	local stageCfg = stageCfgs[1]

	return (EndlessBattleConfig.instance:getCreepCfgs(stageCfg.creepsMasterId))
end

function EBMissionFmtView:_getMonsterCo()
	return {}
end

return EBMissionFmtView
