-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengePosViewPresentor.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengePosViewPresentor", package.seeall)

local FanRuiChallengePosViewPresentor = class("FanRuiChallengePosViewPresentor", ViewPresentor)

function FanRuiChallengePosViewPresentor:ctor()
	FanRuiChallengePosViewPresentor.super.ctor(self)
end

function FanRuiChallengePosViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FanRuiChallengePosViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruichallenge/fanruichallengeposview.prefab"
	}
end

function FanRuiChallengePosViewPresentor:buildViews()
	return {
		FanRuiChallengePosView.New()
	}
end

function FanRuiChallengePosViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyWaterOrderBuffViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return FanRuiChallengePosViewPresentor
