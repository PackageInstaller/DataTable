-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotmemories/view/PlotmemoriesViewPresentor.lua

module("logic.extensions.plotmemories.view.PlotmemoriesViewPresentor", package.seeall)

local PlotmemoriesViewPresentor = class("PlotmemoriesViewPresentor", ViewPresentor)

function PlotmemoriesViewPresentor:ctor()
	PlotmemoriesViewPresentor.super.ctor(self)
end

function PlotmemoriesViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlotmemoriesViewPresentor:dependWhatResources()
	return {
		"ui/views/plotmemories/plotmemoriesview.prefab"
	}
end

function PlotmemoriesViewPresentor:buildViews()
	return {
		PlotmemoriesView.New()
	}
end

return PlotmemoriesViewPresentor
