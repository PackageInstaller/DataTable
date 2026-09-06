-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallMainViewPresentor.lua

module("logic.extensions.companionmall.view.CompanionMallMainViewPresentor", package.seeall)

local CompanionMallMainViewPresentor = class("CompanionMallMainViewPresentor", ViewPresentor)

function CompanionMallMainViewPresentor:ctor()
	CompanionMallMainViewPresentor.super.ctor(self)
end

function CompanionMallMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompanionMallMainViewPresentor:dependWhatResources()
	return {
		"ui/views/companionmall/companionmallmainview.prefab"
	}
end

function CompanionMallMainViewPresentor:buildViews()
	return {
		CompanionMallMainView.New()
	}
end

return CompanionMallMainViewPresentor
