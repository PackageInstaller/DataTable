-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiehuangchallenge/view/JieHuangChallengeMainViewPresentor.lua

module("logic.extensions.jiehuangchallenge.view.JieHuangChallengeMainViewPresentor", package.seeall)

local JieHuangChallengeMainViewPresentor = class("JieHuangChallengeMainViewPresentor", ViewPresentor)

function JieHuangChallengeMainViewPresentor:ctor()
	JieHuangChallengeMainViewPresentor.super.ctor(self)
end

function JieHuangChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieHuangChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/jiehuangchallenge/jiehuangchallengemainview.prefab"
	}
end

function JieHuangChallengeMainViewPresentor:buildViews()
	return {
		JieHuangChallengeMainView.New()
	}
end

function JieHuangChallengeMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return JieHuangChallengeMainViewPresentor
