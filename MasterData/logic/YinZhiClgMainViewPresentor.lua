-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/view/YinZhiClgMainViewPresentor.lua

module("logic.extensions.yinzhiclg.view.YinZhiClgMainViewPresentor", package.seeall)

local YinZhiClgMainViewPresentor = class("YinZhiClgMainViewPresentor", ViewPresentor)

function YinZhiClgMainViewPresentor:ctor()
	YinZhiClgMainViewPresentor.super.ctor(self)
end

function YinZhiClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YinZhiClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/yinzhiclg/yinzhiclgmainview.prefab"
	}
end

function YinZhiClgMainViewPresentor:buildViews()
	return {
		YinZhiClgMainView.New()
	}
end

return YinZhiClgMainViewPresentor
