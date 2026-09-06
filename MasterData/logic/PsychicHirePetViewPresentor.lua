-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/view/PsychicHirePetViewPresentor.lua

module("logic.extensions.psychicimprove.view.PsychicHirePetViewPresentor", package.seeall)

local PsychicHirePetViewPresentor = class("PsychicHirePetViewPresentor", ViewPresentor)

function PsychicHirePetViewPresentor:ctor()
	PsychicHirePetViewPresentor.super.ctor(self)
end

function PsychicHirePetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PsychicHirePetViewPresentor:dependWhatResources()
	return {
		"ui/views/psychicimprove/channelerselectview.prefab"
	}
end

function PsychicHirePetViewPresentor:buildViews()
	return {
		PsychicHirePetView.New()
	}
end

return PsychicHirePetViewPresentor
