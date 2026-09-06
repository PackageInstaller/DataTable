-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadpetlvlupViewPresentor.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadpetlvlupViewPresentor", package.seeall)

local ChuangjingroadpetlvlupViewPresentor = class("ChuangjingroadpetlvlupViewPresentor", ViewPresentor)

function ChuangjingroadpetlvlupViewPresentor:ctor()
	ChuangjingroadpetlvlupViewPresentor.super.ctor(self)
end

function ChuangjingroadpetlvlupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangjingroadpetlvlupViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangjingroad/chuangjingroadpetlvlupview.prefab"
	}
end

function ChuangjingroadpetlvlupViewPresentor:buildViews()
	return {
		ChuangjingroadpetlvlupView.New()
	}
end

return ChuangjingroadpetlvlupViewPresentor
