-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/view/XuChallengeMainViewPresentor.lua

module("logic.extensions.xuchallenge.view.XuChallengeMainViewPresentor", package.seeall)

local XuChallengeMainViewPresentor = class("XuChallengeMainViewPresentor", ViewPresentor)

function XuChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XuChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/xuchallenge/xuchallengemainview.prefab"
	}
end

function XuChallengeMainViewPresentor:buildViews()
	return {
		XuChallengeMainView.New()
	}
end

return XuChallengeMainViewPresentor
