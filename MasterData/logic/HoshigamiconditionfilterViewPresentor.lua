-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiconditionfilterViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamiconditionfilterViewPresentor", package.seeall)

local HoshigamiconditionfilterViewPresentor = class("HoshigamiconditionfilterViewPresentor", ViewPresentor)

function HoshigamiconditionfilterViewPresentor:ctor()
	HoshigamiconditionfilterViewPresentor.super.ctor(self)
end

function HoshigamiconditionfilterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HoshigamiconditionfilterViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamiconditionfilterview.prefab"
	}
end

function HoshigamiconditionfilterViewPresentor:buildViews()
	return {
		HoshigamiconditionfilterView.New()
	}
end

return HoshigamiconditionfilterViewPresentor
