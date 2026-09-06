-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/view/PsychicedTowerRankViewPresentor.lua

module("logic.extensions.psychicedtower.view.PsychicedTowerRankViewPresentor", package.seeall)

local PsychicedTowerRankViewPresentor = class("PsychicedTowerRankViewPresentor", ViewPresentor)

function PsychicedTowerRankViewPresentor:ctor()
	PsychicedTowerRankViewPresentor.super.ctor(self)
end

function PsychicedTowerRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PsychicedTowerRankViewPresentor:dependWhatResources()
	return {
		"ui/views/psychicedtower/psychicedtowerrankview.prefab"
	}
end

function PsychicedTowerRankViewPresentor:buildViews()
	return {
		PsychicedTowerRankView.New()
	}
end

return PsychicedTowerRankViewPresentor
