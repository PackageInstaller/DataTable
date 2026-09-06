-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/view/YuHuiChallengeMainViewPresentor.lua

module("logic.extensions.yuhuichallenge.view.YuHuiChallengeMainViewPresentor", package.seeall)

local YuHuiChallengeMainViewPresentor = class("YuHuiChallengeMainViewPresentor", ViewPresentor)

function YuHuiChallengeMainViewPresentor:ctor()
	YuHuiChallengeMainViewPresentor.super.ctor(self)
end

function YuHuiChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YuHuiChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/yuhuichallenge/yuhuichallengemainview.prefab"
	}
end

function YuHuiChallengeMainViewPresentor:buildViews()
	return {
		YuHuiChallengeMainView.New()
	}
end

return YuHuiChallengeMainViewPresentor
