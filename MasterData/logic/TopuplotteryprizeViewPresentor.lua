-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/topuplottery/view/TopuplotteryprizeViewPresentor.lua

module("logic.extensions.topuplottery.view.TopuplotteryprizeViewPresentor", package.seeall)

local TopuplotteryprizeViewPresentor = class("TopuplotteryprizeViewPresentor", ViewPresentor)

function TopuplotteryprizeViewPresentor:ctor()
	TopuplotteryprizeViewPresentor.super.ctor(self)
end

function TopuplotteryprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TopuplotteryprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/topuplottery/topuplotteryprizeview.prefab"
	}
end

function TopuplotteryprizeViewPresentor:buildViews()
	return {
		TopuplotteryprizeView.New()
	}
end

return TopuplotteryprizeViewPresentor
