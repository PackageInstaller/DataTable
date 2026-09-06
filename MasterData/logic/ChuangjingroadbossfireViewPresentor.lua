-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadbossfireViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadbossfireViewPresentor", package.seeall)

local ChuangjingroadbossfireViewPresentor = class("ChuangjingroadbossfireViewPresentor", ViewPresentor)

function ChuangjingroadbossfireViewPresentor:ctor()
	ChuangjingroadbossfireViewPresentor.super.ctor(self)
end

function ChuangjingroadbossfireViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadbossfireViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadbossfireview.prefab"
	}
end

function ChuangjingroadbossfireViewPresentor:buildViews()
	return {
		ChuangjingroadbossfireView.New()
	}
end

return ChuangjingroadbossfireViewPresentor
