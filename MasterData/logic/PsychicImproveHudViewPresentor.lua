-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/view/PsychicImproveHudViewPresentor.lua

module("logic.extensions.psychicimprove.view.PsychicImproveHudViewPresentor", package.seeall)

local PsychicImproveHudViewPresentor = class("PsychicImproveHudViewPresentor", ViewPresentor)

function PsychicImproveHudViewPresentor:ctor()
	PsychicImproveHudViewPresentor.super.ctor(self)
end

function PsychicImproveHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PsychicImproveHudViewPresentor:dependWhatResources()
	return {
		"ui/views/psychicimprove/psychicenhancemainview.prefab"
	}
end

function PsychicImproveHudViewPresentor:buildViews()
	return {
		PsychicImproveHudView.New()
	}
end

return PsychicImproveHudViewPresentor
