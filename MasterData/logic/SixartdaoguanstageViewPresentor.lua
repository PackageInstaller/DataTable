-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanstageViewPresentor.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanstageViewPresentor", package.seeall)

local SixartdaoguanstageViewPresentor = class("SixartdaoguanstageViewPresentor", ViewPresentor)

function SixartdaoguanstageViewPresentor:ctor()
	SixartdaoguanstageViewPresentor.super.ctor(self)
end

function SixartdaoguanstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SixartdaoguanstageViewPresentor:dependWhatResources()
	return {
		"ui/views/sixartdaoguan/sixartdaoguanstageview.prefab"
	}
end

function SixartdaoguanstageViewPresentor:buildViews()
	return {
		SixartdaoguanstageView.New()
	}
end

return SixartdaoguanstageViewPresentor
