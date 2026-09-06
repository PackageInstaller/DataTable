-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originwelfare/view/OriginWelfareMainViewPresentor.lua

module("logic.extensions.originwelfare.view.OriginWelfareMainViewPresentor", package.seeall)

local OriginWelfareMainViewPresentor = class("OriginWelfareMainViewPresentor", ViewPresentor)

function OriginWelfareMainViewPresentor:ctor()
	OriginWelfareMainViewPresentor.super.ctor(self)
end

function OriginWelfareMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginWelfareMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originwelfare/originwelfaremainview.prefab"
	}
end

function OriginWelfareMainViewPresentor:buildViews()
	return {
		OriginWelfareMainView.New()
	}
end

return OriginWelfareMainViewPresentor
