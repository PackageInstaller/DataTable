-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/run2023/view/Run2023enterViewPresentor.lua

module("logic.extensions.run2023.view.Run2023enterViewPresentor", package.seeall)

local Run2023enterViewPresentor = class("Run2023enterViewPresentor", ViewPresentor)

function Run2023enterViewPresentor:ctor()
	Run2023enterViewPresentor.super.ctor(self)
end

function Run2023enterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Run2023enterViewPresentor:dependWhatResources()
	return {
		"ui/views/run2023/run2023enterview.prefab"
	}
end

function Run2023enterViewPresentor:buildViews()
	return {
		Run2023EnterView.New()
	}
end

return Run2023enterViewPresentor
