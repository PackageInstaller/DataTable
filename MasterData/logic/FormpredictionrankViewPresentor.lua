-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/view/FormpredictionrankViewPresentor.lua

module("logic.extensions.formprediction.view.FormpredictionrankViewPresentor", package.seeall)

local FormpredictionrankViewPresentor = class("FormpredictionrankViewPresentor", ViewPresentor)

function FormpredictionrankViewPresentor:ctor()
	FormpredictionrankViewPresentor.super.ctor(self)
end

function FormpredictionrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormpredictionrankViewPresentor:dependWhatResources()
	return {
		"ui/views/formprediction/formpredictionrankview.prefab"
	}
end

function FormpredictionrankViewPresentor:buildViews()
	return {
		FormpredictionrankView.New()
	}
end

return FormpredictionrankViewPresentor
