-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaMainViewPresentor", package.seeall)

local MiyaMainViewPresentor = class("MiyaMainViewPresentor", ViewPresentor)

function MiyaMainViewPresentor:ctor()
	MiyaMainViewPresentor.super.ctor(self)
end

function MiyaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiyaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miyamainview.prefab"
	}
end

function MiyaMainViewPresentor:buildViews()
	return {
		MiyaMainView.New()
	}
end

return MiyaMainViewPresentor
