-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/PagetourlinkageViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.PagetourlinkageViewPresentor", package.seeall)

local PagetourlinkageViewPresentor = class("PagetourlinkageViewPresentor", ViewPresentor)

function PagetourlinkageViewPresentor:ctor()
	PagetourlinkageViewPresentor.super.ctor(self)
end

function PagetourlinkageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PagetourlinkageViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/pagetourlinkageview.prefab"
	}
end

function PagetourlinkageViewPresentor:buildViews()
	return {
		PagetourlinkageView.New()
	}
end

return PagetourlinkageViewPresentor
