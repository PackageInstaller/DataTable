-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendten/view/GoldendTenMainViewPresentor.lua

module("logic.extensions.goldendten.view.GoldendTenMainViewPresentor", package.seeall)

local GoldendTenMainViewPresentor = class("GoldendTenMainViewPresentor", ViewPresentor)

function GoldendTenMainViewPresentor:ctor()
	GoldendTenMainViewPresentor.super.ctor(self)
end

function GoldendTenMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoldendTenMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goldendten/goldendtenmainview.prefab"
	}
end

function GoldendTenMainViewPresentor:buildViews()
	return {
		GoldendTenMainView.New()
	}
end

return GoldendTenMainViewPresentor
