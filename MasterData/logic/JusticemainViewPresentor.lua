-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/justice/view/JusticemainViewPresentor.lua

module("logic.extensions.justice.view.JusticemainViewPresentor", package.seeall)

local JusticemainViewPresentor = class("JusticemainViewPresentor", ViewPresentor)

function JusticemainViewPresentor:ctor()
	JusticemainViewPresentor.super.ctor(self)
end

function JusticemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JusticemainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/justice/justicemainview.prefab"
	}
end

function JusticemainViewPresentor:buildViews()
	return {
		JusticemainView.New()
	}
end

return JusticemainViewPresentor
