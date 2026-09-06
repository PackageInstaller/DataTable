-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionMallPackViewPresentor.lua

module("logic.extensions.companionmall.view.CompanionMallPackViewPresentor", package.seeall)

local CompanionMallPackViewPresentor = class("CompanionMallPackViewPresentor", ViewPresentor)

function CompanionMallPackViewPresentor:ctor()
	CompanionMallPackViewPresentor.super.ctor(self)
end

function CompanionMallPackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompanionMallPackViewPresentor:dependWhatResources()
	return {
		"ui/views/companionmall/companionmallpackview.prefab"
	}
end

function CompanionMallPackViewPresentor:buildViews()
	return {
		CompanionMallPackView.New()
	}
end

return CompanionMallPackViewPresentor
