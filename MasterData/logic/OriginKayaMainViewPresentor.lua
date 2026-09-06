-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkaya/view/OriginKayaMainViewPresentor.lua

module("logic.extensions.originkaya.view.OriginKayaMainViewPresentor", package.seeall)

local OriginKayaMainViewPresentor = class("OriginKayaMainViewPresentor", ViewPresentor)

function OriginKayaMainViewPresentor:ctor()
	OriginKayaMainViewPresentor.super.ctor(self)
end

function OriginKayaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKayaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originkaya/originkayamainview.prefab"
	}
end

function OriginKayaMainViewPresentor:buildViews()
	return {
		OriginKayaMainView.New()
	}
end

return OriginKayaMainViewPresentor
