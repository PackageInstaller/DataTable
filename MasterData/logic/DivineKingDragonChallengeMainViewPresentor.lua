-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/view/DivineKingDragonChallengeMainViewPresentor.lua

module("logic.extensions.divinekingdragonchallenge.view.DivineKingDragonChallengeMainViewPresentor", package.seeall)

local DivineKingDragonChallengeMainViewPresentor = class("DivineKingDragonChallengeMainViewPresentor", ViewPresentor)

function DivineKingDragonChallengeMainViewPresentor:ctor()
	DivineKingDragonChallengeMainViewPresentor.super.ctor(self)
end

function DivineKingDragonChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingDragonChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingdragonchallenge/divinekingdragonchallengemainview.prefab"
	}
end

function DivineKingDragonChallengeMainViewPresentor:buildViews()
	return {
		DivineKingDragonChallengeMainView.New()
	}
end

return DivineKingDragonChallengeMainViewPresentor
