-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/view/TabFrameWorkMainViewPresentor.lua

module("logic.extensions.tabframework.view.TabFrameWorkMainViewPresentor", package.seeall)

local TabFrameWorkMainViewPresentor = class("TabFrameWorkMainViewPresentor", ViewPresentor)

function TabFrameWorkMainViewPresentor:ctor()
	TabFrameWorkMainViewPresentor.super.ctor(self)
end

function TabFrameWorkMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabFrameWorkMainViewPresentor:dependWhatResources()
	return {
		"ui/views/tabframework/tabframeworkmainview.prefab"
	}
end

function TabFrameWorkMainViewPresentor:buildViews()
	return {
		TabFrameWorkMainView.New()
	}
end

return TabFrameWorkMainViewPresentor
