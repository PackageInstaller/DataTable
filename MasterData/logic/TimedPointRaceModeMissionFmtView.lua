-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/timedpointracemode/mission/TimedPointRaceModeMissionFmtView.lua

module("logic.extensions.timelimitedchallenge.view.timedpointracemode.mission.TimedPointRaceModeMissionFmtView", package.seeall)

local TimedPointRaceModeMissionFmtView = class("TimedPointRaceModeMissionFmtView", MissionFmtView)

function TimedPointRaceModeMissionFmtView:_getCreepCos()
	local creepsMasterId = self:_getMonsterCo().creepsMasterId

	return (TimedPointRaceModeConfig.instance:getMonsterCfgs(checknumber(creepsMasterId)))
end

function TimedPointRaceModeMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()

	if params then
		return params
	end

	return {}
end

function TimedPointRaceModeMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return TimedPointRaceModeMissionFmtView
