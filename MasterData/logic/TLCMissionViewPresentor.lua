-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/TLCMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.TLCMissionViewPresentor", package.seeall)

local TLCMissionViewPresentor = class("TLCMissionViewPresentor", MissionViewPresentor)

function TLCMissionViewPresentor:buildViews()
	return {
		TLCMissionView.New(),
		TLCFmtRightView.New(),
		TLCFmtLeftView.New(),
		TLCMissionFmtView.New()
	}
end

return TLCMissionViewPresentor
