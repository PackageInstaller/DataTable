-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/view/DivineKingShiKongLongZunChallengeViewPresentor.lua

module("logic.extensions.divinekingshikongllongzun.view.DivineKingShiKongLongZunChallengeViewPresentor", package.seeall)

local DivineKingShiKongLongZunChallengeViewPresentor = class("DivineKingShiKongLongZunChallengeViewPresentor", ViewPresentor)

function DivineKingShiKongLongZunChallengeViewPresentor:ctor()
	DivineKingShiKongLongZunChallengeViewPresentor.super.ctor(self)
end

function DivineKingShiKongLongZunChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingShiKongLongZunChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingshikongllongzun/divinekingshikonglongzunchallengeview.prefab"
	}
end

function DivineKingShiKongLongZunChallengeViewPresentor:buildViews()
	return {
		DivineKingShiKongLongZunChallengeView.New()
	}
end

return DivineKingShiKongLongZunChallengeViewPresentor
