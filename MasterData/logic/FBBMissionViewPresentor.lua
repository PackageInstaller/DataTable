-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/mission/FBBMissionViewPresentor.lua

module("logic.extensions.fbbchallenge.view.mission.FBBMissionViewPresentor", package.seeall)

local FBBMissionViewPresentor = class("FBBMissionViewPresentor", MissionViewPresentor)

function FBBMissionViewPresentor:buildViews()
	return {
		FBBMissionView.New(),
		FBBFmtRightView.New(),
		FBBFmtLeftView.New(),
		FBBMissionFmtView.New()
	}
end

return FBBMissionViewPresentor
