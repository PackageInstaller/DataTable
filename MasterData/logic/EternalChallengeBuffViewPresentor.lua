-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/view/shop/EternalChallengeBuffViewPresentor.lua

module("logic.extensions.eternalchallenge.view.shop.EternalChallengeBuffViewPresentor", package.seeall)

local EternalChallengeBuffViewPresentor = class("EternalChallengeBuffViewPresentor", ViewPresentor)

function EternalChallengeBuffViewPresentor:ctor()
	EternalChallengeBuffViewPresentor.super.ctor(self)
end

function EternalChallengeBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalChallengeBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalchallenge/eternalchallengebuffview.prefab"
	}
end

function EternalChallengeBuffViewPresentor:buildViews()
	return {
		EternalChallengeBuffView.New()
	}
end

function EternalChallengeBuffViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EternalChallengeBuffViewPresentor
