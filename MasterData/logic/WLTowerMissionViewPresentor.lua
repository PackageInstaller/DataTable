-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/formation/WLTowerMissionViewPresentor.lua

module("logic.extensions.waterdraktower.view.formation.WLTowerMissionViewPresentor", package.seeall)

local WLTowerMissionViewPresentor = class("WLTowerMissionViewPresentor", MissionViewPresentor)

function WLTowerMissionViewPresentor:buildViews()
	return {
		WLTowerMissionView.New(),
		WLTowerFmtRightView.New(),
		WLTowerFmtLeftView.New(),
		WLTowerMissionFmtView.New()
	}
end

return WLTowerMissionViewPresentor
