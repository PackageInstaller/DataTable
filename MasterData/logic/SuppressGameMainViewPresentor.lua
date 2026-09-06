-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/SuppressGameMainViewPresentor.lua

module("logic.extensions.suppressgame.view.SuppressGameMainViewPresentor", package.seeall)

local SuppressGameMainViewPresentor = class("SuppressGameMainViewPresentor", ViewPresentor)

function SuppressGameMainViewPresentor:ctor()
	SuppressGameMainViewPresentor.super.ctor(self)
end

function SuppressGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SuppressGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/suppressgame/suppressgamemainview.prefab"
	}
end

function SuppressGameMainViewPresentor:buildViews()
	return {
		SuppressGameMainView.New()
	}
end

return SuppressGameMainViewPresentor
