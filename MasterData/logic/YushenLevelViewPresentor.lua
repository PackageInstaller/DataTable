-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/copy/YushenLevelViewPresentor.lua

module("logic.extensions.dragonxiuer.view.YushenLevelViewPresentor", package.seeall)

local YushenLevelViewPresentor = class("YushenLevelViewPresentor", ViewPresentor)

function YushenLevelViewPresentor:ctor()
	YushenLevelViewPresentor.super.ctor(self)
end

function YushenLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YushenLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonxiuer/copy/yushenlevelview.prefab"
	}
end

function YushenLevelViewPresentor:buildViews()
	return {
		YushenLevelView.New()
	}
end

return YushenLevelViewPresentor
