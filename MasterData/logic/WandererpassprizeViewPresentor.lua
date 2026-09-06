-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/view/WandererpassprizeViewPresentor.lua

module("logic.extensions.wandererpass.view.WandererpassprizeViewPresentor", package.seeall)

local WandererpassprizeViewPresentor = class("WandererpassprizeViewPresentor", ViewPresentor)

function WandererpassprizeViewPresentor:ctor()
	WandererpassprizeViewPresentor.super.ctor(self)
end

function WandererpassprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WandererpassprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/wandererpass/wandererpassprizeview.prefab"
	}
end

function WandererpassprizeViewPresentor:buildViews()
	return {
		WandererpassprizeView.New()
	}
end

return WandererpassprizeViewPresentor
