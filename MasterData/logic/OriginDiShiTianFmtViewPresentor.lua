-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/view/OriginDiShiTianFmtViewPresentor.lua

module("logic.extensions.origindishitian.view.OriginDiShiTianFmtViewPresentor", package.seeall)

local OriginDiShiTianFmtViewPresentor = class("OriginDiShiTianFmtViewPresentor", ViewPresentor)

function OriginDiShiTianFmtViewPresentor:ctor()
	OriginDiShiTianFmtViewPresentor.super.ctor(self)
end

function OriginDiShiTianFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDiShiTianFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/origindishitian/origindishitianfmtview.prefab"
	}
end

function OriginDiShiTianFmtViewPresentor:buildViews()
	return {
		OriginDiShiTianFmtView.New()
	}
end

function OriginDiShiTianFmtViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return OriginDiShiTianFmtViewPresentor
