-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/view/YinZhiClgResultViewPresentor.lua

module("logic.extensions.yinzhiclg.view.YinZhiClgResultViewPresentor", package.seeall)

local YinZhiClgResultViewPresentor = class("YinZhiClgResultViewPresentor", ViewPresentor)

function YinZhiClgResultViewPresentor:ctor()
	YinZhiClgResultViewPresentor.super.ctor(self)
end

function YinZhiClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YinZhiClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/yinzhiclg/yinzhiclgresultview.prefab"
	}
end

function YinZhiClgResultViewPresentor:buildViews()
	return {
		YinZhiClgResultView.New()
	}
end

return YinZhiClgResultViewPresentor
