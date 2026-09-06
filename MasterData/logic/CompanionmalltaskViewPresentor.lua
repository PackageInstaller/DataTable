-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionmalltaskViewPresentor.lua

module("logic.extensions.companionmall.view.CompanionmalltaskViewPresentor", package.seeall)

local CompanionmalltaskViewPresentor = class("CompanionmalltaskViewPresentor", ViewPresentor)

function CompanionmalltaskViewPresentor:ctor()
	CompanionmalltaskViewPresentor.super.ctor(self)
end

function CompanionmalltaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompanionmalltaskViewPresentor:dependWhatResources()
	return {
		"ui/views/companionmall/companionmalltaskview.prefab"
	}
end

function CompanionmalltaskViewPresentor:buildViews()
	return {
		CompanionmalltaskView.New()
	}
end

return CompanionmalltaskViewPresentor
