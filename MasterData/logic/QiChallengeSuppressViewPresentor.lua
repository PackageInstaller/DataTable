-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeSuppressViewPresentor.lua

module("logic.extensions.qichallenge.view.QiChallengeSuppressViewPresentor", package.seeall)

local QiChallengeSuppressViewPresentor = class("QiChallengeSuppressViewPresentor", ViewPresentor)

function QiChallengeSuppressViewPresentor:ctor()
	QiChallengeSuppressViewPresentor.super.ctor(self)
end

function QiChallengeSuppressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QiChallengeSuppressViewPresentor:dependWhatResources()
	return {
		"ui/views/qichallenge/qichallengesuppressview.prefab"
	}
end

function QiChallengeSuppressViewPresentor:buildViews()
	return {
		QiChallengeSuppressView.New()
	}
end

return QiChallengeSuppressViewPresentor
