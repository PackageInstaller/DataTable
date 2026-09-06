-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/run2023/view/Run2023MainViewPresentor.lua

module("logic.extensions.run2023.view.Run2023MainViewPresentor", package.seeall)

local Run2023MainViewPresentor = class("Run2023MainViewPresentor", ViewPresentor)

function Run2023MainViewPresentor:ctor()
	Run2023MainViewPresentor.super.ctor(self)
end

function Run2023MainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Run2023MainViewPresentor:dependWhatResources()
	return {
		"ui/views/run2023/run2023mainview.prefab"
	}
end

function Run2023MainViewPresentor:buildViews()
	return {
		Run2023MainView.New()
	}
end

return Run2023MainViewPresentor
