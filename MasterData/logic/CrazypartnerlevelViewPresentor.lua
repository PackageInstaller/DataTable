-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazypartnerlevelViewPresentor.lua

module("logic.extensions.crazypartner.view.CrazypartnerlevelViewPresentor", package.seeall)

local CrazypartnerlevelViewPresentor = class("CrazypartnerlevelViewPresentor", ViewPresentor)

function CrazypartnerlevelViewPresentor:ctor()
	CrazypartnerlevelViewPresentor.super.ctor(self)
end

function CrazypartnerlevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CrazypartnerlevelViewPresentor:dependWhatResources()
	return {
		"ui/views/crazypartner/crazypartnerlevelview.prefab"
	}
end

function CrazypartnerlevelViewPresentor:buildViews()
	return {
		CrazyPartnerLevelView.New()
	}
end

return CrazypartnerlevelViewPresentor
