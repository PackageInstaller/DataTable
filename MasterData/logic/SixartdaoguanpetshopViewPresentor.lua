-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanpetshopViewPresentor.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanpetshopViewPresentor", package.seeall)

local SixartdaoguanpetshopViewPresentor = class("SixartdaoguanpetshopViewPresentor", ViewPresentor)

function SixartdaoguanpetshopViewPresentor:ctor()
	SixartdaoguanpetshopViewPresentor.super.ctor(self)
end

function SixartdaoguanpetshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SixartdaoguanpetshopViewPresentor:dependWhatResources()
	return {
		"ui/views/sixartdaoguan/sixartdaoguanpetshopview.prefab"
	}
end

function SixartdaoguanpetshopViewPresentor:buildViews()
	return {
		SixartdaoguanpetshopView.New()
	}
end

return SixartdaoguanpetshopViewPresentor
