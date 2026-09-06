-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldMainViewPresentor.lua

module("logic.extensions.uniqueworld.view.UniqueWorldMainViewPresentor", package.seeall)

local UniqueWorldMainViewPresentor = class("UniqueWorldMainViewPresentor", ViewPresentor)

function UniqueWorldMainViewPresentor:ctor()
	UniqueWorldMainViewPresentor.super.ctor(self)
end

function UniqueWorldMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UniqueWorldMainViewPresentor:dependWhatResources()
	return {
		"ui/views/uniqueworld/uniqueworldmainview.prefab"
	}
end

function UniqueWorldMainViewPresentor:buildViews()
	return {
		UniqueWorldMainView.New()
	}
end

return UniqueWorldMainViewPresentor
