-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/guardcity/PassportGuardCityBuyViewPresentor.lua

module("logic.extensions.passport.view.guardcity.PassportGuardCityBuyViewPresentor", package.seeall)

local PassportGuardCityBuyViewPresentor = class("PassportGuardCityBuyViewPresentor", ViewPresentor)

function PassportGuardCityBuyViewPresentor:ctor()
	PassportGuardCityBuyViewPresentor.super.ctor(self)
end

function PassportGuardCityBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PassportGuardCityBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportguardcitybuyview.prefab"
	}
end

function PassportGuardCityBuyViewPresentor:buildViews()
	return {
		PassportGuardCityBuyView.New()
	}
end

return PassportGuardCityBuyViewPresentor
