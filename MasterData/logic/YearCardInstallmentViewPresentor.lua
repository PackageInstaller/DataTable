-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardInstallmentViewPresentor.lua

module("logic.extensions.yearcard.view.2022.YearCardInstallmentViewPresentor", package.seeall)

local YearCardInstallmentViewPresentor = class("YearCardInstallmentViewPresentor", ViewPresentor)

function YearCardInstallmentViewPresentor:ctor()
	YearCardInstallmentViewPresentor.super.ctor(self)
end

function YearCardInstallmentViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardInstallmentViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/ycinstallmentview.prefab"
	}
end

function YearCardInstallmentViewPresentor:buildViews()
	return {
		YearCardInstallmentView.New()
	}
end

return YearCardInstallmentViewPresentor
