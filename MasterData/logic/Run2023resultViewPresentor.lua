-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/run2023/view/Run2023resultViewPresentor.lua

module("logic.extensions.run2023.view.Run2023resultViewPresentor", package.seeall)

local Run2023resultViewPresentor = class("Run2023resultViewPresentor", ViewPresentor)

function Run2023resultViewPresentor:ctor()
	Run2023resultViewPresentor.super.ctor(self)
end

function Run2023resultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Run2023resultViewPresentor:dependWhatResources()
	return {
		"ui/views/run2023/run2023resultview.prefab"
	}
end

function Run2023resultViewPresentor:buildViews()
	return {
		Run2023ResultView.New()
	}
end

return Run2023resultViewPresentor
