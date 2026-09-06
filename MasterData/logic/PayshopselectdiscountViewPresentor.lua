-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopselectdiscountViewPresentor.lua

module("logic.extensions.payshop.view.PayshopselectdiscountViewPresentor", package.seeall)

local PayshopselectdiscountViewPresentor = class("PayshopselectdiscountViewPresentor", ViewPresentor)

function PayshopselectdiscountViewPresentor:ctor()
	PayshopselectdiscountViewPresentor.super.ctor(self)
end

function PayshopselectdiscountViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PayshopselectdiscountViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopselectdiscountview.prefab"
	}
end

function PayshopselectdiscountViewPresentor:buildViews()
	return {
		PayshopselectdiscountView.New()
	}
end

function PayshopselectdiscountViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return PayshopselectdiscountViewPresentor
