-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/view/YunJieDragonClgMainViewPresentor.lua

module("logic.extensions.yunjiedragonclg.view.YunJieDragonClgMainViewPresentor", package.seeall)

local YunJieDragonClgMainViewPresentor = class("YunJieDragonClgMainViewPresentor", ViewPresentor)

function YunJieDragonClgMainViewPresentor:ctor()
	YunJieDragonClgMainViewPresentor.super.ctor(self)
end

function YunJieDragonClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YunJieDragonClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/yunjiedragonclg/yunjiedragonclgmainview.prefab"
	}
end

function YunJieDragonClgMainViewPresentor:buildViews()
	return {
		YunJieDragonClgMainView.New()
	}
end

return YunJieDragonClgMainViewPresentor
