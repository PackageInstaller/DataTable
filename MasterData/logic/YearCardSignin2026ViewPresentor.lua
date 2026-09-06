-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardSignin2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardSignin2026ViewPresentor", package.seeall)

local YearCardSignin2026ViewPresentor = class("YearCardSignin2026ViewPresentor", ViewPresentor)

function YearCardSignin2026ViewPresentor:ctor()
	YearCardSignin2026ViewPresentor.super.ctor(self)
end

function YearCardSignin2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSignin2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardsignin2026view.prefab"
	}
end

function YearCardSignin2026ViewPresentor:buildViews()
	return {
		YearCardSignin2026View.New()
	}
end

return YearCardSignin2026ViewPresentor
