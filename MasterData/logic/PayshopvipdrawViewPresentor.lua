-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopvipdrawViewPresentor.lua

module("logic.extensions.payshop.view.PayshopvipdrawViewPresentor", package.seeall)

local PayshopvipdrawViewPresentor = class("PayshopvipdrawViewPresentor", ViewPresentor)

function PayshopvipdrawViewPresentor:ctor()
	PayshopvipdrawViewPresentor.super.ctor(self)
end

function PayshopvipdrawViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PayshopvipdrawViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopvipdrawview.prefab"
	}
end

function PayshopvipdrawViewPresentor:buildViews()
	return {
		PayshopvipdrawView.New()
	}
end

return PayshopvipdrawViewPresentor
