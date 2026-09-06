-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularitypainterViewPresentor.lua

module("logic.extensions.popularitylist.view.PopularitypainterViewPresentor", package.seeall)

local PopularitypainterViewPresentor = class("PopularitypainterViewPresentor", ViewPresentor)

function PopularitypainterViewPresentor:ctor()
	PopularitypainterViewPresentor.super.ctor(self)
end

function PopularitypainterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PopularitypainterViewPresentor:dependWhatResources()
	return {
		"ui/views/popularitylist/popularitypainterview.prefab"
	}
end

function PopularitypainterViewPresentor:buildViews()
	return {
		PopularityPainterView.New()
	}
end

return PopularitypainterViewPresentor
