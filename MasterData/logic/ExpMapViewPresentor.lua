-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpMapViewPresentor.lua

module("logic.extensions.expedition.view.ExpMapViewPresentor", package.seeall)

local ExpMapViewPresentor = class("ExpMapViewPresentor", ViewWithGuidePresentor)

function ExpMapViewPresentor:ctor()
	ExpMapViewPresentor.super.ctor(self)
end

function ExpMapViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExpMapViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/expmapview.prefab"
	}
end

function ExpMapViewPresentor:buildViews()
	return {
		ExpMapView.New(),
		ExpedLevelTargetsView.New()
	}
end

function ExpMapViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExpMapViewPresentor
