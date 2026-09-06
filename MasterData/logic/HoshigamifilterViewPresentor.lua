-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamifilterViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamifilterViewPresentor", package.seeall)

local HoshigamifilterViewPresentor = class("HoshigamifilterViewPresentor", ViewPresentor)

function HoshigamifilterViewPresentor:ctor()
	HoshigamifilterViewPresentor.super.ctor(self)
end

function HoshigamifilterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HoshigamifilterViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamifilter.prefab"
	}
end

function HoshigamifilterViewPresentor:buildViews()
	return {
		HoshigamifilterView.New()
	}
end

function HoshigamifilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HoshigamifilterViewPresentor
