-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaResetModeViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaResetModeViewPresentor", package.seeall)

local MiyaResetModeViewPresentor = class("MiyaResetModeViewPresentor", ViewPresentor)

function MiyaResetModeViewPresentor:ctor()
	MiyaResetModeViewPresentor.super.ctor(self)
end

function MiyaResetModeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiyaResetModeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miyaresetmodeview.prefab"
	}
end

function MiyaResetModeViewPresentor:buildViews()
	return {
		MiyaResetModeView.New()
	}
end

return MiyaResetModeViewPresentor
