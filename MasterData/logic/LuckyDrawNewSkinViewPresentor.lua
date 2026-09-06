-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/view/LuckyDrawNewSkinViewPresentor.lua

module("logic.extensions.luckyskinlottery.view.LuckyDrawNewSkinViewPresentor", package.seeall)

local LuckyDrawNewSkinViewPresentor = class("LuckyDrawNewSkinViewPresentor", ViewPresentor)

function LuckyDrawNewSkinViewPresentor:ctor()
	LuckyDrawNewSkinViewPresentor.super.ctor(self)
end

function LuckyDrawNewSkinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckyDrawNewSkinViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawnewskinview.prefab"
	}
end

function LuckyDrawNewSkinViewPresentor:buildViews()
	return {
		LuckyDrawNewSkinView.New()
	}
end

return LuckyDrawNewSkinViewPresentor
