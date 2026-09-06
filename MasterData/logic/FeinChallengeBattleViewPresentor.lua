-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/FeinChallengeBattleViewPresentor.lua

module("logic.extensions.moonking.view.FeinChallengeBattleViewPresentor", package.seeall)

local FeinChallengeBattleViewPresentor = class("FeinChallengeBattleViewPresentor", ViewWithGuidePresentor)

function FeinChallengeBattleViewPresentor:ctor()
	FeinChallengeBattleViewPresentor.super.ctor(self)
end

function FeinChallengeBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FeinChallengeBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/moonking/feinchallengebattleview.prefab"
	}
end

function FeinChallengeBattleViewPresentor:buildViews()
	return {
		FeinChallengeBattleView.New()
	}
end

return FeinChallengeBattleViewPresentor
