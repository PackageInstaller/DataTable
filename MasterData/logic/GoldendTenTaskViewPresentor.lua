-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendten/view/GoldendTenTaskViewPresentor.lua

module("logic.extensions.goldendten.view.GoldendTenTaskViewPresentor", package.seeall)

local GoldendTenTaskViewPresentor = class("GoldendTenTaskViewPresentor", ViewPresentor)

function GoldendTenTaskViewPresentor:ctor()
	GoldendTenTaskViewPresentor.super.ctor(self)
end

function GoldendTenTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoldendTenTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/goldendten/goldendtentaskview.prefab"
	}
end

function GoldendTenTaskViewPresentor:buildViews()
	return {
		GoldendTenTaskView.New()
	}
end

return GoldendTenTaskViewPresentor
