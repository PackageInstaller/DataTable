-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/youlie/YoulieDetailViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.youlie.YoulieDetailViewPresentor", package.seeall)

local YoulieDetailViewPresentor = class("YoulieDetailViewPresentor", ViewPresentor)

function YoulieDetailViewPresentor:ctor()
	YoulieDetailViewPresentor.super.ctor(self)
end

function YoulieDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function YoulieDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/youlie/youliedetailview.prefab"
	}
end

function YoulieDetailViewPresentor:buildViews()
	return {
		YoulieDetailView.New()
	}
end

return YoulieDetailViewPresentor
