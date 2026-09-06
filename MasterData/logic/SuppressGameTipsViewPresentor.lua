-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/SuppressGameTipsViewPresentor.lua

module("logic.extensions.suppressgame.view.SuppressGameTipsViewPresentor", package.seeall)

local SuppressGameTipsViewPresentor = class("SuppressGameTipsViewPresentor", ViewPresentor)

function SuppressGameTipsViewPresentor:ctor()
	SuppressGameTipsViewPresentor.super.ctor(self)
end

function SuppressGameTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SuppressGameTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/suppressgame/suppressgametipsview.prefab"
	}
end

function SuppressGameTipsViewPresentor:buildViews()
	return {
		SuppressGameTipsView.New()
	}
end

return SuppressGameTipsViewPresentor
