-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tarolottery/view/TarolotteryViewPresentor.lua

module("logic.extensions.tarolottery.view.TarolotteryViewPresentor", package.seeall)

local TarolotteryViewPresentor = class("TarolotteryViewPresentor", ViewPresentor)

function TarolotteryViewPresentor:ctor()
	TarolotteryViewPresentor.super.ctor(self)
end

function TarolotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TarolotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/tarolottery/tarolotteryview.prefab"
	}
end

function TarolotteryViewPresentor:buildViews()
	return {
		TarolotteryView.New()
	}
end

return TarolotteryViewPresentor
