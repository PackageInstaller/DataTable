-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/view/OriginDiShiTianStageViewPresentor.lua

module("logic.extensions.origindishitian.view.OriginDiShiTianStageViewPresentor", package.seeall)

local OriginDiShiTianStageViewPresentor = class("OriginDiShiTianStageViewPresentor", ViewPresentor)

function OriginDiShiTianStageViewPresentor:ctor()
	OriginDiShiTianStageViewPresentor.super.ctor(self)
end

function OriginDiShiTianStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDiShiTianStageViewPresentor:dependWhatResources()
	return {
		"ui/views/origindishitian/origindishitianstageview.prefab"
	}
end

function OriginDiShiTianStageViewPresentor:buildViews()
	return {
		OriginDiShiTianStageView.New()
	}
end

return OriginDiShiTianStageViewPresentor
