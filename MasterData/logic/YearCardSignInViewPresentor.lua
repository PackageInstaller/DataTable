-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardsignin/view/YearCardSignInViewPresentor.lua

module("logic.extensions.yearcardsignin.view.YearCardSignInViewPresentor", package.seeall)

local YearCardSignInViewPresentor = class("YearCardSignInViewPresentor", ViewPresentor)

function YearCardSignInViewPresentor:ctor()
	YearCardSignInViewPresentor.super.ctor(self)
end

function YearCardSignInViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSignInViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcardsignin/ycsigninview.prefab"
	}
end

function YearCardSignInViewPresentor:buildViews()
	return {
		YearCardSignInView.New()
	}
end

return YearCardSignInViewPresentor
