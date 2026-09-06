-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotmemories/view/PlotmainViewPresentor.lua

module("logic.extensions.plotmemories.view.PlotmainViewPresentor", package.seeall)

local PlotmainViewPresentor = class("PlotmainViewPresentor", ViewPresentor)

function PlotmainViewPresentor:ctor()
	PlotmainViewPresentor.super.ctor(self)
end

function PlotmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlotmainViewPresentor:dependWhatResources()
	return {
		"ui/views/plotmemories/plotmainview.prefab"
	}
end

function PlotmainViewPresentor:buildViews()
	return {
		PlotmainView.New()
	}
end

return PlotmainViewPresentor
