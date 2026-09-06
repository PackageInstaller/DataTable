-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaModeViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaModeViewPresentor", package.seeall)

local MiyaModeViewPresentor = class("MiyaModeViewPresentor", ViewPresentor)

function MiyaModeViewPresentor:ctor()
	MiyaModeViewPresentor.super.ctor(self)
end

function MiyaModeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiyaModeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miyamodeview.prefab"
	}
end

function MiyaModeViewPresentor:buildViews()
	return {
		MiyaModeView.New()
	}
end

return MiyaModeViewPresentor
