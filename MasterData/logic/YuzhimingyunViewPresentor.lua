-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/view/YuzhimingyunViewPresentor.lua

module("logic.extensions.planetarium.view.YuzhimingyunViewPresentor", package.seeall)

local YuzhimingyunViewPresentor = class("YuzhimingyunViewPresentor", ViewPresentor)

function YuzhimingyunViewPresentor:ctor()
	YuzhimingyunViewPresentor.super.ctor(self)
end

function YuzhimingyunViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YuzhimingyunViewPresentor:dependWhatResources()
	return {
		"ui/views/planetarium/yuzhimingyunview.prefab"
	}
end

function YuzhimingyunViewPresentor:buildViews()
	return {
		YuzhimingyunView.New()
	}
end

return YuzhimingyunViewPresentor
