-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityChallengeViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityChallengeViewPresentor", package.seeall)

local GuardCityChallengeViewPresentor = class("GuardCityChallengeViewPresentor", ViewPresentor)

function GuardCityChallengeViewPresentor:ctor()
	GuardCityChallengeViewPresentor.super.ctor(self)
end

function GuardCityChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GuardCityChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcitychallengeview.prefab"
	}
end

function GuardCityChallengeViewPresentor:buildViews()
	return {
		GuardCityChallengeView.New()
	}
end

function GuardCityChallengeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function GuardCityChallengeViewPresentor:onClickOutside()
	self:close()
end

return GuardCityChallengeViewPresentor
