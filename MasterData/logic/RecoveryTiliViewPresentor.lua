-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/RecoveryTiliViewPresentor.lua

module("logic.extensions.lottery.view.RecoveryTiliViewPresentor", package.seeall)

local RecoveryTiliViewPresentor = class("RecoveryTiliViewPresentor", ViewPresentor)

function RecoveryTiliViewPresentor:ctor()
	RecoveryTiliViewPresentor.super.ctor(self)
end

function RecoveryTiliViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RecoveryTiliViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/recoverytiliview.prefab"
	}
end

function RecoveryTiliViewPresentor:buildViews()
	return {
		RecoveryTiliView.New()
	}
end

function RecoveryTiliViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return RecoveryTiliViewPresentor
