-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/PrizelotteryexplainViewPresentor.lua

module("logic.extensions.summerlottery.view.PrizelotteryexplainViewPresentor", package.seeall)

local PrizelotteryexplainViewPresentor = class("PrizelotteryexplainViewPresentor", ViewPresentor)

function PrizelotteryexplainViewPresentor:ctor()
	PrizelotteryexplainViewPresentor.super.ctor(self)
end

function PrizelotteryexplainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PrizelotteryexplainViewPresentor:dependWhatResources()
	return {
		"ui/views/summerlottery/prizelotteryexplainview.prefab"
	}
end

function PrizelotteryexplainViewPresentor:buildViews()
	return {
		PrizeLotteryExplainView.New()
	}
end

return PrizelotteryexplainViewPresentor
