-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/view/MiyaChallengeWheelViewPresentor.lua

module("logic.extensions.miyachallenge.view.MiyaChallengeWheelViewPresentor", package.seeall)

local MiyaChallengeWheelViewPresentor = class("MiyaChallengeWheelViewPresentor", ViewPresentor)

function MiyaChallengeWheelViewPresentor:ctor()
	MiyaChallengeWheelViewPresentor.super.ctor(self)
end

function MiyaChallengeWheelViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MiyaChallengeWheelViewPresentor:dependWhatResources()
	return {
		"ui/views/miyachallenge/miyachallengewheelview.prefab"
	}
end

function MiyaChallengeWheelViewPresentor:buildViews()
	return {
		MiyaChallengeWheelView.New()
	}
end

function MiyaChallengeWheelViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MiyaChallengeWheelViewPresentor
