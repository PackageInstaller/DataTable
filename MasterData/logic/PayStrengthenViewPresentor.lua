-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paystrengthen/view/PayStrengthenViewPresentor.lua

module("logic.extensions.paystrengthen.view.PayStrengthenViewPresentor", package.seeall)

local PayStrengthenViewPresentor = class("PayStrengthenViewPresentor", ViewPresentor)

function PayStrengthenViewPresentor:ctor()
	PayStrengthenViewPresentor.super.ctor(self)
end

function PayStrengthenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PayStrengthenViewPresentor:dependWhatResources()
	return {
		"ui/views/longnvpurchase/paystrengthenview.prefab"
	}
end

function PayStrengthenViewPresentor:buildViews()
	return {
		PayStrengthenView.New()
	}
end

return PayStrengthenViewPresentor
