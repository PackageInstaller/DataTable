-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/game/SKTgameViewPresentor.lua

module("logic.extensions.fbbchallenge.view.game.SKTgameViewPresentor", package.seeall)

local SKTgameViewPresentor = class("SKTgameViewPresentor", ViewPresentor)

SKTgameViewPresentor.FBBCharacterPath = "character/10142_xiaotian/10142_xiaotian-ui_p.prefab"

function SKTgameViewPresentor:ctor()
	SKTgameViewPresentor.super.ctor(self)
end

function SKTgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SKTgameViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttian/sktgameview.prefab",
		SKTgameViewPresentor.FBBCharacterPath,
		SKTgameViewPresentor.WYCharacterPath
	}
end

function SKTgameViewPresentor:buildViews()
	return {
		SKTgameView.New()
	}
end

return SKTgameViewPresentor
