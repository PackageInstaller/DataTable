-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/view/HitbossrankViewPresentor.lua

module("logic.extensions.hitboss.view.HitbossrankViewPresentor", package.seeall)

local HitbossrankViewPresentor = class("HitbossrankViewPresentor", ViewPresentor)

function HitbossrankViewPresentor:ctor()
	HitbossrankViewPresentor.super.ctor(self)
end

function HitbossrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HitbossrankViewPresentor:dependWhatResources()
	return {
		"ui/views/hitboss/hitbossrankview.prefab"
	}
end

function HitbossrankViewPresentor:buildViews()
	return {
		HitbossrankView.New()
	}
end

return HitbossrankViewPresentor
