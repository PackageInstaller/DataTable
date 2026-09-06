-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgExtFailViewPresentor.lua

module("logic.extensions.wudiclg.view.WuDiClgExtFailViewPresentor", package.seeall)

local WuDiClgExtFailViewPresentor = class("WuDiClgExtFailViewPresentor", ViewPresentor)

function WuDiClgExtFailViewPresentor:ctor()
	WuDiClgExtFailViewPresentor.super.ctor(self)
end

function WuDiClgExtFailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WuDiClgExtFailViewPresentor:dependWhatResources()
	return {
		"ui/views/wudiclg/wudiclgextfailview.prefab"
	}
end

function WuDiClgExtFailViewPresentor:buildViews()
	return {
		WuDiClgExtFailView.New()
	}
end

return WuDiClgExtFailViewPresentor
