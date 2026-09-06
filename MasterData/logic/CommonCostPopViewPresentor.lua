-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/CommonCostPopViewPresentor.lua

module("logic.extensions.tips.view.FlowerPopViewPresentor", package.seeall)

local FlowerPopViewPresentor = class("FlowerPopViewPresentor", ViewPresentor)

function FlowerPopViewPresentor:ctor()
	FlowerPopViewPresentor.super.ctor(self)
end

function FlowerPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FlowerPopViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/commoncostpopview.prefab"
	}
end

function FlowerPopViewPresentor:buildViews()
	return {
		CommonCostPopView.New()
	}
end

return FlowerPopViewPresentor
