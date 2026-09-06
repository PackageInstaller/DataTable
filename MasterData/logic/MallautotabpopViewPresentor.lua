-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/MallautotabpopViewPresentor.lua

module("logic.extensions.activitypopup.view.MallautotabpopViewPresentor", package.seeall)

local MallautotabpopViewPresentor = class("MallautotabpopViewPresentor", ViewPresentor)

function MallautotabpopViewPresentor:ctor()
	MallautotabpopViewPresentor.super.ctor(self)
end

function MallautotabpopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MallautotabpopViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/mallautotabpopview.prefab"
	}
end

function MallautotabpopViewPresentor:buildViews()
	return {
		MallautotabpopView.New()
	}
end

function MallautotabpopViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MallautotabpopViewPresentor
