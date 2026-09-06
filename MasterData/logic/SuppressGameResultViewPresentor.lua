-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/SuppressGameResultViewPresentor.lua

module("logic.extensions.suppressgame.view.SuppressGameResultViewPresentor", package.seeall)

local SuppressGameResultViewPresentor = class("SuppressGameResultViewPresentor", ViewPresentor)

function SuppressGameResultViewPresentor:ctor()
	SuppressGameResultViewPresentor.super.ctor(self)
end

function SuppressGameResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SuppressGameResultViewPresentor:dependWhatResources()
	return {
		"ui/views/suppressgame/suppressgameresultview.prefab"
	}
end

function SuppressGameResultViewPresentor:buildViews()
	return {
		SuppressGameResultView.New()
	}
end

return SuppressGameResultViewPresentor
