-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/view/GodDarkDragonLevelViewPresentor.lua

module("logic.extensions.goddarkdragon.view.GodDarkDragonLevelViewPresentor", package.seeall)

local GodDarkDragonLevelViewPresentor = class("GodDarkDragonLevelViewPresentor", ViewWithGuidePresentor)

function GodDarkDragonLevelViewPresentor:ctor()
	GodDarkDragonLevelViewPresentor.super.ctor(self)
end

function GodDarkDragonLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDarkDragonLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/goddarkdragon/goddarkdragonlevelview.prefab"
	}
end

function GodDarkDragonLevelViewPresentor:buildViews()
	return {
		GodDarkDragonLevelView.New()
	}
end

return GodDarkDragonLevelViewPresentor
