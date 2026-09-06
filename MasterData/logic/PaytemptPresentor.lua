-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paytempt/view/PaytemptPresentor.lua

module("logic.extensions.paytempt.view.PaytemptPresentor", package.seeall)

local PaytemptPresentor = class("PaytemptPresentor", ViewPresentor)

function PaytemptPresentor:ctor()
	PaytemptPresentor.super.ctor(self)
end

function PaytemptPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PaytemptPresentor:dependWhatResources()
	return {
		"ui/views/activity/paytempt/paytemptview.prefab"
	}
end

function PaytemptPresentor:buildViews()
	return {
		PaytemptView.New()
	}
end

return PaytemptPresentor
