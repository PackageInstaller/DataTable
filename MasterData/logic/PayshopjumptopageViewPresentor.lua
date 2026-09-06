-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopjumptopageViewPresentor.lua

module("logic.extensions.payshop.view.PayshopjumptopageViewPresentor", package.seeall)

local PayshopjumptopageViewPresentor = class("PayshopjumptopageViewPresentor", ViewPresentor)

function PayshopjumptopageViewPresentor:ctor()
	PayshopjumptopageViewPresentor.super.ctor(self)
end

function PayshopjumptopageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PayshopjumptopageViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshopjumptopageview.prefab"
	}
end

function PayshopjumptopageViewPresentor:buildViews()
	return {
		PayshopjumptopageView.New()
	}
end

return PayshopjumptopageViewPresentor
