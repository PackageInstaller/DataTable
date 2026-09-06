-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/RecoveryTiliCostTipViewPresentor.lua

module("logic.extensions.lottery.view.RecoveryTiliCostTipViewPresentor", package.seeall)

local RecoveryTiliCostTipViewPresentor = class("RecoveryTiliCostTipViewPresentor", ViewPresentor)

function RecoveryTiliCostTipViewPresentor:ctor()
	RecoveryTiliCostTipViewPresentor.super.ctor(self)
end

function RecoveryTiliCostTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RecoveryTiliCostTipViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/recoverytilicosttipview.prefab"
	}
end

function RecoveryTiliCostTipViewPresentor:buildViews()
	return {
		RecoveryTiliCostTipView.New()
	}
end

return RecoveryTiliCostTipViewPresentor
