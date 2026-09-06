-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/view/GodDiShiTianMainViewPresentor.lua

module("logic.extensions.goddishitian.view.GodDiShiTianMainViewPresentor", package.seeall)

local GodDiShiTianMainViewPresentor = class("GodDiShiTianMainViewPresentor", ViewPresentor)

function GodDiShiTianMainViewPresentor:ctor()
	GodDiShiTianMainViewPresentor.super.ctor(self)
end

function GodDiShiTianMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDiShiTianMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddishitian/goddishitianmainview.prefab"
	}
end

function GodDiShiTianMainViewPresentor:buildViews()
	return {
		GodDiShiTianMainView.New()
	}
end

return GodDiShiTianMainViewPresentor
