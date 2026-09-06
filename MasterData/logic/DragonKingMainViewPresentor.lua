-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonKingMainViewPresentor.lua

module("logic.extensions.dragonking.view.DragonKingMainViewPresentor", package.seeall)

local DragonKingMainViewPresentor = class("DragonKingMainViewPresentor", ViewPresentor)

function DragonKingMainViewPresentor:ctor()
	DragonKingMainViewPresentor.super.ctor(self)
end

function DragonKingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonKingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonking/dragonkingmainview.prefab"
	}
end

function DragonKingMainViewPresentor:buildViews()
	return {
		DragonKingMainView.New()
	}
end

return DragonKingMainViewPresentor
