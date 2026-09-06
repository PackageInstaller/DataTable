-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/view/YishiChallengeFmtViewPresentor.lua

module("logic.extensions.yishichallenge.view.YishiChallengeFmtViewPresentor", package.seeall)

local YishiChallengeFmtViewPresentor = class("YishiChallengeFmtViewPresentor", ViewPresentor)

function YishiChallengeFmtViewPresentor:ctor()
	YishiChallengeFmtViewPresentor.super.ctor(self)
end

function YishiChallengeFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YishiChallengeFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/yishichallenge/yishichallengefmtview.prefab"
	}
end

function YishiChallengeFmtViewPresentor:buildViews()
	return {
		YishiChallengeFmtView.New()
	}
end

return YishiChallengeFmtViewPresentor
