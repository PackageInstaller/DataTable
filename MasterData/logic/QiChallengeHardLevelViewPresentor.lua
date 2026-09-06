-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeHardLevelViewPresentor.lua

module("logic.extensions.qichallenge.view.QiChallengeHardLevelViewPresentor", package.seeall)

local QiChallengeHardLevelViewPresentor = class("QiChallengeHardLevelViewPresentor", ViewPresentor)

function QiChallengeHardLevelViewPresentor:ctor()
	QiChallengeHardLevelViewPresentor.super.ctor(self)
end

function QiChallengeHardLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QiChallengeHardLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/qichallenge/qichallengehardlevelview.prefab"
	}
end

function QiChallengeHardLevelViewPresentor:buildViews()
	return {
		QiChallengeHardLevelView.New()
	}
end

return QiChallengeHardLevelViewPresentor
