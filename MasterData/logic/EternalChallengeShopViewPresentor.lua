-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/view/shop/EternalChallengeShopViewPresentor.lua

module("logic.extensions.eternalchallenge.view.shop.EternalChallengeShopViewPresentor", package.seeall)

local EternalChallengeShopViewPresentor = class("EternalChallengeShopViewPresentor", ViewPresentor)

function EternalChallengeShopViewPresentor:ctor()
	EternalChallengeShopViewPresentor.super.ctor(self)
end

function EternalChallengeShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalChallengeShopViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalchallenge/eternalchallengeshopview.prefab"
	}
end

function EternalChallengeShopViewPresentor:buildViews()
	return {
		EternalChallengeShopView.New()
	}
end

return EternalChallengeShopViewPresentor
