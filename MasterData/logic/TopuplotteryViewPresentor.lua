-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/topuplottery/view/TopuplotteryViewPresentor.lua

module("logic.extensions.topuplottery.view.TopuplotteryViewPresentor", package.seeall)

local TopuplotteryViewPresentor = class("TopuplotteryViewPresentor", ViewPresentor)

function TopuplotteryViewPresentor:ctor()
	TopuplotteryViewPresentor.super.ctor(self)
end

function TopuplotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TopuplotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/topuplottery/topuplotteryview.prefab"
	}
end

function TopuplotteryViewPresentor:buildViews()
	return {
		TopuplotteryView.New()
	}
end

return TopuplotteryViewPresentor
