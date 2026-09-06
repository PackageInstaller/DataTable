-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgMainViewPresentor.lua

module("logic.extensions.wudiclg.view.WuDiClgMainViewPresentor", package.seeall)

local WuDiClgMainViewPresentor = class("WuDiClgMainViewPresentor", ViewPresentor)

function WuDiClgMainViewPresentor:ctor()
	WuDiClgMainViewPresentor.super.ctor(self)
end

function WuDiClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WuDiClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/wudiclg/wudiclgmainview.prefab"
	}
end

function WuDiClgMainViewPresentor:buildViews()
	return {
		WuDiClgMainView.New()
	}
end

return WuDiClgMainViewPresentor
