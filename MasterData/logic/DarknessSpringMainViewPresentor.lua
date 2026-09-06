-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darknessspring/view/DarknessSpringMainViewPresentor.lua

module("logic.extensions.darknessspring.view.DarknessSpringMainViewPresentor", package.seeall)

local DarknessSpringMainViewPresentor = class("DarknessSpringMainViewPresentor", ViewPresentor)

function DarknessSpringMainViewPresentor:ctor()
	DarknessSpringMainViewPresentor.super.ctor(self)
end

function DarknessSpringMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarknessSpringMainViewPresentor:dependWhatResources()
	return {
		"ui/views/darknessspring/darknessspringmainview.prefab"
	}
end

function DarknessSpringMainViewPresentor:buildViews()
	return {
		DarknessSpringMainView.New()
	}
end

return DarknessSpringMainViewPresentor
