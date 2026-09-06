-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginageshareViewPresentor.lua

module("logic.extensions.originage.view.OriginageshareViewPresentor", package.seeall)

local OriginageshareViewPresentor = class("OriginageshareViewPresentor", ViewPresentor)

function OriginageshareViewPresentor:ctor()
	OriginageshareViewPresentor.super.ctor(self)
end

function OriginageshareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginageshareViewPresentor:dependWhatResources()
	return {
		"ui/views/originage/originageshareview.prefab"
	}
end

function OriginageshareViewPresentor:buildViews()
	return {
		OriginageshareView.New()
	}
end

return OriginageshareViewPresentor
