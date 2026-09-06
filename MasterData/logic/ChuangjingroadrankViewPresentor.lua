-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadrankViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadrankViewPresentor", package.seeall)

local ChuangjingroadrankViewPresentor = class("ChuangjingroadrankViewPresentor", ViewPresentor)

function ChuangjingroadrankViewPresentor:ctor()
	ChuangjingroadrankViewPresentor.super.ctor(self)
end

function ChuangjingroadrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadrankViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadrankview.prefab"
	}
end

function ChuangjingroadrankViewPresentor:buildViews()
	return {
		ChuangjingroadrankView.New()
	}
end

return ChuangjingroadrankViewPresentor
