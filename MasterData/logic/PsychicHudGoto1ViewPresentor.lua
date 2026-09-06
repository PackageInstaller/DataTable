-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/view/PsychicHudGoto1ViewPresentor.lua

module("logic.extensions.psychicimprove.view.PsychicHudGoto1ViewPresentor", package.seeall)

local PsychicHudGoto1ViewPresentor = class("PsychicHudGoto1ViewPresentor", ViewPresentor)

function PsychicHudGoto1ViewPresentor:ctor()
	PsychicHudGoto1ViewPresentor.super.ctor(self)
end

function PsychicHudGoto1ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PsychicHudGoto1ViewPresentor:dependWhatResources()
	return {
		"ui/views/psychicimprove/psychichudgoto1view.prefab"
	}
end

function PsychicHudGoto1ViewPresentor:buildViews()
	return {
		PsychicHudGoto1View.New()
	}
end

return PsychicHudGoto1ViewPresentor
