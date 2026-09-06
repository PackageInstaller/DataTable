-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/timedpointracemode/mission/TimedPointRaceModeMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.timedpointracemode.mission.TimedPointRaceModeMissionViewPresentor", package.seeall)

local TimedPointRaceModeMissionViewPresentor = class("TimedPointRaceModeMissionViewPresentor", MissionViewPresentor)

function TimedPointRaceModeMissionViewPresentor:buildViews()
	return {
		TimedPointRaceModeMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		TimedPointRaceModeMissionFmtView.New()
	}
end

return TimedPointRaceModeMissionViewPresentor
