-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/view/FormpredictionrateViewPresentor.lua

module("logic.extensions.formprediction.view.FormpredictionrateViewPresentor", package.seeall)

local FormpredictionrateViewPresentor = class("FormpredictionrateViewPresentor", ViewPresentor)

function FormpredictionrateViewPresentor:ctor()
	FormpredictionrateViewPresentor.super.ctor(self)
end

function FormpredictionrateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormpredictionrateViewPresentor:dependWhatResources()
	return {
		"ui/views/formprediction/formpredictionrateview.prefab"
	}
end

function FormpredictionrateViewPresentor:buildViews()
	return {
		FormpredictionrateView.New()
	}
end

return FormpredictionrateViewPresentor
