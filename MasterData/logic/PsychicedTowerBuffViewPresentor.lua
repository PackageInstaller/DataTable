-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/view/PsychicedTowerBuffViewPresentor.lua

module("logic.extensions.psychicedtower.view.PsychicedTowerBuffViewPresentor", package.seeall)

local PsychicedTowerBuffViewPresentor = class("PsychicedTowerBuffViewPresentor", ViewPresentor)

function PsychicedTowerBuffViewPresentor:ctor()
	PsychicedTowerBuffViewPresentor.super.ctor(self)
end

function PsychicedTowerBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PsychicedTowerBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/psychicedtower/psychicedtowerbuffview.prefab"
	}
end

function PsychicedTowerBuffViewPresentor:buildViews()
	return {
		PsychicedTowerBuffView.New()
	}
end

return PsychicedTowerBuffViewPresentor
