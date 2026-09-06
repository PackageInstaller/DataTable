-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeMainViewPresentor.lua

module("logic.extensions.qichallenge.view.QiChallengeMainViewPresentor", package.seeall)

local QiChallengeMainViewPresentor = class("QiChallengeMainViewPresentor", ViewPresentor)

function QiChallengeMainViewPresentor:ctor()
	QiChallengeMainViewPresentor.super.ctor(self)
end

function QiChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function QiChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/qichallenge/qichallengemainview.prefab"
	}
end

function QiChallengeMainViewPresentor:buildViews()
	return {
		QiChallengeMainView.New()
	}
end

return QiChallengeMainViewPresentor
