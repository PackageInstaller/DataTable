-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/mission/WaterDarkTowerViewPresentor.lua

module("logic.extensions.waterdraktower.view.mission.WaterDarkTowerViewPresentor", package.seeall)

local WaterDarkTowerViewPresentor = class("WaterDarkTowerViewPresentor", MissionViewPresentor)

function WaterDarkTowerViewPresentor:buildViews()
	return {
		WaterDarkTowerMissionView.New(),
		WaterDarkTowerFmtRightView.New(),
		WaterDarkTowerFmtLeftView.New(),
		WaterDarkTowerMissionFmtView.New()
	}
end

return WaterDarkTowerViewPresentor
