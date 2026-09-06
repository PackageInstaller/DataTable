-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/SummerlotterybuyViewPresentor.lua

module("logic.extensions.summerlottery.view.SummerlotterybuyViewPresentor", package.seeall)

local SummerlotterybuyViewPresentor = class("SummerlotterybuyViewPresentor", ViewPresentor)

function SummerlotterybuyViewPresentor:ctor()
	SummerlotterybuyViewPresentor.super.ctor(self)
end

function SummerlotterybuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerlotterybuyViewPresentor:dependWhatResources()
	return {
		"ui/views/summerlottery/summerlotterybuyview.prefab"
	}
end

function SummerlotterybuyViewPresentor:buildViews()
	return {
		SummerLotteryBuyView.New()
	}
end

return SummerlotterybuyViewPresentor
