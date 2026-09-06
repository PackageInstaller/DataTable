-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendten/view/GoldendTenTipsViewPresentor.lua

module("logic.extensions.goldendten.view.GoldendTenTipsViewPresentor", package.seeall)

local GoldendTenTipsViewPresentor = class("GoldendTenTipsViewPresentor", ViewPresentor)

function GoldendTenTipsViewPresentor:ctor()
	GoldendTenTipsViewPresentor.super.ctor(self)
end

function GoldendTenTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoldendTenTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/goldendten/goldendtentipsview.prefab"
	}
end

function GoldendTenTipsViewPresentor:buildViews()
	return {
		GoldendTenTipsView.New()
	}
end

return GoldendTenTipsViewPresentor
