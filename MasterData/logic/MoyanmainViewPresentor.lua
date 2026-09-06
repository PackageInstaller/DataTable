-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/MoyanmainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.moyan.MoyanmainViewPresentor", package.seeall)

local MoyanmainViewPresentor = class("MoyanmainViewPresentor", ViewPresentor)

function MoyanmainViewPresentor:ctor()
	MoyanmainViewPresentor.super.ctor(self)
end

function MoyanmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MoyanmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/moyan/moyanmainview.prefab"
	}
end

function MoyanmainViewPresentor:buildViews()
	return {
		MoyanmainView.New()
	}
end

return MoyanmainViewPresentor
