-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadlistViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadlistViewPresentor", package.seeall)

local ChuangjingroadlistViewPresentor = class("ChuangjingroadlistViewPresentor", ViewPresentor)

function ChuangjingroadlistViewPresentor:ctor()
	ChuangjingroadlistViewPresentor.super.ctor(self)
end

function ChuangjingroadlistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadlistViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadlistview.prefab"
	}
end

function ChuangjingroadlistViewPresentor:buildViews()
	return {
		ChuangjingroadlistView.New()
	}
end

return ChuangjingroadlistViewPresentor
