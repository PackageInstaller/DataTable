-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/SummerlotterymainViewPresentor.lua

module("logic.extensions.summerlottery.view.SummerlotterymainViewPresentor", package.seeall)

local SummerlotterymainViewPresentor = class("SummerlotterymainViewPresentor", ViewPresentor)

function SummerlotterymainViewPresentor:ctor()
	SummerlotterymainViewPresentor.super.ctor(self)
end

function SummerlotterymainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SummerlotterymainViewPresentor:dependWhatResources()
	return {
		"ui/views/summerlottery/summerlotterymainview.prefab"
	}
end

function SummerlotterymainViewPresentor:buildViews()
	return {
		SummerLotteryMainView.New()
	}
end

return SummerlotterymainViewPresentor
