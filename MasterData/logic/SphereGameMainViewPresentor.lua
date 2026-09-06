-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/spheregame/SphereGameMainViewPresentor.lua

module("logic.extensions.anniversarycake.view.spheregame.SphereGameMainViewPresentor", package.seeall)

local SphereGameMainViewPresentor = class("SphereGameMainViewPresentor", ViewWithGuidePresentor)

function SphereGameMainViewPresentor:ctor()
	SphereGameMainViewPresentor.super.ctor(self)
end

function SphereGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SphereGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarycake/spheregamemainview.prefab"
	}
end

function SphereGameMainViewPresentor:buildViews()
	return {
		SphereGameMainView.New()
	}
end

return SphereGameMainViewPresentor
