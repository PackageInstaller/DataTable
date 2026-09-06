-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmanKingMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.TianmanKingMissionViewPresentor", package.seeall)

local TianmanKingMissionViewPresentor = class("TianmanKingMissionViewPresentor", MissionViewPresentor)

function TianmanKingMissionViewPresentor:buildViews()
	return {
		TianmanKingMissionView.New(),
		TianmanKingMissionFmtRightView.New(),
		TianmanKingMissionFmtLeftView.New(),
		TianmanKingMissionFmtView.New()
	}
end

return TianmanKingMissionViewPresentor
