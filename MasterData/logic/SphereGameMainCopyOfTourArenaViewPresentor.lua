-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/sphere/SphereGameMainCopyOfTourArenaViewPresentor.lua

module("logic.extensions.tourarena.view.copy.sphere.SphereGameMainCopyOfTourArenaViewPresentor", package.seeall)

local SphereGameMainCopyOfTourArenaViewPresentor = class("SphereGameMainCopyOfTourArenaViewPresentor", ViewWithGuidePresentor)

function SphereGameMainCopyOfTourArenaViewPresentor:ctor()
	SphereGameMainCopyOfTourArenaViewPresentor.super.ctor(self)
end

function SphereGameMainCopyOfTourArenaViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SphereGameMainCopyOfTourArenaViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/game/spheregamemaincopyoftourarenaview.prefab"
	}
end

function SphereGameMainCopyOfTourArenaViewPresentor:buildViews()
	return {
		SphereGameMainCopyOfTourArenaView.New()
	}
end

return SphereGameMainCopyOfTourArenaViewPresentor
