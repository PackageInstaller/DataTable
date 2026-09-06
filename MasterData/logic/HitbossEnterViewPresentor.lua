-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/view/HitbossEnterViewPresentor.lua

module("logic.extensions.hitboss.view.HitbossEnterViewPresentor", package.seeall)

local HitbossEnterViewPresentor = class("HitbossEnterViewPresentor", ViewPresentor)

function HitbossEnterViewPresentor:ctor()
	HitbossEnterViewPresentor.super.ctor(self)
end

function HitbossEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HitbossEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/hitboss/hitbossenterview.prefab"
	}
end

function HitbossEnterViewPresentor:buildViews()
	return {
		HitbossEnterView.New()
	}
end

return HitbossEnterViewPresentor
