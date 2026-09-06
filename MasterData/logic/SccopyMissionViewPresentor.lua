-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SccopyMissionViewPresentor.lua

module("logic.extensions.scenariocopy.view.SccopyMissionViewPresentor", package.seeall)

local SccopyMissionViewPresentor = class("SccopyMissionViewPresentor", MissionViewPresentor)

SccopyMissionViewPresentor.itemSccPet = "ui/views/scenariocopy/item_scenariocopy.prefab"

function SccopyMissionViewPresentor:ctor()
	SccopyMissionViewPresentor.super.ctor(self)
end

function SccopyMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SccopyMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		SccopyMissionViewPresentor.itemSccPet,
		self:_addCommonRes()
	}
end

function SccopyMissionViewPresentor:buildViews()
	return {
		SccopyMissionView.New(),
		SccopyFmtRightView.New(),
		SccopyFmtLeftView.New(),
		SccopyMissionFmtView.New()
	}
end

function SccopyMissionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SccopyMissionViewPresentor
