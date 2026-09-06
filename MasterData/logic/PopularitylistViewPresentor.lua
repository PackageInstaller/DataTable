-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularitylistViewPresentor.lua

module("logic.extensions.popularitylist.view.PopularitylistViewPresentor", package.seeall)

local PopularitylistViewPresentor = class("PopularitylistViewPresentor", ViewPresentor)

function PopularitylistViewPresentor:ctor()
	PopularitylistViewPresentor.super.ctor(self)
end

function PopularitylistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PopularitylistViewPresentor:dependWhatResources()
	return {
		"ui/views/popularitylist/popularitylistview.prefab"
	}
end

function PopularitylistViewPresentor:buildViews()
	return {
		PopularityListView.New()
	}
end

return PopularitylistViewPresentor
