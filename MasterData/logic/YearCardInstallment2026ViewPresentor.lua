-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardInstallment2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardInstallment2026ViewPresentor", package.seeall)

local YearCardInstallment2026ViewPresentor = class("YearCardInstallment2026ViewPresentor", ViewPresentor)

function YearCardInstallment2026ViewPresentor:ctor()
	YearCardInstallment2026ViewPresentor.super.ctor(self)
end

function YearCardInstallment2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardInstallment2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardinstallment2026view.prefab"
	}
end

function YearCardInstallment2026ViewPresentor:buildViews()
	return {
		YearCardInstallment2026View.New()
	}
end

return YearCardInstallment2026ViewPresentor
