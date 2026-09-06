-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/view/HitbossmainViewPresentor.lua

module("logic.extensions.hitboss.view.HitbossmainViewPresentor", package.seeall)

local HitbossmainViewPresentor = class("HitbossmainViewPresentor", ViewPresentor)

function HitbossmainViewPresentor:ctor()
	HitbossmainViewPresentor.super.ctor(self)
end

function HitbossmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HitbossmainViewPresentor:dependWhatResources()
	return {
		"ui/views/hitboss/hitbossmainview.prefab"
	}
end

function HitbossmainViewPresentor:buildViews()
	return {
		HitbossmainView.New()
	}
end

return HitbossmainViewPresentor
