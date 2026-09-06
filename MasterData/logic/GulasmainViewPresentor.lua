-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/view/GulasmainViewPresentor.lua

module("logic.extensions.gulas.view.GulasmainViewPresentor", package.seeall)

local GulasmainViewPresentor = class("GulasmainViewPresentor", ViewPresentor)

function GulasmainViewPresentor:ctor()
	GulasmainViewPresentor.super.ctor(self)
end

function GulasmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GulasmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/gulas/gulasmainview.prefab"
	}
end

function GulasmainViewPresentor:buildViews()
	return {
		GulasmainView.New()
	}
end

return GulasmainViewPresentor
