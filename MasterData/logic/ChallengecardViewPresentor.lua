-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/ChallengecardViewPresentor.lua

module("logic.extensions.monthcard.view.ChallengecardViewPresentor", package.seeall)

local ChallengecardViewPresentor = class("ChallengecardViewPresentor", ViewPresentor)

function ChallengecardViewPresentor:ctor()
	ChallengecardViewPresentor.super.ctor(self)
end

function ChallengecardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChallengecardViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/challengecardview.prefab"
	}
end

function ChallengecardViewPresentor:buildViews()
	return {
		ChallengecardView.New()
	}
end

function ChallengecardViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ChallengecardViewPresentor
