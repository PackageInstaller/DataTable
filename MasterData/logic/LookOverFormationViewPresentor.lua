-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/LookOverFormationViewPresentor.lua

module("logic.extensions.dragonlords.view.LookOverFormationViewPresentor", package.seeall)

local LookOverFormationViewPresentor = class("LookOverFormationViewPresentor", ViewPresentor)

function LookOverFormationViewPresentor:ctor()
	LookOverFormationViewPresentor.super.ctor(self)
end

function LookOverFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LookOverFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/dragonlords/lookoverformationview.prefab"
	}
end

function LookOverFormationViewPresentor:buildViews()
	return {
		LookOverFormationView.New()
	}
end

return LookOverFormationViewPresentor
