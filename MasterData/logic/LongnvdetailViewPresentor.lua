-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnvdetailViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnvdetailViewPresentor", package.seeall)

local LongnvdetailViewPresentor = class("LongnvdetailViewPresentor", ViewPresentor)

function LongnvdetailViewPresentor:ctor()
	LongnvdetailViewPresentor.super.ctor(self)
end

function LongnvdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LongnvdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longnv/longnvdetailview.prefab"
	}
end

function LongnvdetailViewPresentor:buildViews()
	return {
		LongnvdetailView.New()
	}
end

return LongnvdetailViewPresentor
