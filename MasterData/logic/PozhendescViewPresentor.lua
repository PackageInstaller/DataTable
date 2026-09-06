-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/PozhendescViewPresentor.lua

module("logic.extensions.breakformation.view.PozhendescViewPresentor", package.seeall)

local PozhendescViewPresentor = class("PozhendescViewPresentor", ViewPresentor)

function PozhendescViewPresentor:ctor()
	PozhendescViewPresentor.super.ctor(self)
end

function PozhendescViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PozhendescViewPresentor:dependWhatResources()
	return {
		"ui/views/breakformation/pozhendescview.prefab"
	}
end

function PozhendescViewPresentor:buildViews()
	return {
		PozhendescView.New()
	}
end

return PozhendescViewPresentor
