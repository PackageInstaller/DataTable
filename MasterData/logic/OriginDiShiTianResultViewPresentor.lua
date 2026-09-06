-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/view/OriginDiShiTianResultViewPresentor.lua

module("logic.extensions.origindishitian.view.OriginDiShiTianResultViewPresentor", package.seeall)

local OriginDiShiTianResultViewPresentor = class("OriginDiShiTianResultViewPresentor", ViewPresentor)

function OriginDiShiTianResultViewPresentor:ctor()
	OriginDiShiTianResultViewPresentor.super.ctor(self)
end

function OriginDiShiTianResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginDiShiTianResultViewPresentor:dependWhatResources()
	return {
		"ui/views/origindishitian/origindishitianresultview.prefab"
	}
end

function OriginDiShiTianResultViewPresentor:buildViews()
	return {
		OriginDiShiTianResultView.New()
	}
end

return OriginDiShiTianResultViewPresentor
