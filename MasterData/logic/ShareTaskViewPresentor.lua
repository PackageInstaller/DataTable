-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareTaskViewPresentor.lua

module("logic.extensions.sharetask.view.ShareTaskViewPresentor", package.seeall)

local ShareTaskViewPresentor = class("ShareTaskViewPresentor", ViewPresentor)

function ShareTaskViewPresentor:ctor()
	ShareTaskViewPresentor.super.ctor(self)
end

function ShareTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShareTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/sharetask/sharetaskview.prefab"
	}
end

function ShareTaskViewPresentor:buildViews()
	return {
		ShareTaskView.New()
	}
end

return ShareTaskViewPresentor
