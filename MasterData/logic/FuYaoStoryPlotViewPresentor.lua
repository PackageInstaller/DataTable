-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyaostory/view/FuYaoStoryPlotViewPresentor.lua

module("logic.extensions.fuyaostory.view.FuYaoStoryPlotViewPresentor", package.seeall)

local FuYaoStoryPlotViewPresentor = class("FuYaoStoryPlotViewPresentor", ViewPresentor)

function FuYaoStoryPlotViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuYaoStoryPlotViewPresentor:dependWhatResources()
	return {
		"ui/views/fuyaostory/fuyaostoryplotview.prefab"
	}
end

function FuYaoStoryPlotViewPresentor:buildViews()
	return {
		FuYaoStoryPlotView.New()
	}
end

return FuYaoStoryPlotViewPresentor
