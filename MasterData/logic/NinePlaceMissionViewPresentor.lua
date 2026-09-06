-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NinePlaceMissionViewPresentor.lua

module("logic.extensions.nineplace.view.NinePlaceMissionViewPresentor", package.seeall)

local NinePlaceMissionViewPresentor = class("NinePlaceMissionViewPresentor", MissionViewPresentor)

function NinePlaceMissionViewPresentor:ctor()
	NinePlaceMissionViewPresentor.super.ctor(self)
end

function NinePlaceMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NinePlaceMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function NinePlaceMissionViewPresentor:buildViews()
	return {
		NinePlaceMissionView.New(),
		FormationRightView.New(),
		NinePlaceFormationLeftView.New(),
		NinePlaceMissionFmtView.New()
	}
end

return NinePlaceMissionViewPresentor
