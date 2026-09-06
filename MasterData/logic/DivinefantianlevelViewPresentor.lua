-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/view/copy/DivinefantianlevelViewPresentor.lua

module("logic.extensions.femalepsychic.view.copy.DivinefantianlevelViewPresentor", package.seeall)

local DivinefantianlevelViewPresentor = class("DivinefantianlevelViewPresentor", ViewPresentor)

function DivinefantianlevelViewPresentor:ctor()
	DivinefantianlevelViewPresentor.super.ctor(self)
end

function DivinefantianlevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinefantianlevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/femalepsychic/copy/divinefantianlevelview.prefab"
	}
end

function DivinefantianlevelViewPresentor:buildViews()
	return {
		DivinefantianlevelView.New()
	}
end

return DivinefantianlevelViewPresentor
