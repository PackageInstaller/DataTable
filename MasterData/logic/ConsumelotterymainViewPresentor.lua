-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumelottery/view/ConsumelotterymainViewPresentor.lua

module("logic.extensions.consumelottery.view.ConsumelotterymainViewPresentor", package.seeall)

local ConsumelotterymainViewPresentor = class("ConsumelotterymainViewPresentor", ViewPresentor)

function ConsumelotterymainViewPresentor:ctor()
	ConsumelotterymainViewPresentor.super.ctor(self)
end

function ConsumelotterymainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ConsumelotterymainViewPresentor:dependWhatResources()
	return {
		"ui/views/consumelottery/consumelotterymainview.prefab"
	}
end

function ConsumelotterymainViewPresentor:buildViews()
	return {
		ConsumelotterymainView.New()
	}
end

return ConsumelotterymainViewPresentor
