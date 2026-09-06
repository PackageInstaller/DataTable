-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardInstallment2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardInstallment2023ViewPresentor", package.seeall)

local YearCardInstallment2023ViewPresentor = class("YearCardInstallment2023ViewPresentor", ViewPresentor)

function YearCardInstallment2023ViewPresentor:ctor()
	YearCardInstallment2023ViewPresentor.super.ctor(self)
end

function YearCardInstallment2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardInstallment2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/main/yearcardinstallment2023view.prefab"
	}
end

function YearCardInstallment2023ViewPresentor:buildViews()
	return {
		YearCardInstallment2023View.New()
	}
end

return YearCardInstallment2023ViewPresentor
