-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/mission/LongnvMissionViewPresentor.lua

module("logic.extensions.mangtower.view.LongnvMissionViewPresentor", package.seeall)

local LongnvMissionViewPresentor = class("LongnvMissionViewPresentor", MissionViewPresentor)

function LongnvMissionViewPresentor:buildViews()
	return {
		LongnvMissionView.New(),
		LongnvFmtRightView.New(),
		LongnvFmtLeftView.New(),
		LongnvMissionFmtView.New()
	}
end

return LongnvMissionViewPresentor
