-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/formation/MoonKingMissionViewPresentor.lua

module("logic.extensions.moonking.view.formation.MoonKingMissionViewPresentor", package.seeall)

local MoonKingMissionViewPresentor = class("MoonKingMissionViewPresentor", MissionViewPresentor)

function MoonKingMissionViewPresentor:ctor()
	MoonKingMissionViewPresentor.super.ctor(self)
end

function MoonKingMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MoonKingMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function MoonKingMissionViewPresentor:buildViews()
	return {
		MoonKingMissionView.New(),
		MoonKingFmtRightView.New(),
		FormationLeftView.New(),
		MoonKingMissionFmtView.New()
	}
end

return MoonKingMissionViewPresentor
