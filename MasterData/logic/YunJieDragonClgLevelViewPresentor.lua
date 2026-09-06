-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/view/YunJieDragonClgLevelViewPresentor.lua

module("logic.extensions.yunjiedragonclg.view.YunJieDragonClgLevelViewPresentor", package.seeall)

local YunJieDragonClgLevelViewPresentor = class("YunJieDragonClgLevelViewPresentor", ViewPresentor)

function YunJieDragonClgLevelViewPresentor:ctor()
	YunJieDragonClgLevelViewPresentor.super.ctor(self)
end

function YunJieDragonClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YunJieDragonClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/yunjiedragonclg/yunjiedragonclglevelview.prefab"
	}
end

function YunJieDragonClgLevelViewPresentor:buildViews()
	return {
		YunJieDragonClgLevelView.New()
	}
end

return YunJieDragonClgLevelViewPresentor
