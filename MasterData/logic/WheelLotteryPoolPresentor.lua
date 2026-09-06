-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheellotterypool/view/WheelLotteryPoolPresentor.lua

module("logic.extensions.wheellotterypool.view.WheelLotteryPoolPresentor", package.seeall)

local WheelLotteryPoolPresentor = class("WheelLotteryPoolPresentor", ViewPresentor)

function WheelLotteryPoolPresentor:ctor()
	WheelLotteryPoolPresentor.super.ctor(self)
end

function WheelLotteryPoolPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WheelLotteryPoolPresentor:dependWhatResources()
	return {
		"ui/views/wheellotterypool/wheellotterypoolview.prefab"
	}
end

function WheelLotteryPoolPresentor:buildViews()
	return {
		WheelLotteryPoolView.New()
	}
end

return WheelLotteryPoolPresentor
