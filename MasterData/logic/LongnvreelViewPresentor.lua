-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longnv/LongnvreelViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.longnv.LongnvreelViewPresentor", package.seeall)

local LongnvreelViewPresentor = class("LongnvreelViewPresentor", ViewPresentor)

function LongnvreelViewPresentor:ctor()
	LongnvreelViewPresentor.super.ctor(self)
end

function LongnvreelViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LongnvreelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/longnv/longnvreelview.prefab"
	}
end

function LongnvreelViewPresentor:buildViews()
	return {
		LongnvreelView.New()
	}
end

return LongnvreelViewPresentor
