-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryMaterialViewPresentor.lua

module("logic.extensions.lottery.view.LotteryMaterialViewPresentor", package.seeall)

local LotteryMaterialViewPresentor = class("LotteryMaterialViewPresentor", ViewPresentor)

function LotteryMaterialViewPresentor:ctor()
	LotteryMaterialViewPresentor.super.ctor(self)
end

function LotteryMaterialViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotteryMaterialViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/lotterymaterialview.prefab"
	}
end

function LotteryMaterialViewPresentor:buildViews()
	return {
		LotteryMaterialView.New()
	}
end

function LotteryMaterialViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LotteryMaterialViewPresentor
