-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkaya/view/OriginKayaFmtViewPresentor.lua

module("logic.extensions.originkaya.view.OriginKayaFmtViewPresentor", package.seeall)

local OriginKayaFmtViewPresentor = class("OriginKayaFmtViewPresentor", ViewPresentor)

function OriginKayaFmtViewPresentor:ctor()
	OriginKayaFmtViewPresentor.super.ctor(self)
end

function OriginKayaFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKayaFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/originkaya/originkayafmtview.prefab"
	}
end

function OriginKayaFmtViewPresentor:buildViews()
	return {
		OriginKayaFmtView.New()
	}
end

return OriginKayaFmtViewPresentor
