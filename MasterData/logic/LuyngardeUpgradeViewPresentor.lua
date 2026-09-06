-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeUpgradeViewPresentor.lua

module("logic.extensions.luyngarde.view.LuyngardeUpgradeViewPresentor", package.seeall)

local LuyngardeUpgradeViewPresentor = class("LuyngardeUpgradeViewPresentor", ViewPresentor)

function LuyngardeUpgradeViewPresentor:ctor()
	LuyngardeUpgradeViewPresentor.super.ctor(self)
end

function LuyngardeUpgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuyngardeUpgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/luyngarde/luyngardeupgradeview.prefab"
	}
end

function LuyngardeUpgradeViewPresentor:buildViews()
	return {
		LuyngardeUpgradeView.New()
	}
end

return LuyngardeUpgradeViewPresentor
