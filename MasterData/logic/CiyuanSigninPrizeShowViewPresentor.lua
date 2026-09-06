-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuansignin/view/CiyuanSigninPrizeShowViewPresentor.lua

module("logic.extensions.ciyuansignin.view.CiyuanSigninPrizeShowViewPresentor", package.seeall)

local CiyuanSigninPrizeShowViewPresentor = class("CiyuanSigninPrizeShowViewPresentor", ViewPresentor)

function CiyuanSigninPrizeShowViewPresentor:ctor()
	CiyuanSigninPrizeShowViewPresentor.super.ctor(self)
end

function CiyuanSigninPrizeShowViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CiyuanSigninPrizeShowViewPresentor:dependWhatResources()
	return {
		"ui/views/ciyuansignin/ciyuansigninprizeshowview.prefab"
	}
end

function CiyuanSigninPrizeShowViewPresentor:buildViews()
	return {
		CiyuanSigninPrizeShowView.New()
	}
end

return CiyuanSigninPrizeShowViewPresentor
