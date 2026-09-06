-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/PopulaceLegendViewPresentor.lua

module("logic.extensions.activitypopup.view.PopulaceLegendViewPresentor", package.seeall)

local PopulaceLegendViewPresentor = class("PopulaceLegendViewPresentor", ViewPresentor)

function PopulaceLegendViewPresentor:ctor()
	PopulaceLegendViewPresentor.super.ctor(self)
end

function PopulaceLegendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PopulaceLegendViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/populacelegendview.prefab"
	}
end

function PopulaceLegendViewPresentor:buildViews()
	return {
		PopulaceLegendView.New()
	}
end

return PopulaceLegendViewPresentor
