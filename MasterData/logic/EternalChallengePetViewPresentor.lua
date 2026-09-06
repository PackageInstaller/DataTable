-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/view/shop/EternalChallengePetViewPresentor.lua

module("logic.extensions.eternalchallenge.view.shop.EternalChallengePetViewPresentor", package.seeall)

local EternalChallengePetViewPresentor = class("EternalChallengePetViewPresentor", ViewPresentor)

function EternalChallengePetViewPresentor:ctor()
	EternalChallengePetViewPresentor.super.ctor(self)
end

function EternalChallengePetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalChallengePetViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalchallenge/eternalchallengepetview.prefab"
	}
end

function EternalChallengePetViewPresentor:buildViews()
	return {
		EternalChallengePetView.New()
	}
end

function EternalChallengePetViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EternalChallengePetViewPresentor
