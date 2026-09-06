-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/mission/MississiMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.mississi.mission.MississiMissionViewPresentor", package.seeall)

local MississiMissionViewPresentor = class("MississiMissionViewPresentor", MissionViewPresentor)

function MississiMissionViewPresentor:buildViews()
	return {
		MississiMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		MississiMissionFmtView.New()
	}
end

return MississiMissionViewPresentor
