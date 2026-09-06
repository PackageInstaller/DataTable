-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotrecall/view/PlotrecallPresentor.lua

module("logic.extensions.handbook.view.PlotrecallPresentor", package.seeall)

local PlotrecallPresentor = class("PlotrecallPresentor", ViewPresentor)

function PlotrecallPresentor:ctor()
	PlotrecallPresentor.super.ctor(self)
end

function PlotrecallPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlotrecallPresentor:dependWhatResources()
	return {
		"ui/views/plotrecall/plotrecallview.prefab"
	}
end

function PlotrecallPresentor:buildViews()
	return {
		PlotrecallView.New()
	}
end

return PlotrecallPresentor
