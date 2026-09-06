-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/view/LuckyDrawNewSkinLuckyRankViewPresentor.lua

module("logic.extensions.luckyskinlottery.view.LuckyDrawNewSkinLuckyRankViewPresentor", package.seeall)

local LuckyDrawNewSkinLuckyRankViewPresentor = class("LuckyDrawNewSkinLuckyRankViewPresentor", ViewPresentor)

function LuckyDrawNewSkinLuckyRankViewPresentor:ctor()
	LuckyDrawNewSkinLuckyRankViewPresentor.super.ctor(self)
end

function LuckyDrawNewSkinLuckyRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckyDrawNewSkinLuckyRankViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawnewskinluckyrankview.prefab"
	}
end

function LuckyDrawNewSkinLuckyRankViewPresentor:buildViews()
	return {
		LuckyDrawNewSkinLuckyRankView.New()
	}
end

return LuckyDrawNewSkinLuckyRankViewPresentor
