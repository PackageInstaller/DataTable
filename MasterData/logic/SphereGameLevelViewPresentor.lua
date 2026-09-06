-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/spheregame/SphereGameLevelViewPresentor.lua

module("logic.extensions.anniversarycake.view.spheregame.SphereGameLevelViewPresentor", package.seeall)

local SphereGameLevelViewPresentor = class("SphereGameLevelViewPresentor", ViewPresentor)

function SphereGameLevelViewPresentor:ctor()
	SphereGameLevelViewPresentor.super.ctor(self)
end

function SphereGameLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SphereGameLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarycake/spheregamelevelview.prefab"
	}
end

function SphereGameLevelViewPresentor:buildViews()
	return {
		SphereGameLevelView.New()
	}
end

return SphereGameLevelViewPresentor
