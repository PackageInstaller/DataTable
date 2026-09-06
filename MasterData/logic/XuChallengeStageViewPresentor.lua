-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/view/XuChallengeStageViewPresentor.lua

module("logic.extensions.xuchallenge.view.XuChallengeStageViewPresentor", package.seeall)

local XuChallengeStageViewPresentor = class("XuChallengeStageViewPresentor", ViewPresentor)

function XuChallengeStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XuChallengeStageViewPresentor:dependWhatResources()
	return {
		"ui/views/xuchallenge/xuchallengestageview.prefab"
	}
end

function XuChallengeStageViewPresentor:buildViews()
	return {
		XuChallengeStageView.New()
	}
end

return XuChallengeStageViewPresentor
