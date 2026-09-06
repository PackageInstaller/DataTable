-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadmainViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadmainViewPresentor", package.seeall)

local ChuangjingroadmainViewPresentor = class("ChuangjingroadmainViewPresentor", ViewPresentor)

function ChuangjingroadmainViewPresentor:ctor()
	ChuangjingroadmainViewPresentor.super.ctor(self)
end

function ChuangjingroadmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadmainViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadmainview.prefab"
	}
end

function ChuangjingroadmainViewPresentor:buildViews()
	return {
		ChuangjingroadmainView.New()
	}
end

return ChuangjingroadmainViewPresentor
