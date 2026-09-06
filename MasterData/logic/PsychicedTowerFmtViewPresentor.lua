-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/view/PsychicedTowerFmtViewPresentor.lua

module("logic.extensions.psychicedtower.view.PsychicedTowerFmtViewPresentor", package.seeall)

local PsychicedTowerFmtViewPresentor = class("PsychicedTowerFmtViewPresentor", ViewPresentor)

function PsychicedTowerFmtViewPresentor:ctor()
	PsychicedTowerFmtViewPresentor.super.ctor(self)
end

function PsychicedTowerFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PsychicedTowerFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/psychicedtower/psychicedtowerfmtview.prefab"
	}
end

function PsychicedTowerFmtViewPresentor:buildViews()
	return {
		PsychicedTowerFmtView.New()
	}
end

return PsychicedTowerFmtViewPresentor
