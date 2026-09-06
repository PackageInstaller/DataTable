-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardInstallment2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardInstallment2024ViewPresentor", package.seeall)

local YearCardInstallment2024ViewPresentor = class("YearCardInstallment2024ViewPresentor", ViewPresentor)

function YearCardInstallment2024ViewPresentor:ctor()
	YearCardInstallment2024ViewPresentor.super.ctor(self)
end

function YearCardInstallment2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardInstallment2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/main/yearcardinstallment2024view.prefab"
	}
end

function YearCardInstallment2024ViewPresentor:buildViews()
	return {
		YearCardInstallment2024View.New()
	}
end

return YearCardInstallment2024ViewPresentor
