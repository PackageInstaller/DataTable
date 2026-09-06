-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/view/FormpredictionmainViewPresentor.lua

module("logic.extensions.formprediction.view.FormpredictionmainViewPresentor", package.seeall)

local FormpredictionmainViewPresentor = class("FormpredictionmainViewPresentor", ViewPresentor)

function FormpredictionmainViewPresentor:ctor()
	FormpredictionmainViewPresentor.super.ctor(self)
end

function FormpredictionmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormpredictionmainViewPresentor:dependWhatResources()
	return {
		"ui/views/formprediction/formpredictionmainview.prefab"
	}
end

function FormpredictionmainViewPresentor:buildViews()
	return {
		FormpredictionmainView.New()
	}
end

return FormpredictionmainViewPresentor
