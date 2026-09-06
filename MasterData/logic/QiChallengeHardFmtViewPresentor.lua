-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeHardFmtViewPresentor.lua

module("logic.extensions.qichallenge.view.QiChallengeHardFmtViewPresentor", package.seeall)

local QiChallengeHardFmtViewPresentor = class("QiChallengeHardFmtViewPresentor", ViewPresentor)

function QiChallengeHardFmtViewPresentor:ctor()
	QiChallengeHardFmtViewPresentor.super.ctor(self)
end

function QiChallengeHardFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QiChallengeHardFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/qichallenge/qichallengefmtview.prefab"
	}
end

function QiChallengeHardFmtViewPresentor:buildViews()
	return {
		QiChallengeHardFmtView.New()
	}
end

return QiChallengeHardFmtViewPresentor
