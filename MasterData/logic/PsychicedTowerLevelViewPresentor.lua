-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/view/PsychicedTowerLevelViewPresentor.lua

module("logic.extensions.psychicedtower.view.PsychicedTowerLevelViewPresentor", package.seeall)

local PsychicedTowerLevelViewPresentor = class("PsychicedTowerLevelViewPresentor", ViewPresentor)

function PsychicedTowerLevelViewPresentor:ctor()
	PsychicedTowerLevelViewPresentor.super.ctor(self)
end

function PsychicedTowerLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PsychicedTowerLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/psychicedtower/psychicedtowerlevelview.prefab"
	}
end

function PsychicedTowerLevelViewPresentor:buildViews()
	return {
		PsychicedTowerLevelView.New()
	}
end

return PsychicedTowerLevelViewPresentor
