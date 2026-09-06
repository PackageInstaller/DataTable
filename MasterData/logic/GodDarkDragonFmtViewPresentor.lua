-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/view/GodDarkDragonFmtViewPresentor.lua

module("logic.extensions.goddarkdragon.view.GodDarkDragonFmtViewPresentor", package.seeall)

local GodDarkDragonFmtViewPresentor = class("GodDarkDragonFmtViewPresentor", ViewPresentor)

function GodDarkDragonFmtViewPresentor:ctor()
	GodDarkDragonFmtViewPresentor.super.ctor(self)
end

function GodDarkDragonFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDarkDragonFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/goddarkdragon/goddarkdragonfmtview.prefab"
	}
end

function GodDarkDragonFmtViewPresentor:buildViews()
	return {
		GodDarkDragonFmtView.New()
	}
end

return GodDarkDragonFmtViewPresentor
