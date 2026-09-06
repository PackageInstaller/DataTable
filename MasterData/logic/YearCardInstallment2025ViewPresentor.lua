-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardInstallment2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardInstallment2025ViewPresentor", package.seeall)

local YearCardInstallment2025ViewPresentor = class("YearCardInstallment2025ViewPresentor", ViewPresentor)

function YearCardInstallment2025ViewPresentor:ctor()
	YearCardInstallment2025ViewPresentor.super.ctor(self)
end

function YearCardInstallment2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardInstallment2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardinstallment2025view.prefab"
	}
end

function YearCardInstallment2025ViewPresentor:buildViews()
	return {
		YearCardInstallment2025View.New()
	}
end

return YearCardInstallment2025ViewPresentor
