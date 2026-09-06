-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/view/PsychicedTowerMainViewPresentor.lua

module("logic.extensions.psychicedtower.view.PsychicedTowerMainViewPresentor", package.seeall)

local PsychicedTowerMainViewPresentor = class("PsychicedTowerMainViewPresentor", ViewPresentor)

function PsychicedTowerMainViewPresentor:ctor()
	PsychicedTowerMainViewPresentor.super.ctor(self)
end

function PsychicedTowerMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PsychicedTowerMainViewPresentor:dependWhatResources()
	return {
		"ui/views/psychicedtower/psychicedtowermainview.prefab"
	}
end

function PsychicedTowerMainViewPresentor:buildViews()
	return {
		PsychicedTowerMainView.New()
	}
end

return PsychicedTowerMainViewPresentor
