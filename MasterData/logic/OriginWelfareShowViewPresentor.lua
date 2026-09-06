-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originwelfare/view/OriginWelfareShowViewPresentor.lua

module("logic.extensions.originwelfare.view.OriginWelfareShowViewPresentor", package.seeall)

local OriginWelfareShowViewPresentor = class("OriginWelfareShowViewPresentor", ViewPresentor)

function OriginWelfareShowViewPresentor:ctor()
	OriginWelfareShowViewPresentor.super.ctor(self)
end

function OriginWelfareShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginWelfareShowViewPresentor:dependWhatResources()
	return {
		"ui/views/originwelfare/originwelfareshowview.prefab"
	}
end

function OriginWelfareShowViewPresentor:buildViews()
	return {
		OriginWelfareShowView.New()
	}
end

return OriginWelfareShowViewPresentor
