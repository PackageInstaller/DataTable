-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/view/LuckyDrawNewSkinRankViewPresentor.lua

module("logic.extensions.luckyskinlottery.view.LuckyDrawNewSkinRankViewPresentor", package.seeall)

local LuckyDrawNewSkinRankViewPresentor = class("LuckyDrawNewSkinRankViewPresentor", ViewPresentor)

function LuckyDrawNewSkinRankViewPresentor:ctor()
	LuckyDrawNewSkinRankViewPresentor.super.ctor(self)
end

function LuckyDrawNewSkinRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckyDrawNewSkinRankViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawnewskinrankview.prefab"
	}
end

function LuckyDrawNewSkinRankViewPresentor:buildViews()
	return {
		LuckyDrawNewSkinRankView.New()
	}
end

return LuckyDrawNewSkinRankViewPresentor
