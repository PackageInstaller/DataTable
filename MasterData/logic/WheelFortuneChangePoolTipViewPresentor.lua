-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheelfortune/view/WheelFortuneChangePoolTipViewPresentor.lua

module("logic.extensions.wheelfortune.view.WheelFortuneChangePoolTipViewPresentor", package.seeall)

local WheelFortuneChangePoolTipViewPresentor = class("WheelFortuneChangePoolTipViewPresentor", ViewPresentor)

function WheelFortuneChangePoolTipViewPresentor:ctor()
	WheelFortuneChangePoolTipViewPresentor.super.ctor(self)
end

function WheelFortuneChangePoolTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WheelFortuneChangePoolTipViewPresentor:dependWhatResources()
	return {
		"ui/views/jackpot/jackpotchangepooltip.prefab"
	}
end

function WheelFortuneChangePoolTipViewPresentor:buildViews()
	return {
		WheelFortuneChangePoolTipView.New()
	}
end

function WheelFortuneChangePoolTipViewPresentor:onClickOutside()
	self:close()
end

return WheelFortuneChangePoolTipViewPresentor
