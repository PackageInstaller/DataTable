-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplusfilterViewPresentor.lua

module("logic.extensions.stargodplus.view.StargodplusfilterViewPresentor", package.seeall)

local StargodplusfilterViewPresentor = class("StargodplusfilterViewPresentor", ViewPresentor)

function StargodplusfilterViewPresentor:ctor()
	StargodplusfilterViewPresentor.super.ctor(self)
end

function StargodplusfilterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StargodplusfilterViewPresentor:dependWhatResources()
	return {
		"ui/views/stargodplus/stargodplusfilterview.prefab"
	}
end

function StargodplusfilterViewPresentor:buildViews()
	return {
		StargodplusfilterView.New()
	}
end

function StargodplusfilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StargodplusfilterViewPresentor
