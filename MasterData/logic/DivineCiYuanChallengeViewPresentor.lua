-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanChallengeViewPresentor.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanChallengeViewPresentor", package.seeall)

local DivineCiYuanChallengeViewPresentor = class("DivineCiYuanChallengeViewPresentor", ViewPresentor)

function DivineCiYuanChallengeViewPresentor:ctor()
	DivineCiYuanChallengeViewPresentor.super.ctor(self)
end

function DivineCiYuanChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineCiYuanChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divineciyuan/divineciyuanchallengeview.prefab"
	}
end

function DivineCiYuanChallengeViewPresentor:buildViews()
	return {
		DivineCiYuanChallengeView.New()
	}
end

return DivineCiYuanChallengeViewPresentor
