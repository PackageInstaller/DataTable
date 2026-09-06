-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/view/YunJieDragonClgCollectViewPresentor.lua

module("logic.extensions.yunjiedragonclg.view.YunJieDragonClgCollectViewPresentor", package.seeall)

local YunJieDragonClgCollectViewPresentor = class("YunJieDragonClgCollectViewPresentor", ViewPresentor)

function YunJieDragonClgCollectViewPresentor:ctor()
	YunJieDragonClgCollectViewPresentor.super.ctor(self)
end

function YunJieDragonClgCollectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YunJieDragonClgCollectViewPresentor:dependWhatResources()
	return {
		"ui/views/yunjiedragonclg/yunjiedragonclgcollectview.prefab"
	}
end

function YunJieDragonClgCollectViewPresentor:buildViews()
	return {
		YunJieDragonClgCollectView.New()
	}
end

return YunJieDragonClgCollectViewPresentor
