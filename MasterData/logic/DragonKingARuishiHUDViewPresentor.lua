-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishihud/view/DragonKingARuishiHUDViewPresentor.lua

module("logic.extensions.dragonkingaruishihud.view.DragonKingARuishiHUDViewPresentor", package.seeall)

local DragonKingARuishiHUDViewPresentor = class("DragonKingARuishiHUDViewPresentor", ViewPresentor)

function DragonKingARuishiHUDViewPresentor:ctor()
	DragonKingARuishiHUDViewPresentor.super.ctor(self)
end

function DragonKingARuishiHUDViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonKingARuishiHUDViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonkingaruishihud/dragonkingaruishihudview.prefab"
	}
end

function DragonKingARuishiHUDViewPresentor:buildViews()
	return {
		DragonKingARuishiHUDView.New()
	}
end

return DragonKingARuishiHUDViewPresentor
