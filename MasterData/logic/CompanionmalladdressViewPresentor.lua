-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionmalladdressViewPresentor.lua

module("logic.extensions.companionmall.view.CompanionmalladdressViewPresentor", package.seeall)

local CompanionmalladdressViewPresentor = class("CompanionmalladdressViewPresentor", ViewPresentor)

function CompanionmalladdressViewPresentor:ctor()
	CompanionmalladdressViewPresentor.super.ctor(self)
end

function CompanionmalladdressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CompanionmalladdressViewPresentor:dependWhatResources()
	return {
		"ui/views/companionmall/companionmalladdressview.prefab"
	}
end

function CompanionmalladdressViewPresentor:buildViews()
	return {
		CompanionmalladdressView.New()
	}
end

return CompanionmalladdressViewPresentor
