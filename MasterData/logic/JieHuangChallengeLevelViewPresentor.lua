-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiehuangchallenge/view/JieHuangChallengeLevelViewPresentor.lua

module("logic.extensions.jiehuangchallenge.view.JieHuangChallengeLevelViewPresentor", package.seeall)

local JieHuangChallengeLevelViewPresentor = class("JieHuangChallengeLevelViewPresentor", ViewPresentor)

function JieHuangChallengeLevelViewPresentor:ctor()
	JieHuangChallengeLevelViewPresentor.super.ctor(self)
end

function JieHuangChallengeLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieHuangChallengeLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/jiehuangchallenge/jiehuangchallengelevelview.prefab"
	}
end

function JieHuangChallengeLevelViewPresentor:buildViews()
	return {
		JieHuangChallengeLevelView.New()
	}
end

function JieHuangChallengeLevelViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return JieHuangChallengeLevelViewPresentor
