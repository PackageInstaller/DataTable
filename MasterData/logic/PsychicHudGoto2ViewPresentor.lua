-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/view/PsychicHudGoto2ViewPresentor.lua

module("logic.extensions.psychicimprove.view.PsychicHudGoto2ViewPresentor", package.seeall)

local PsychicHudGoto2ViewPresentor = class("PsychicHudGoto2ViewPresentor", ViewPresentor)

function PsychicHudGoto2ViewPresentor:ctor()
	PsychicHudGoto2ViewPresentor.super.ctor(self)
end

function PsychicHudGoto2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PsychicHudGoto2ViewPresentor:dependWhatResources()
	return {
		"ui/views/psychicimprove/psychichudgoto2view.prefab"
	}
end

function PsychicHudGoto2ViewPresentor:buildViews()
	return {
		PsychicHudGoto2View.New()
	}
end

return PsychicHudGoto2ViewPresentor
