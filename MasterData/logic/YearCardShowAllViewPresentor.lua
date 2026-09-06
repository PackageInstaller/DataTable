-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardShowAllViewPresentor.lua

module("logic.extensions.yearcard.view.2022.YearCardShowAllViewPresentor", package.seeall)

local YearCardShowAllViewPresentor = class("YearCardShowAllViewPresentor", ViewPresentor)

function YearCardShowAllViewPresentor:ctor()
	YearCardShowAllViewPresentor.super.ctor(self)
end

function YearCardShowAllViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardShowAllViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/yearcardnewshowallview.prefab"
	}
end

function YearCardShowAllViewPresentor:buildViews()
	return {
		YearCardShowAllView.New()
	}
end

return YearCardShowAllViewPresentor
