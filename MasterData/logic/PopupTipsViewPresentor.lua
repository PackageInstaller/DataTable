-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/elizabeth/PopupTipsViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.elizabeth.PopupTipsViewPresentor", package.seeall)

local PopupTipsViewPresentor = class("PopupTipsViewPresentor", ViewPresentor)

function PopupTipsViewPresentor:ctor()
	PopupTipsViewPresentor.super.ctor(self)
end

function PopupTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PopupTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/elizabeth/popuptipsview.prefab"
	}
end

function PopupTipsViewPresentor:buildViews()
	return {
		PopupTipsView.New()
	}
end

return PopupTipsViewPresentor
