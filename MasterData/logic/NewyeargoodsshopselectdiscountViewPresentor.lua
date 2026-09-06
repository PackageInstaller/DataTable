-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyeargoodsshop/view/NewyeargoodsshopselectdiscountViewPresentor.lua

module("logic.extensions.newyeargoodsshop.view.NewyeargoodsshopselectdiscountViewPresentor", package.seeall)

local NewyeargoodsshopselectdiscountViewPresentor = class("NewyeargoodsshopselectdiscountViewPresentor", ViewPresentor)

function NewyeargoodsshopselectdiscountViewPresentor:ctor()
	NewyeargoodsshopselectdiscountViewPresentor.super.ctor(self)
end

function NewyeargoodsshopselectdiscountViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewyeargoodsshopselectdiscountViewPresentor:dependWhatResources()
	return {
		"ui/views/newyeargoodsshop/newyeargoodsshopselectdiscountview.prefab"
	}
end

function NewyeargoodsshopselectdiscountViewPresentor:buildViews()
	return {
		NewyeargoodsshopselectdiscountView.New()
	}
end

return NewyeargoodsshopselectdiscountViewPresentor
