-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularityVersionLoginViewPresentor.lua

module("logic.extensions.popularitylist.view.PopularityVersionLoginViewPresentor", package.seeall)

local PopularityVersionLoginViewPresentor = class("PopularityVersionLoginViewPresentor", ViewPresentor)

function PopularityVersionLoginViewPresentor:ctor()
	PopularityVersionLoginViewPresentor.super.ctor(self)
end

function PopularityVersionLoginViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PopularityVersionLoginViewPresentor:dependWhatResources()
	return {
		"ui/views/popularitylist/popularityversionloginview.prefab"
	}
end

function PopularityVersionLoginViewPresentor:buildViews()
	return {
		PopularityVersionLoginView.New()
	}
end

return PopularityVersionLoginViewPresentor
