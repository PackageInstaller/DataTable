-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadresbossViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadresbossViewPresentor", package.seeall)

local ChuangjingroadresbossViewPresentor = class("ChuangjingroadresbossViewPresentor", ViewPresentor)

function ChuangjingroadresbossViewPresentor:ctor()
	ChuangjingroadresbossViewPresentor.super.ctor(self)
end

function ChuangjingroadresbossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadresbossViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadresbossview.prefab"
	}
end

function ChuangjingroadresbossViewPresentor:buildViews()
	return {
		ChuangjingroadresbossView.New()
	}
end

return ChuangjingroadresbossViewPresentor
