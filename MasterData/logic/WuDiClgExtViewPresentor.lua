-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgExtViewPresentor.lua

module("logic.extensions.wudiclg.view.WuDiClgExtViewPresentor", package.seeall)

local WuDiClgExtViewPresentor = class("WuDiClgExtViewPresentor", ViewPresentor)

function WuDiClgExtViewPresentor:ctor()
	WuDiClgExtViewPresentor.super.ctor(self)
end

function WuDiClgExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WuDiClgExtViewPresentor:dependWhatResources()
	return {
		"ui/views/wudiclg/wudiclgextview.prefab"
	}
end

function WuDiClgExtViewPresentor:buildViews()
	return {
		WuDiClgExtView.New()
	}
end

return WuDiClgExtViewPresentor
