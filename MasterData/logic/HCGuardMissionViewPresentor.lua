-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/holychallmission/HCGuardMissionViewPresentor.lua

module("logic.extensions.kingway.view.holychallmission.HCGuardMissionViewPresentor", package.seeall)

local HCGuardMissionViewPresentor = class("HCGuardMissionViewPresentor", MissionViewPresentor)

function HCGuardMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		"ui/views/kingway/item_holychall.prefab",
		self:_addCommonRes()
	}
end

function HCGuardMissionViewPresentor:buildViews()
	return {
		HolyChallMissionView.New(),
		HolyChallFmtRightView.New(),
		HolyChallFmtLeftView.New(),
		HolyChallMissionFmtView.New()
	}
end

return HCGuardMissionViewPresentor
