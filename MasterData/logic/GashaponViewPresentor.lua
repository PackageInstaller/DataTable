-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gashapon/view/GashaponViewPresentor.lua

module("logic.extensions.gashapon.view.GashaponViewPresentor", package.seeall)

local GashaponViewPresentor = class("GashaponViewPresentor", ViewPresentor)

function GashaponViewPresentor:ctor()
	GashaponViewPresentor.super.ctor(self)
end

function GashaponViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GashaponViewPresentor:dependWhatResources()
	return {
		"ui/views/activity/gashapon/gashaponview.prefab"
	}
end

function GashaponViewPresentor:buildViews()
	return {
		GashaponView.New()
	}
end

return GashaponViewPresentor
