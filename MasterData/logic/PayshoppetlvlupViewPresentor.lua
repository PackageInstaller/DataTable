-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshoppetlvlupViewPresentor.lua

module("logic.extensions.payshop.view.PayshoppetlvlupViewPresentor", package.seeall)

local PayshoppetlvlupViewPresentor = class("PayshoppetlvlupViewPresentor", ViewPresentor)

function PayshoppetlvlupViewPresentor:ctor()
	PayshoppetlvlupViewPresentor.super.ctor(self)
end

function PayshoppetlvlupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PayshoppetlvlupViewPresentor:dependWhatResources()
	return {
		"ui/views/payshop/payshoppetlvlupview.prefab"
	}
end

function PayshoppetlvlupViewPresentor:buildViews()
	return {
		PayshoppetlvlupView.New()
	}
end

return PayshoppetlvlupViewPresentor
