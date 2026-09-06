-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/SeniorMissionViewPresentor.lua

module("logic.extensions.mission.view.SeniorMissionViewPresentor", package.seeall)

local SeniorMissionViewPresentor = class("SeniorMissionViewPresentor", MissionViewPresentor)

function SeniorMissionViewPresentor:buildViews()
	return {
		SeniorMissionView.New(),
		SeniorFormationRightView.New(),
		SeniorFormationLeftView.New(),
		SeniorMissionFmtView.New(),
		SeniorFormTabView.New()
	}
end

return SeniorMissionViewPresentor
