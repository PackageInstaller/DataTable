-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadextViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadextViewPresentor", package.seeall)

local ChuangjingroadextViewPresentor = class("ChuangjingroadextViewPresentor", ViewPresentor)

function ChuangjingroadextViewPresentor:ctor()
	ChuangjingroadextViewPresentor.super.ctor(self)
end

function ChuangjingroadextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadextViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadextview.prefab"
	}
end

function ChuangjingroadextViewPresentor:buildViews()
	return {
		ChuangjingroadextView.New()
	}
end

return ChuangjingroadextViewPresentor
