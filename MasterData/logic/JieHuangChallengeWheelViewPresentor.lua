-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiehuangchallenge/view/JieHuangChallengeWheelViewPresentor.lua

module("logic.extensions.jiehuangchallenge.view.JieHuangChallengeWheelViewPresentor", package.seeall)

local JieHuangChallengeWheelViewPresentor = class("JieHuangChallengeWheelViewPresentor", ViewPresentor)

function JieHuangChallengeWheelViewPresentor:ctor()
	JieHuangChallengeWheelViewPresentor.super.ctor(self)
end

function JieHuangChallengeWheelViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JieHuangChallengeWheelViewPresentor:dependWhatResources()
	return {
		"ui/views/jiehuangchallenge/jiehuangchallengewheelview.prefab"
	}
end

function JieHuangChallengeWheelViewPresentor:buildViews()
	return {
		JieHuangChallengeWheelView.New()
	}
end

function JieHuangChallengeWheelViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return JieHuangChallengeWheelViewPresentor
