-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadbosswaterViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadbosswaterViewPresentor", package.seeall)

local ChuangjingroadbosswaterViewPresentor = class("ChuangjingroadbosswaterViewPresentor", ViewPresentor)

function ChuangjingroadbosswaterViewPresentor:ctor()
	ChuangjingroadbosswaterViewPresentor.super.ctor(self)
end

function ChuangjingroadbosswaterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadbosswaterViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadbosswaterview.prefab"
	}
end

function ChuangjingroadbosswaterViewPresentor:buildViews()
	return {
		ChuangjingroadbosswaterView.New()
	}
end

return ChuangjingroadbosswaterViewPresentor
