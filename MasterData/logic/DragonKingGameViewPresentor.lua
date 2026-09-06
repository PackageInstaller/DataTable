-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonKingGameViewPresentor.lua

module("logic.extensions.dragonking.view.DragonKingGameViewPresentor", package.seeall)

local DragonKingGameViewPresentor = class("DragonKingGameViewPresentor", ViewPresentor)

function DragonKingGameViewPresentor:ctor()
	DragonKingGameViewPresentor.super.ctor(self)
end

function DragonKingGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonKingGameViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonking/dragonkinggameview.prefab"
	}
end

function DragonKingGameViewPresentor:buildViews()
	return {
		DragonKingGameView.New()
	}
end

return DragonKingGameViewPresentor
