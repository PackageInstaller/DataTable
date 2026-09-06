-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroaddebuffViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroaddebuffViewPresentor", package.seeall)

local ChuangjingroaddebuffViewPresentor = class("ChuangjingroaddebuffViewPresentor", ViewPresentor)

function ChuangjingroaddebuffViewPresentor:ctor()
	ChuangjingroaddebuffViewPresentor.super.ctor(self)
end

function ChuangjingroaddebuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroaddebuffViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroaddebuffview.prefab"
	}
end

function ChuangjingroaddebuffViewPresentor:buildViews()
	return {
		ChuangjingroaddebuffView.New()
	}
end

return ChuangjingroaddebuffViewPresentor
