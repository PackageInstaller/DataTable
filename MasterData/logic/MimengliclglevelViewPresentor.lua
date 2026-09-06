-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimengliclglevelViewPresentor.lua

module("logic.extensions.mimengli.view.MimengliclglevelViewPresentor", package.seeall)

local MimengliclglevelViewPresentor = class("MimengliclglevelViewPresentor", ViewPresentor)

function MimengliclglevelViewPresentor:ctor()
	MimengliclglevelViewPresentor.super.ctor(self)
end

function MimengliclglevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MimengliclglevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mimengli/mimengliclglevelview.prefab"
	}
end

function MimengliclglevelViewPresentor:buildViews()
	return {
		MimengliclglevelView.New()
	}
end

return MimengliclglevelViewPresentor
