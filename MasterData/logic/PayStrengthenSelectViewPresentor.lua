-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paystrengthen/view/PayStrengthenSelectViewPresentor.lua

module("logic.extensions.paystrengthen.view.PayStrengthenSelectViewPresentor", package.seeall)

local PayStrengthenSelectViewPresentor = class("PayStrengthenSelectViewPresentor", ViewPresentor)

function PayStrengthenSelectViewPresentor:ctor()
	PayStrengthenSelectViewPresentor.super.ctor(self)
end

function PayStrengthenSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PayStrengthenSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/longnvpurchase/paystrengthenselectview.prefab"
	}
end

function PayStrengthenSelectViewPresentor:buildViews()
	return {
		PayStrengthenSelectView.New()
	}
end

return PayStrengthenSelectViewPresentor
