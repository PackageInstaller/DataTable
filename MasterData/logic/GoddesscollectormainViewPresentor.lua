-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectormainViewPresentor.lua

module("logic.extensions.goddesscollector.view.GoddesscollectormainViewPresentor", package.seeall)

local GoddesscollectormainViewPresentor = class("GoddesscollectormainViewPresentor", ViewPresentor)

function GoddesscollectormainViewPresentor:ctor()
	GoddesscollectormainViewPresentor.super.ctor(self)
end

function GoddesscollectormainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesscollectormainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscollector/goddesscollectormainview.prefab"
	}
end

function GoddesscollectormainViewPresentor:buildViews()
	return {
		GoddesscollectormainView.New()
	}
end

return GoddesscollectormainViewPresentor
