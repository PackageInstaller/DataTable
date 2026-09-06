-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamireplaceViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamireplaceViewPresentor", package.seeall)

local HoshigamireplaceViewPresentor = class("HoshigamireplaceViewPresentor", ViewPresentor)

function HoshigamireplaceViewPresentor:ctor()
	HoshigamireplaceViewPresentor.super.ctor(self)
end

function HoshigamireplaceViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HoshigamireplaceViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamireplaceview.prefab"
	}
end

function HoshigamireplaceViewPresentor:buildViews()
	return {
		HoshigamireplaceView.New()
	}
end

return HoshigamireplaceViewPresentor
