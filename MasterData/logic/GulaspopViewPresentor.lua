-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/view/GulaspopViewPresentor.lua

module("logic.extensions.gulas.view.GulaspopViewPresentor", package.seeall)

local GulaspopViewPresentor = class("GulaspopViewPresentor", ViewPresentor)

function GulaspopViewPresentor:ctor()
	GulaspopViewPresentor.super.ctor(self)
end

function GulaspopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GulaspopViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/gulas/gulaspopview.prefab"
	}
end

function GulaspopViewPresentor:buildViews()
	return {
		GulaspopView.New()
	}
end

return GulaspopViewPresentor
