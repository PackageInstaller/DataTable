-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeDailyLevelViewPresentor.lua

module("logic.extensions.qichallenge.view.QiChallengeDailyLevelViewPresentor", package.seeall)

local QiChallengeDailyLevelViewPresentor = class("QiChallengeDailyLevelViewPresentor", ViewPresentor)

function QiChallengeDailyLevelViewPresentor:ctor()
	QiChallengeDailyLevelViewPresentor.super.ctor(self)
end

function QiChallengeDailyLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QiChallengeDailyLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/qichallenge/qichallengedailylevelview.prefab"
	}
end

function QiChallengeDailyLevelViewPresentor:buildViews()
	return {
		QiChallengeDailyLevelView.New()
	}
end

return QiChallengeDailyLevelViewPresentor
