-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/ExcellentClassViewPresentor.lua

module("logic.extensions.sevendays.view.ExcellentClassViewPresentor", package.seeall)

local ExcellentClassViewPresentor = class("ExcellentClassViewPresentor", ViewWithGuidePresentor)

function ExcellentClassViewPresentor:ctor()
	ExcellentClassViewPresentor.super.ctor(self)
end

function ExcellentClassViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExcellentClassViewPresentor:dependWhatResources()
	return {
		"ui/views/sevendays/excellentclassview.prefab"
	}
end

function ExcellentClassViewPresentor:buildViews()
	return {
		ExcellentClassView.New()
	}
end

return ExcellentClassViewPresentor
