-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/fmtview/HexagramMissionViewPresentor.lua

module("logic.extensions.yirenpozhen.view.fmtview.HexagramMissionViewPresentor", package.seeall)

local HexagramMissionViewPresentor = class("HexagramMissionViewPresentor", MissionViewPresentor)

function HexagramMissionViewPresentor:buildViews()
	return {
		HexagramMissionView.New(),
		HexagramFmtRightView.New(),
		HexagramFmtLeftView.New(),
		HexagramMissionFmtView.New()
	}
end

return HexagramMissionViewPresentor
