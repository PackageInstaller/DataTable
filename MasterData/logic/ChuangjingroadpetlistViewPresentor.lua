-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadpetlistViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadpetlistViewPresentor", package.seeall)

local ChuangjingroadpetlistViewPresentor = class("ChuangjingroadpetlistViewPresentor", ViewPresentor)

function ChuangjingroadpetlistViewPresentor:ctor()
	ChuangjingroadpetlistViewPresentor.super.ctor(self)
end

function ChuangjingroadpetlistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadpetlistViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadpetlistview.prefab"
	}
end

function ChuangjingroadpetlistViewPresentor:buildViews()
	return {
		ChuangjingroadpetlistView.New()
	}
end

return ChuangjingroadpetlistViewPresentor
