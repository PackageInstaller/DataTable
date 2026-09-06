-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/disorderpower/view/DisOrderPowerLotteryViewPresentor.lua

module("logic.extensions.disorderpower.view.DisOrderPowerLotteryViewPresentor", package.seeall)

local DisOrderPowerLotteryViewPresentor = class("DisOrderPowerLotteryViewPresentor", ViewPresentor)

function DisOrderPowerLotteryViewPresentor:ctor()
	DisOrderPowerLotteryViewPresentor.super.ctor(self)
end

function DisOrderPowerLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DisOrderPowerLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/disorderpowercard/disorderpowerlotteryview.prefab"
	}
end

function DisOrderPowerLotteryViewPresentor:buildViews()
	return {
		DisOrderPowerLotteryView.New()
	}
end

return DisOrderPowerLotteryViewPresentor
