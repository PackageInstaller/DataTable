-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/view/OriginDiShiTianMainViewPresentor.lua

module("logic.extensions.origindishitian.view.OriginDiShiTianMainViewPresentor", package.seeall)

local OriginDiShiTianMainViewPresentor = class("OriginDiShiTianMainViewPresentor", ViewPresentor)

function OriginDiShiTianMainViewPresentor:ctor()
	OriginDiShiTianMainViewPresentor.super.ctor(self)
end

function OriginDiShiTianMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDiShiTianMainViewPresentor:dependWhatResources()
	return {
		"ui/views/origindishitian/origindishitianmainview.prefab"
	}
end

function OriginDiShiTianMainViewPresentor:buildViews()
	return {
		OriginDiShiTianMainView.New()
	}
end

return OriginDiShiTianMainViewPresentor
