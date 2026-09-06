-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallSelectViewPresentor.lua

module("logic.extensions.companionmall.view.CompanionMallSelectViewPresentor", package.seeall)

local CompanionMallSelectViewPresentor = class("CompanionMallSelectViewPresentor", ViewPresentor)

function CompanionMallSelectViewPresentor:ctor()
	CompanionMallSelectViewPresentor.super.ctor(self)
end

function CompanionMallSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompanionMallSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/companionmall/companionmallselectview.prefab"
	}
end

function CompanionMallSelectViewPresentor:buildViews()
	return {
		CompanionMallSelectView.New()
	}
end

return CompanionMallSelectViewPresentor
