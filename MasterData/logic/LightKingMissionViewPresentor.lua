-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingMissionViewPresentor", package.seeall)

local LightKingMissionViewPresentor = class("LightKingMissionViewPresentor", MissionViewPresentor)

function LightKingMissionViewPresentor:buildViews()
	return {
		LightKingMissionView.New(),
		LightKingFmtRightView.New(),
		LightKingFmtLeftView.New(),
		LightKingMissionFmtView.New()
	}
end

return LightKingMissionViewPresentor
