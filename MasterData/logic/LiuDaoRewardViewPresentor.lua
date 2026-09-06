-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/view/LiuDaoRewardViewPresentor.lua

module("logic.extensions.liudao.view.LiuDaoRewardViewPresentor", package.seeall)

local LiuDaoRewardViewPresentor = class("LiuDaoRewardViewPresentor", ViewPresentor)

function LiuDaoRewardViewPresentor:ctor()
	LiuDaoRewardViewPresentor.super.ctor(self)
end

function LiuDaoRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LiuDaoRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/liudao/liudaorewardview.prefab"
	}
end

function LiuDaoRewardViewPresentor:buildViews()
	return {
		LiuDaoRewardView.New()
	}
end

return LiuDaoRewardViewPresentor
