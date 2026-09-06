-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankverify/view/RankVerifyViewPresentor.lua

module("logic.extensions.rankverify.view.RankVerifyViewPresentor", package.seeall)

local RankVerifyViewPresentor = class("RankVerifyViewPresentor", ViewPresentor)

function RankVerifyViewPresentor:ctor()
	RankVerifyViewPresentor.super.ctor(self)
end

function RankVerifyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankVerifyViewPresentor:dependWhatResources()
	return {
		"ui/views/rankverify/rankverifyview.prefab"
	}
end

function RankVerifyViewPresentor:buildViews()
	return {
		RankVerifyView.New()
	}
end

return RankVerifyViewPresentor
