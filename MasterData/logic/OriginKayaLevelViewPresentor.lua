-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkaya/view/OriginKayaLevelViewPresentor.lua

module("logic.extensions.originkaya.view.OriginKayaLevelViewPresentor", package.seeall)

local OriginKayaLevelViewPresentor = class("OriginKayaLevelViewPresentor", ViewPresentor)

function OriginKayaLevelViewPresentor:ctor()
	OriginKayaLevelViewPresentor.super.ctor(self)
end

function OriginKayaLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKayaLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/originkaya/originkayalevelview.prefab"
	}
end

function OriginKayaLevelViewPresentor:buildViews()
	return {
		OriginKayaLevelView.New()
	}
end

return OriginKayaLevelViewPresentor
