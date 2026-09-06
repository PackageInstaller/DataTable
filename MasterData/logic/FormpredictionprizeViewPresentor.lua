-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/view/FormpredictionprizeViewPresentor.lua

module("logic.extensions.formprediction.view.FormpredictionprizeViewPresentor", package.seeall)

local FormpredictionprizeViewPresentor = class("FormpredictionprizeViewPresentor", ViewPresentor)

function FormpredictionprizeViewPresentor:ctor()
	FormpredictionprizeViewPresentor.super.ctor(self)
end

function FormpredictionprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormpredictionprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/formprediction/formpredictionprizeview.prefab"
	}
end

function FormpredictionprizeViewPresentor:buildViews()
	return {
		FormpredictionprizeView.New()
	}
end

return FormpredictionprizeViewPresentor
