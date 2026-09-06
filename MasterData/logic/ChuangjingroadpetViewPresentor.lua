-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadpetViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadpetViewPresentor", package.seeall)

local ChuangjingroadpetViewPresentor = class("ChuangjingroadpetViewPresentor", ViewPresentor)

function ChuangjingroadpetViewPresentor:ctor()
	ChuangjingroadpetViewPresentor.super.ctor(self)
end

function ChuangjingroadpetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadpetViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadpetview.prefab"
	}
end

function ChuangjingroadpetViewPresentor:buildViews()
	return {
		ChuangjingroadpetView.New()
	}
end

return ChuangjingroadpetViewPresentor
