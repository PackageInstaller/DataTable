-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/view/PetsearchMissionViewPresentor.lua

module("logic.extensions.petsearch.view.PetsearchMissionViewPresentor", package.seeall)

local PetsearchMissionViewPresentor = class("PetsearchMissionViewPresentor", MissionViewPresentor)

function PetsearchMissionViewPresentor:ctor()
	PetsearchMissionViewPresentor.super.ctor(self)
end

function PetsearchMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetsearchMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function PetsearchMissionViewPresentor:buildViews()
	return {
		PetsearchMissionView.New(),
		FormationRightView.New(),
		FormationLeftView.New(),
		PetsearchMissionFmtView.New()
	}
end

function PetsearchMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PetsearchMissionViewPresentor
