-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeBlockViewPresentor.lua

module("logic.extensions.qichallenge.view.QiChallengeBlockViewPresentor", package.seeall)

local QiChallengeBlockViewPresentor = class("QiChallengeBlockViewPresentor", ViewPresentor)

function QiChallengeBlockViewPresentor:ctor()
	QiChallengeBlockViewPresentor.super.ctor(self)
end

function QiChallengeBlockViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QiChallengeBlockViewPresentor:dependWhatResources()
	return {
		"ui/views/qichallenge/qichallengeblockview.prefab"
	}
end

function QiChallengeBlockViewPresentor:buildViews()
	return {
		QiChallengeBlockView.New()
	}
end

return QiChallengeBlockViewPresentor
