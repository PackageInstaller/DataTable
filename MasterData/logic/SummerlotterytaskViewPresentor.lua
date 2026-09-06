-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/SummerlotterytaskViewPresentor.lua

module("logic.extensions.summerlottery.view.SummerlotterytaskViewPresentor", package.seeall)

local SummerlotterytaskViewPresentor = class("SummerlotterytaskViewPresentor", ViewPresentor)

function SummerlotterytaskViewPresentor:ctor()
	SummerlotterytaskViewPresentor.super.ctor(self)
end

function SummerlotterytaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerlotterytaskViewPresentor:dependWhatResources()
	return {
		"ui/views/summerlottery/summerlotterytaskview.prefab"
	}
end

function SummerlotterytaskViewPresentor:buildViews()
	return {
		SummerLotteryTaskView.New()
	}
end

return SummerlotterytaskViewPresentor
