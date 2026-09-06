-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectshowViewPresentor.lua

module("logic.extensions.goddesscollector.view.GoddesscollectshowViewPresentor", package.seeall)

local GoddesscollectshowViewPresentor = class("GoddesscollectshowViewPresentor", ViewPresentor)

function GoddesscollectshowViewPresentor:ctor()
	GoddesscollectshowViewPresentor.super.ctor(self)
end

function GoddesscollectshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesscollectshowViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscollector/goddesscollectshowview.prefab"
	}
end

function GoddesscollectshowViewPresentor:buildViews()
	return {
		GoddesscollectshowView.New()
	}
end

return GoddesscollectshowViewPresentor
