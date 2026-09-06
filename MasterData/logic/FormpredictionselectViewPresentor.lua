-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/view/FormpredictionselectViewPresentor.lua

module("logic.extensions.formprediction.view.FormpredictionselectViewPresentor", package.seeall)

local FormpredictionselectViewPresentor = class("FormpredictionselectViewPresentor", ViewPresentor)

function FormpredictionselectViewPresentor:ctor()
	FormpredictionselectViewPresentor.super.ctor(self)
end

function FormpredictionselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormpredictionselectViewPresentor:dependWhatResources()
	return {
		"ui/views/formprediction/formpredictionselectview.prefab"
	}
end

function FormpredictionselectViewPresentor:buildViews()
	return {
		FormpredictionselectView.New()
	}
end

return FormpredictionselectViewPresentor
