-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/packdiscount/view/PackDiscountViewPresentor.lua

module("logic.extensions.packdiscount.view.PackDiscountViewPresentor", package.seeall)

local PackDiscountViewPresentor = class("PackDiscountViewPresentor", ViewPresentor)

function PackDiscountViewPresentor:ctor()
	PackDiscountViewPresentor.super.ctor(self)
end

function PackDiscountViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PackDiscountViewPresentor:dependWhatResources()
	return {
		"ui/views/packdiscount/packdiscountview.prefab"
	}
end

function PackDiscountViewPresentor:buildViews()
	return {
		PackDiscountView.New()
	}
end

return PackDiscountViewPresentor
