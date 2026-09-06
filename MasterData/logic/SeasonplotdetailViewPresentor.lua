-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonplotdetailViewPresentor.lua

module("logic.extensions.season.view.SeasonplotdetailViewPresentor", package.seeall)

local SeasonplotdetailViewPresentor = class("SeasonplotdetailViewPresentor", ViewPresentor)

function SeasonplotdetailViewPresentor:ctor()
	SeasonplotdetailViewPresentor.super.ctor(self)
end

function SeasonplotdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonplotdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonplotdetailview.prefab"
	}
end

function SeasonplotdetailViewPresentor:buildViews()
	return {
		SeasonPlotDetailView.New()
	}
end

return SeasonplotdetailViewPresentor
