-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/game/FbbgameViewPresentor.lua

module("logic.extensions.fbbchallenge.view.game.FbbgameViewPresentor", package.seeall)

local FbbgameViewPresentor = class("FbbgameViewPresentor", ViewPresentor)

FbbgameViewPresentor.FBBCharacterPath = "character/fengbaobao_xiaoren/fengbaobao_xiaoren-ui_p.prefab"

function FbbgameViewPresentor:ctor()
	FbbgameViewPresentor.super.ctor(self)
end

function FbbgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FbbgameViewPresentor:dependWhatResources()
	return {
		"ui/views/fbbchallenge/fbbgameview.prefab",
		FbbgameViewPresentor.FBBCharacterPath,
		FbbgameViewPresentor.WYCharacterPath
	}
end

function FbbgameViewPresentor:buildViews()
	return {
		FbbgameView.New()
	}
end

return FbbgameViewPresentor
