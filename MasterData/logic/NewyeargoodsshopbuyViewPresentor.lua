-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyeargoodsshop/view/NewyeargoodsshopbuyViewPresentor.lua

module("logic.extensions.newyeargoodsshop.view.NewyeargoodsshopbuyViewPresentor", package.seeall)

local NewyeargoodsshopbuyViewPresentor = class("NewyeargoodsshopbuyViewPresentor", ViewPresentor)

function NewyeargoodsshopbuyViewPresentor:ctor()
	NewyeargoodsshopbuyViewPresentor.super.ctor(self)
end

function NewyeargoodsshopbuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewyeargoodsshopbuyViewPresentor:dependWhatResources()
	return {
		"ui/views/newyeargoodsshop/newyeargoodsshopbuyview.prefab"
	}
end

function NewyeargoodsshopbuyViewPresentor:buildViews()
	return {
		NewyeargoodsshopbuyView.New()
	}
end

return NewyeargoodsshopbuyViewPresentor
