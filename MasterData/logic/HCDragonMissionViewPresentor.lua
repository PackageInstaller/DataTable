-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/holychallmission/HCDragonMissionViewPresentor.lua

module("logic.extensions.kingway.view.holychallmission.HCDragonMissionViewPresentor", package.seeall)

local HCDragonMissionViewPresentor = class("HCDragonMissionViewPresentor", MissionViewPresentor)

function HCDragonMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		"ui/views/kingway/item_holychall.prefab",
		self:_addCommonRes()
	}
end

function HCDragonMissionViewPresentor:buildViews()
	return {
		HolyChallMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		HolyChallMissionFmtView.New()
	}
end

return HCDragonMissionViewPresentor
