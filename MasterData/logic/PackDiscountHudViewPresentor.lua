-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/packdiscount/view/PackDiscountHudViewPresentor.lua

module("logic.extensions.packdiscount.view.PackDiscountHudViewPresentor", package.seeall)

local PackDiscountHudViewPresentor = class("PackDiscountHudViewPresentor", ViewPresentor)

function PackDiscountHudViewPresentor:ctor()
	PackDiscountHudViewPresentor.super.ctor(self)
end

function PackDiscountHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PackDiscountHudViewPresentor:dependWhatResources()
	return {
		"ui/views/packdiscount/packdiscounthudview.prefab"
	}
end

function PackDiscountHudViewPresentor:buildViews()
	return {
		PackDiscountHudView.New()
	}
end

function PackDiscountHudViewPresentor:setGrayMaskGO(grayMaskGO)
	PackDiscountHudViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return PackDiscountHudViewPresentor
