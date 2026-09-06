-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/view/GodDarkDragonMainViewPresentor.lua

module("logic.extensions.goddarkdragon.view.GodDarkDragonMainViewPresentor", package.seeall)

local GodDarkDragonMainViewPresentor = class("GodDarkDragonMainViewPresentor", ViewPresentor)

function GodDarkDragonMainViewPresentor:ctor()
	GodDarkDragonMainViewPresentor.super.ctor(self)
end

function GodDarkDragonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDarkDragonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddarkdragon/goddarkdragonmainview.prefab"
	}
end

function GodDarkDragonMainViewPresentor:buildViews()
	return {
		GodDarkDragonMainView.New()
	}
end

return GodDarkDragonMainViewPresentor
