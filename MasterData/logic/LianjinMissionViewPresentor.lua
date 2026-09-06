-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lianjinmm/LianjinMissionViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lianjinmm.LianjinMissionViewPresentor", package.seeall)

local LianjinMissionViewPresentor = class("LianjinMissionViewPresentor", MissionViewPresentor)

function LianjinMissionViewPresentor:buildViews()
	return {
		LianjinMissionView.New(),
		LianjinFormationRightView.New(),
		LianjinFormationLeftView.New(),
		LianjinMissionFmtView.New()
	}
end

return LianjinMissionViewPresentor
