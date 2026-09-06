-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginagepintugameViewPresentor.lua

module("logic.extensions.originage.view.OriginagepintugameViewPresentor", package.seeall)

local OriginagepintugameViewPresentor = class("OriginagepintugameViewPresentor", ViewPresentor)

function OriginagepintugameViewPresentor:ctor()
	OriginagepintugameViewPresentor.super.ctor(self)
end

function OriginagepintugameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginagepintugameViewPresentor:dependWhatResources()
	return {
		"ui/views/originage/originagepintugameview.prefab"
	}
end

function OriginagepintugameViewPresentor:buildViews()
	return {
		OriginagepintugameView.New()
	}
end

return OriginagepintugameViewPresentor
