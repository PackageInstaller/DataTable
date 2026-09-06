-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/view/GulaslevelsViewPresentor.lua

module("logic.extensions.gulas.view.GulaslevelsViewPresentor", package.seeall)

local GulaslevelsViewPresentor = class("GulaslevelsViewPresentor", ViewPresentor)

function GulaslevelsViewPresentor:ctor()
	GulaslevelsViewPresentor.super.ctor(self)
end

function GulaslevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GulaslevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/gulas/gulaslevelsview.prefab"
	}
end

function GulaslevelsViewPresentor:buildViews()
	return {
		GulaslevelsView.New()
	}
end

return GulaslevelsViewPresentor
