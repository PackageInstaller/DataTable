-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DragonLotteryViewPresentor.lua

module("logic.extensions.lottery.view.DragonLotteryViewPresentor", package.seeall)

local DragonLotteryViewPresentor = class("DragonLotteryViewPresentor", ViewPresentor)

function DragonLotteryViewPresentor:ctor()
	DragonLotteryViewPresentor.super.ctor(self)
end

function DragonLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/dragonlotteryview.prefab"
	}
end

function DragonLotteryViewPresentor:buildViews()
	return {
		DragonLotteryView.New()
	}
end

return DragonLotteryViewPresentor
