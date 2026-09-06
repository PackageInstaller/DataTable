-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/guardcity/PassportGuardCityViewPresentor.lua

module("logic.extensions.passport.view.guardcity.PassportGuardCityViewPresentor", package.seeall)

local PassportGuardCityViewPresentor = class("PassportGuardCityViewPresentor", ViewPresentor)

function PassportGuardCityViewPresentor:ctor()
	PassportGuardCityViewPresentor.super.ctor(self)
end

function PassportGuardCityViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportGuardCityViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportguardcityview.prefab"
	}
end

function PassportGuardCityViewPresentor:buildViews()
	return {
		PassportGuardCityView.New()
	}
end

return PassportGuardCityViewPresentor
