-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/view/GodDarkDragonSelectViewPresentor.lua

module("logic.extensions.goddarkdragon.view.GodDarkDragonSelectViewPresentor", package.seeall)

local GodDarkDragonSelectViewPresentor = class("GodDarkDragonSelectViewPresentor", ViewPresentor)

function GodDarkDragonSelectViewPresentor:ctor()
	GodDarkDragonSelectViewPresentor.super.ctor(self)
end

function GodDarkDragonSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDarkDragonSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/goddarkdragon/goddarkdragonselectview.prefab"
	}
end

function GodDarkDragonSelectViewPresentor:buildViews()
	return {
		GodDarkDragonSelectView.New()
	}
end

return GodDarkDragonSelectViewPresentor
