-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/view/GodDarkDragonResultViewPresentor.lua

module("logic.extensions.goddarkdragon.view.GodDarkDragonResultViewPresentor", package.seeall)

local GodDarkDragonResultViewPresentor = class("GodDarkDragonResultViewPresentor", ViewPresentor)

function GodDarkDragonResultViewPresentor:ctor()
	GodDarkDragonResultViewPresentor.super.ctor(self)
end

function GodDarkDragonResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDarkDragonResultViewPresentor:dependWhatResources()
	return {
		"ui/views/goddarkdragon/goddarkdragonresultview.prefab"
	}
end

function GodDarkDragonResultViewPresentor:buildViews()
	return {
		GodDarkDragonResultView.New()
	}
end

return GodDarkDragonResultViewPresentor
