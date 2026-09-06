-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/view/YinZhiClgStageViewPresentor.lua

module("logic.extensions.yinzhiclg.view.YinZhiClgStageViewPresentor", package.seeall)

local YinZhiClgStageViewPresentor = class("YinZhiClgStageViewPresentor", ViewPresentor)

function YinZhiClgStageViewPresentor:ctor()
	YinZhiClgStageViewPresentor.super.ctor(self)
end

function YinZhiClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YinZhiClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/yinzhiclg/yinzhiclgstageview.prefab"
	}
end

function YinZhiClgStageViewPresentor:buildViews()
	return {
		YinZhiClgStageView.New()
	}
end

return YinZhiClgStageViewPresentor
