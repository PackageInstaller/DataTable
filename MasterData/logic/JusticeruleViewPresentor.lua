-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/justice/view/JusticeruleViewPresentor.lua

module("logic.extensions.justice.view.JusticeruleViewPresentor", package.seeall)

local JusticeruleViewPresentor = class("JusticeruleViewPresentor", ViewPresentor)

function JusticeruleViewPresentor:ctor()
	JusticeruleViewPresentor.super.ctor(self)
end

function JusticeruleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JusticeruleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/justice/justiceruleview.prefab"
	}
end

function JusticeruleViewPresentor:buildViews()
	return {
		JusticeruleView.New()
	}
end

return JusticeruleViewPresentor
