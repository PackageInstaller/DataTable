-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginagepintulistViewPresentor.lua

module("logic.extensions.originage.view.OriginagepintulistViewPresentor", package.seeall)

local OriginagepintulistViewPresentor = class("OriginagepintulistViewPresentor", ViewPresentor)

function OriginagepintulistViewPresentor:ctor()
	OriginagepintulistViewPresentor.super.ctor(self)
end

function OriginagepintulistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginagepintulistViewPresentor:dependWhatResources()
	return {
		"ui/views/originage/originagepintulistview.prefab"
	}
end

function OriginagepintulistViewPresentor:buildViews()
	return {
		OriginagepintulistView.New()
	}
end

return OriginagepintulistViewPresentor
