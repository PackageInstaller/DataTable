-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopyearPresentor.lua

module("logic.extensions.payshop.view.PayshopyearPresentor", package.seeall)

local PayshopyearPresentor = class("PayshopyearPresentor", ViewPresentor)

function PayshopyearPresentor:ctor()
	PayshopyearPresentor.super.ctor(self)
end

function PayshopyearPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PayshopyearPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopyearview.prefab"
	}
end

function PayshopyearPresentor:buildViews()
	return {
		PayshopyearView.New()
	}
end

function PayshopyearPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PayshopyearPresentor
