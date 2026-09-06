-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopyearshowPresentor.lua

module("logic.extensions.payshop.view.PayshopyearshowPresentor", package.seeall)

local PayshopyearshowPresentor = class("PayshopyearshowPresentor", ViewPresentor)

function PayshopyearshowPresentor:ctor()
	PayshopyearshowPresentor.super.ctor(self)
end

function PayshopyearshowPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PayshopyearshowPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopyearshowview.prefab"
	}
end

function PayshopyearshowPresentor:buildViews()
	return {
		PayshopyearshowView.New()
	}
end

return PayshopyearshowPresentor
