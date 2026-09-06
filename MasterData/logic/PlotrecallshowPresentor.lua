-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotrecall/view/PlotrecallshowPresentor.lua

module("logic.extensions.plotcopy.view.PlotrecallshowPresentor", package.seeall)

local PlotrecallshowPresentor = class("PlotrecallshowPresentor", ViewPresentor)

function PlotrecallshowPresentor:ctor()
	PlotrecallshowPresentor.super.ctor(self)
end

function PlotrecallshowPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlotrecallshowPresentor:dependWhatResources()
	return {
		"ui/views/plotrecall/plotrecallshowview.prefab"
	}
end

function PlotrecallshowPresentor:buildViews()
	return {
		PlotrecallshowView.New()
	}
end

return PlotrecallshowPresentor
