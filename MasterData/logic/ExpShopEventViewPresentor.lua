-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpShopEventViewPresentor.lua

module("logic.extensions.expedition.view.ExpShopEventViewPresentor", package.seeall)

local ExpShopEventViewPresentor = class("ExpShopEventViewPresentor", ViewPresentor)

function ExpShopEventViewPresentor:ctor()
	ExpShopEventViewPresentor.super.ctor(self)
end

function ExpShopEventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpShopEventViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/shopeventview.prefab"
	}
end

function ExpShopEventViewPresentor:buildViews()
	return {
		ExpShopEventView.New()
	}
end

return ExpShopEventViewPresentor
