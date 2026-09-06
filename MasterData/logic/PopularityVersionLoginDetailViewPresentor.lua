-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularityVersionLoginDetailViewPresentor.lua

module("logic.extensions.popularitylist.view.PopularityVersionLoginDetailViewPresentor", package.seeall)

local PopularityVersionLoginDetailViewPresentor = class("PopularityVersionLoginDetailViewPresentor", ViewPresentor)

function PopularityVersionLoginDetailViewPresentor:ctor()
	PopularityVersionLoginDetailViewPresentor.super.ctor(self)
end

function PopularityVersionLoginDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PopularityVersionLoginDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/popularitylist/popularityversionlogindetailview.prefab"
	}
end

function PopularityVersionLoginDetailViewPresentor:buildViews()
	return {
		PopularityVersionLoginDetailView.New()
	}
end

return PopularityVersionLoginDetailViewPresentor
